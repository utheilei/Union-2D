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
        switch (m_type)
        {
            case ThemeType::LightTheme:
                setButton(QColor("#E5E5E5"));
                setWindow(QColor("#F8F8F8"));
                setBase(QColor("#FFFFFF"));
                setAlternatebase(QColor(0, 0, 0, 0.03 * 255));
                setToolTipBase(QColor(255, 255, 255, 0.8 * 255));
                setToolTipText(QColor("#000000"));
                setPlaceholderText(QColor(85, 85, 85, 0.4 * 255));
                setText(QColor("#414D68"));
                setLight(QColor("#E6E6E6"));
                setMidlight(QColor("#E5E5E5"));
                setButtonText(QColor("#414D68"));
                setDark(QColor("#E3E3E3"));
                setMid(QColor("#E4E4E4"));
                setShadow(QColor(0, 0, 0, 0.05 * 255));
                setHighlight(QColor("#0081FF"));
                setHighlightedText(QColor("#FFFFFF"));
                setLink(QColor("#0082FA"));
                setLinkVisited(QColor("#AD4579"));
                setItemBackgroud(QColor(0, 0, 0, 0.03 * 255));
                setTextTitle(QColor("#001A2E"));
                setTextTips(QColor("#8AA1B4"));
                setTextWaining(QColor("#FF5736"));
                setFrameBorder(QColor(0, 0, 0, 0.05 * 255));
                setFrameShadowBorder(QColor(0, 0, 0, 0.1 * 255));
                break;
            case ThemeType::DarkTheme:
                setButton(QColor("#444444"));
                setWindow(QColor("#252525"));
                setBase(QColor("#282828"));
                setAlternatebase(QColor(0, 0, 0, 0.05 * 255));
                setToolTipBase(QColor(45, 45, 45, 0.8 * 255));
                setToolTipText(QColor("#C0C6D4"));
                setPlaceholderText(QColor(192, 198, 212, 0.4 * 255));
                setText(QColor("#C0C6D4"));
                setLight(QColor("#484848"));
                setMidlight(QColor("#474747"));
                setButtonText(QColor("#C0C6D4"));
                setDark(QColor("#414141"));
                setMid(QColor("#434343"));
                setShadow(QColor(0, 0, 0, 0.05 * 255));
                setHighlight(QColor("#0081FF"));
                setHighlightedText(QColor("#F1F6FF"));
                setLink(QColor("#0082FA"));
                setLinkVisited(QColor("#AD4579"));
                setItemBackgroud(QColor(255, 255, 255, 0.05 * 255));
                setTextTitle(QColor("#C0C6D4"));
                setTextTips(QColor("#6D7C88"));
                setTextWaining(QColor("#9A2F2F"));
                setFrameBorder(QColor(255, 255, 255, 0.1 * 255));
                setFrameShadowBorder(QColor(0, 0, 0, 0.8 * 255));
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
    if (m_window != color)
    {
        m_window = color;
        emit windowChanged();
    }
}

void ThemeWindow::ThemeWindow::setBase(const QColor &color)
{
    if (m_base != color)
    {
        m_base = color;
        emit baseChanged();
    }
}

void ThemeWindow::ThemeWindow::setAlternatebase(const QColor &color)
{
    if (m_alternatebase != color)
    {
        m_alternatebase = color;
        emit alternatebaseChanged();
    }
}

void ThemeWindow::ThemeWindow::setToolTipBase(const QColor &color)
{
    if (m_toolTipBase != color)
    {
        m_toolTipBase = color;
        emit toolTipBaseChanged();
    }
}

void ThemeWindow::ThemeWindow::setToolTipText(const QColor &color)
{
    if (m_toolTipText != color)
    {
        m_toolTipText = color;
        emit toolTipTextChanged();
    }
}

void ThemeWindow::ThemeWindow::setPlaceholderText(const QColor &color)
{
    if (m_placeholderText != color)
    {
        m_placeholderText = color;
        emit placeholderTextChanged();
    }
}

void ThemeWindow::ThemeWindow::setText(const QColor &color)
{
    if (m_text != color)
    {
        m_text = color;
        emit textChanged();
    }
}

void ThemeWindow::ThemeWindow::setLight(const QColor &color)
{
    if (m_light != color)
    {
        m_light = color;
        emit lightChanged();
    }
}

void ThemeWindow::ThemeWindow::setMidlight(const QColor &color)
{
    if (m_midlight != color)
    {
        m_midlight = color;
        emit midlightChanged();
    }
}

void ThemeWindow::ThemeWindow::setButtonText(const QColor &color)
{
    if (m_buttonText != color)
    {
        m_buttonText = color;
        emit buttonTextChanged();
    }
}

void ThemeWindow::ThemeWindow::setDark(const QColor &color)
{
    if (m_dark != color)
    {
        m_dark = color;
        emit darkChanged();
    }
}

void ThemeWindow::ThemeWindow::setMid(const QColor &color)
{
    if (m_mid != color)
    {
        m_mid = color;
        emit midChanged();
    }
}

void ThemeWindow::ThemeWindow::setShadow(const QColor &color)
{
    if (m_shadow != color)
    {
        m_shadow = color;
        emit shadowChanged();
    }
}

void ThemeWindow::ThemeWindow::setHighlight(const QColor &color)
{
    if (m_highlight != color)
    {
        m_highlight = color;
        emit highlightChanged();
    }
}

void ThemeWindow::ThemeWindow::setHighlightedText(const QColor &color)
{
    if (m_highlightedText != color)
    {
        m_highlightedText = color;
        emit highlightedTextChanged();
    }
}

void ThemeWindow::ThemeWindow::setLink(const QColor &color)
{
    if (m_link != color)
    {
        m_link = color;
        emit linkChanged();
    }
}

void ThemeWindow::ThemeWindow::setLinkVisited(const QColor &color)
{
    if (m_linkVisited != color)
    {
        m_linkVisited = color;
        emit linkVisitedChanged();
    }
}

void ThemeWindow::ThemeWindow::setItemBackgroud(const QColor &color)
{
    if (m_itemBackgroud != color)
    {
        m_itemBackgroud = color;
        emit itemBackgroudChanged();
    }
}

void ThemeWindow::ThemeWindow::setTextTitle(const QColor &color)
{
    if (m_textTitle != color)
    {
        m_textTitle = color;
        emit textTitleChanged();
    }
}

void ThemeWindow::ThemeWindow::setTextTips(const QColor &color)
{
    if (m_textTips != color)
    {
        m_textTips = color;
        emit textTipsChanged();
    }
}

void ThemeWindow::ThemeWindow::setTextWaining(const QColor &color)
{
    if (m_textWaining != color)
    {
        m_textWaining = color;
        emit textWainingChanged();
    }
}

void ThemeWindow::ThemeWindow::setFrameBorder(const QColor &color)
{
    if (m_frameBorder != color)
    {
        m_frameBorder = color;
        emit frameBorderChanged();
    }
}

void ThemeWindow::ThemeWindow::setFrameShadowBorder(const QColor &color)
{
    if (m_frameShadowBorder != color)
    {
        m_frameShadowBorder = color;
        emit frameShadowBorderChanged();
    }
}

QColor ThemeWindow::window()
{
    return m_window;
}

QColor ThemeWindow::base()
{
    return m_base;
}

QColor ThemeWindow::alternatebase()
{
    return m_alternatebase;
}

QColor ThemeWindow::toolTipBase()
{
    return m_toolTipBase;
}

QColor ThemeWindow::toolTipText()
{
    return m_toolTipText;
}

QColor ThemeWindow::placeholderText()
{
    return m_placeholderText;
}

QColor ThemeWindow::text()
{
    return m_text;
}

QColor ThemeWindow::light()
{
    return m_light;
}

QColor ThemeWindow::midlight()
{
    return m_midlight;
}

QColor ThemeWindow::buttonText()
{
    return m_buttonText;
}

QColor ThemeWindow::dark()
{
    return m_dark;
}

QColor ThemeWindow::mid()
{
    return m_mid;
}

QColor ThemeWindow::shadow()
{
    return m_shadow;
}

QColor ThemeWindow::highlight()
{
    return m_highlight;
}

QColor ThemeWindow::highlightedText()
{
    return m_highlightedText;
}

QColor ThemeWindow::link()
{
    return m_link;
}

QColor ThemeWindow::linkVisited()
{
    return m_linkVisited;
}

QColor ThemeWindow::itemBackgroud()
{
    return m_itemBackgroud;
}

QColor ThemeWindow::textTitle()
{
    return m_textTitle;
}

QColor ThemeWindow::textTips()
{
    return m_textTips;
}

QColor ThemeWindow::textWaining()
{
    return m_textWaining;
}

QColor ThemeWindow::frameBorder()
{
    return m_frameBorder;
}

QColor ThemeWindow::frameShadowBorder()
{
    return m_frameShadowBorder;
}

