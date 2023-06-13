#ifndef THEMEWINDOW_H
#define THEMEWINDOW_H

#include <QObject>
#include <QColor>

class ThemeWindow : public QObject
{
    Q_OBJECT
public:
    enum ThemeType
    {
        LightTheme,
        DarkTheme
    };
    Q_ENUM(ThemeType)
    Q_PROPERTY(ThemeType theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(QColor window READ window WRITE setWindow NOTIFY windowChanged)
    Q_PROPERTY(QColor base READ base WRITE setBase NOTIFY baseChanged)
    Q_PROPERTY(QColor alternatebase READ alternatebase WRITE setAlternatebase NOTIFY alternatebaseChanged)
    Q_PROPERTY(QColor toolTipBase READ toolTipBase WRITE setToolTipBase NOTIFY toolTipBaseChanged)
    Q_PROPERTY(QColor toolTipText READ toolTipText WRITE setToolTipText NOTIFY toolTipTextChanged)
    Q_PROPERTY(QColor placeholderText READ placeholderText WRITE setPlaceholderText NOTIFY placeholderTextChanged)
    Q_PROPERTY(QColor text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QColor light READ light WRITE setLight NOTIFY lightChanged)
    Q_PROPERTY(QColor midlight READ midlight WRITE setMidlight NOTIFY midlightChanged)
    Q_PROPERTY(QColor buttonText READ buttonText WRITE setButtonText NOTIFY buttonTextChanged)
    Q_PROPERTY(QColor button READ button WRITE setButton NOTIFY buttonChanged)
    Q_PROPERTY(QColor dark READ dark WRITE setDark NOTIFY darkChanged)
    Q_PROPERTY(QColor mid READ mid WRITE setMid NOTIFY midChanged)
    Q_PROPERTY(QColor shadow READ shadow WRITE setShadow NOTIFY shadowChanged)
    Q_PROPERTY(QColor highlight READ highlight WRITE setHighlight NOTIFY highlightChanged)
    Q_PROPERTY(QColor highlightedText READ highlightedText WRITE setHighlightedText NOTIFY highlightedTextChanged)
    Q_PROPERTY(QColor link READ link WRITE setLink NOTIFY linkChanged)
    Q_PROPERTY(QColor linkVisited READ linkVisited WRITE setLinkVisited NOTIFY linkVisitedChanged)
    Q_PROPERTY(QColor itemBackgroud READ itemBackgroud WRITE setItemBackgroud NOTIFY itemBackgroudChanged)
    Q_PROPERTY(QColor textTitle READ textTitle WRITE setTextTitle NOTIFY textTitleChanged)
    Q_PROPERTY(QColor textTips READ textTips WRITE setTextTips NOTIFY textTipsChanged)
    Q_PROPERTY(QColor textWaining READ textWaining WRITE setTextWaining NOTIFY textWainingChanged)
    Q_PROPERTY(QColor frameBorder READ frameBorder WRITE setFrameBorder NOTIFY frameBorderChanged)
    Q_PROPERTY(QColor frameShadowBorder READ frameShadowBorder WRITE setFrameShadowBorder NOTIFY frameShadowBorderChanged)
    explicit ThemeWindow(QObject* parent = nullptr);

    ThemeType theme();
    void setTheme(const ThemeType &type);

    void setButton(const QColor &color);
    QColor button();

    void setWindow(const QColor &color);
    void setBase(const QColor &color);
    void setAlternatebase(const QColor &color);
    void setToolTipBase(const QColor &color);
    void setToolTipText(const QColor &color);
    void setPlaceholderText(const QColor &color);
    void setText(const QColor &color);
    void setLight(const QColor &color);
    void setMidlight(const QColor &color);
    void setButtonText(const QColor &color);
    void setDark(const QColor &color);
    void setMid(const QColor &color);
    void setShadow(const QColor &color);
    void setHighlight(const QColor &color);
    void setHighlightedText(const QColor &color);
    void setLink(const QColor &color);
    void setLinkVisited(const QColor &color);
    void setItemBackgroud(const QColor &color);
    void setTextTitle(const QColor &color);
    void setTextTips(const QColor &color);
    void setTextWaining(const QColor &color);
    void setFrameBorder(const QColor &color);
    void setFrameShadowBorder(const QColor &color);

    QColor window();
    QColor base();
    QColor alternatebase();
    QColor toolTipBase();
    QColor toolTipText();
    QColor placeholderText();
    QColor text();
    QColor light();
    QColor midlight();
    QColor buttonText();
    QColor dark();
    QColor mid();
    QColor shadow();
    QColor highlight();
    QColor highlightedText();
    QColor link();
    QColor linkVisited();
    QColor itemBackgroud();
    QColor textTitle();
    QColor textTips();
    QColor textWaining();
    QColor frameBorder();
    QColor frameShadowBorder();

signals:
    void themeChanged();
    void windowChanged();
    void baseChanged();
    void alternatebaseChanged();
    void toolTipBaseChanged();
    void toolTipTextChanged();
    void placeholderTextChanged();
    void textChanged();
    void lightChanged();
    void midlightChanged();
    void buttonTextChanged();
    void buttonChanged();
    void darkChanged();
    void midChanged();
    void shadowChanged();
    void highlightChanged();
    void highlightedTextChanged();
    void linkChanged();
    void linkVisitedChanged();
    void itemBackgroudChanged();
    void textTitleChanged();
    void textTipsChanged();
    void textWainingChanged();
    void frameBorderChanged();
    void frameShadowBorderChanged();

private:
    ThemeType m_type = ThemeType::LightTheme;
    QColor m_buttonColor = QColor("#E5E5E5");
    QColor m_window;
    QColor m_base;
    QColor m_alternatebase;
    QColor m_toolTipBase;
    QColor m_toolTipText;
    QColor m_placeholderText;
    QColor m_text;
    QColor m_light;
    QColor m_midlight;
    QColor m_buttonText;
    QColor m_dark;
    QColor m_mid;
    QColor m_shadow;
    QColor m_highlight;
    QColor m_highlightedText;
    QColor m_link;
    QColor m_linkVisited;
    QColor m_itemBackgroud;
    QColor m_textTitle;
    QColor m_textTips;
    QColor m_textWaining;
    QColor m_frameBorder;
    QColor m_frameShadowBorder;
};

#endif // THEMEWINDOW_H
