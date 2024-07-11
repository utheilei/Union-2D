#include "qmlhelper.h"
#include "napplicationtheme.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);   //强制开启openGL

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    QmlHelper qmlHelper;
    qmlRegisterType<UApplicationTheme>("utk.UApplicationTheme", 1, 0, "UApplicationTheme");
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
