#include "TableModel.h"

#include "MyType.h"
#include "Property.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QDebug>



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(QT_ICON_PATH)); // iconless on taskbar? not anymore.

    qmlRegisterType<TableModel>     ("App.Class", 0, 1, "TableModel");
    qmlRegisterType<Property>       ("App.Class", 0, 1, "Property");
    qmlRegisterUncreatableMetaObject(MetaTypeNamespace::staticMetaObject, "App.Class", 0, 1, "MetaType", "Access to enums & flags only");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/__main.qml")));
    if (engine.rootObjects().isEmpty())     return -1;

    return app.exec();
}
