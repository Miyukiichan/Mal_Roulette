var statuses = {}
statuses["1"] = "Watching"
statuses["2"] = "Completed"
statuses["3"] = "On Hold"
statuses["4"] = "Dropped"
statuses["6"] = "Plan to Watch"

var json_text;
var current_user = ""
var mal_link = ""

/* Get html source of MAL list based on the provided username and parse the embedded json data*/
function getJson(username) {
    if (json_text && username === current_user) {
        return json_text
    }
    current_user = username
    //Get the list webpage
    var url = "https://myanimelist.net/animelist/" + username
    var request = new XMLHttpRequest()
    request.open("GET", url, false)
    request.send(null)
    var text = request.responseText

    //Find line with all the data
    text = text.split('\n')
    var found = false
    for (var i = 0; i < text.length; i++) {
        var line = text[i]
        if (line.includes("list-table\"")) {
            text = line
            found = true;
            break;
        }
    }

    //Invalid username or MAL unreachable
    if (!found)
        return null

    //Clean string for json parsing
    text = text.replace(/^.*\[/, "{ \"data\" : [")
    text = text.replace(/\">$/,"}");
    text = text.replace(/\&quot\;/g, "\"")
    json_text = JSON.parse(text)
    return json_text
    //console.log(text)
}

/*Returns whether or not to include a show with a given status depending on the checkbox configuration*/
function getActive(status) {
    switch (status) {
        case "Watching":
            if (!watching_checkbox.checked)
                return false
            break;

        case "Completed":
            if (!completed_checkbox.checked)
                return false
            break

        case "On Hold":
            if (!on_hold_checkbox.checked)
                return false
            break

        case "Dropped":
            if (!dropped_checkbox.checked)
                return false
            break

        case "Plan to Watch":
            if (!plan_to_watch_checkbox.checked)
                return false
            break
    }
    return true
}

function displayResult(json) {
    json_text = json
    var titles = new Array
    var statuses = new Array
    var urls = new Array
    //Go through the json elements and display the desired items in the list
    for (var i = 0; i < json_text.data.length; i++) {
        var t = json_text.data[i].anime_title
        var s = json_text.data[i].status
        var u = json_text.data[i].anime_url
        s = Json.statuses[s]
        if (Json.getActive(s)) {
            titles.push(t)
            statuses.push(s)
            urls.push(u)
        }
    }
    resultRectangle.visible = true
    titleLabel.visible = true
    statusLabel.visible = true
    if (!titles.length) {
        titleLabel.text = "No anime of this type found"
        statusLabel.text = ""
        viewMalButton.visible = false
        return
    }
    var rand = Math.floor(Math.random() * (titles.length - 1));
    var anime_title = titles[rand]
    var stat = statuses[rand]
    var url = urls[rand]
    url = url.replace("\\", "")
    url = "https://myanimelist.net" + url
    mal_link = url
    titleLabel.text = anime_title
    statusLabel.text = stat
    viewMalButton.visible = true
    var title_width = titleLabel.width + 20
    var ideal_width = 234;
    resultRectangle.width = ideal_width < title_width ? title_width : ideal_width
}

WorkerScript.onMessage = function(msg) {
    var j = getJson(msg.user)
    WorkerScript.sendMessage({"done": j})
}

function send_to_mal() {
    backend.go_to_mal(mal_link)
}
