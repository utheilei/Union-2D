#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>

#include "qmlhelper.h"
#include "themewindow.h"

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);   //强制开启openGL

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QTranslator translator;
    QLocale locale;
    if( locale.language() == QLocale::English ) {
        translator.load(qApp->applicationDirPath() + "/translation/language_en.qm");
    }
    else if( locale.language() == QLocale::Chinese ) {
        translator.load(qApp->applicationDirPath() + "/translation/language_zh_CN.qm");
    }
    app.installTranslator(&translator);

    QmlHelper qmlHelper;
    qmlRegisterType<ThemeWindow>("an.window", 1, 0, "ThemeWindow");
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
