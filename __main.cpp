#include "TableModel.h"

#include "MyType.h"
#include "Variable.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<TableModel>     ("App.Class", 0, 1, "TableModel");
    qmlRegisterType<Variable>       ("App.Class", 0, 1, "Variable");
    qmlRegisterUncreatableMetaObject(MetaTypeNamespace::staticMetaObject, "App.Class", 0, 1, "MetaType", "Access to enums & flags only");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/__main.qml")));
    if (engine.rootObjects().isEmpty())     return -1;

    return app.exec();
}
