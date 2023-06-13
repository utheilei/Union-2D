#include "themewindow.h"

#include <QDebug>

ThemeWindow::ThemeWindow(QObject* parent) : QObject(parent)
{

}

ThemeWindow::ThemeType ThemeWindow::theme()
{
    return m_type;
}

void ThemeWindow::setTheme(const ThemeType &type)
{
    if (m_type != type)
    {
        qDebug() << "setTheme" << type;
        m_type = type;
        switch (m_type) {
        case ThemeType::LightTheme:
            setButton(QColor(255, 255, 255, 0.9*255));
            break;
        case ThemeType::DarkTheme:
            setButton(QColor("#000000"));
            break;
        default:
            break;
        }
        emit themeChanged();
    }
}

void ThemeWindow::setButton(const QColor &color)
{
    if (m_buttonColor != color)
    {
        m_buttonColor = color;
        emit buttonChanged();
    }
}

QColor ThemeWindow::button()
{
    return m_buttonColor;
}

void ThemeWindow::ThemeWindow::setWindow(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setBase(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setAlternatebase(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setToolTipBase(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setToolTipText(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setPlaceholderText(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setText(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setLight(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setMidlight(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setButtonText(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setDark(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setMid(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setShadow(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setHighlight(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setHighlightedText(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setLink(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setLinkVisited(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setItemBackgroud(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setTextTitle(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setTextTips(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setTextWaining(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setFrameBorder(const QColor &color)
{

}

void ThemeWindow::ThemeWindow::setFrameShadowBorder(const QColor &color)
{

}

QColor ThemeWindow::window()
{

}

QColor ThemeWindow::base()
{

}

QColor ThemeWindow::alternatebase()
{

}

QColor ThemeWindow::toolTipBase()
{

}

QColor ThemeWindow::toolTipText()
{

}
QColor ThemeWindow::placeholderText()
{

}

QColor ThemeWindow::text()
{

}

QColor ThemeWindow::light()
{

}

QColor ThemeWindow::midlight()
{

}

QColor ThemeWindow::buttonText()
{

}

QColor ThemeWindow::dark()
{

}

QColor ThemeWindow::mid()
{

}

QColor ThemeWindow::shadow()
{

}

QColor ThemeWindow::highlight()
{

}

QColor ThemeWindow::highlightedText()
{

}

QColor ThemeWindow::link()
{

}

QColor ThemeWindow::linkVisited()
{

}

QColor ThemeWindow::itemBackgroud()
{

}

QColor ThemeWindow::textTitle(){

}
QColor ThemeWindow::textTips()
{

}

QColor ThemeWindow::textWaining()
{

}

QColor ThemeWindow::frameBorder()
{

}

QColor ThemeWindow::frameShadowBorder()
{

}

