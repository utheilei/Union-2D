#include "qmlhelper.h"
#include "napplicationtheme.h"
#include "model/treemodel.h"
#include "model/tablemodel.h"
#include "componentloader.h"
#include "textdocument.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QProcess>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);   //强制开启openGL

    QGuiApplication app(argc, argv);

    QProcess process;
    process.start(QGuiApplication::applicationDirPath() + "/httpserver.exe");

    QmlHelper qmlHelper;
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    qmlRegisterType<UApplicationTheme>("utk.UApplicationTheme", 1, 0, "UApplicationTheme");
    qmlRegisterType<TreeModel>("utk.model", 1, 0, "TreeModel");
    qmlRegisterType<TableModel>("utk.model", 1, 0, "TableModel");
    qmlRegisterType<FuzzyFilterProxyModel>("utk.model", 1, 0, "FuzzyFilterProxyModel");
    qmlRegisterType<ComponentLoader>("utk.component", 1, 0, "ComponentLoader");
    qmlRegisterType<QuickTextDocument>("utk.window", 1, 0, "QuickTextDocument");
    qmlRegisterSingletonType(QStringLiteral("qrc:/qml/controls/UTheme.qml"), "utk.window", 1, 0, "UTheme");

    engine.rootContext()->setContextProperty("qmlHelper", &qmlHelper);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject * obj, const QUrl & objUrl)
    {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QObject::connect(&qmlHelper, &QmlHelper::languageChanged,
                     &engine, &QQmlApplicationEngine::retranslate);

    engine.load(url);

    return app.exec();
}
