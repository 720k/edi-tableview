#include "TableModel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<TableModel>("App.Class", 0, 1, "TableModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/__main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
