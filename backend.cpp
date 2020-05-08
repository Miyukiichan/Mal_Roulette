#include "backend.h"
#include <QDesktopServices>
#include <QUrl>

Backend::Backend(QObject *parent) : QObject(parent) {}

void Backend::go_to_mal(QString url) {
    QDesktopServices::openUrl(QUrl(url));
}
