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
    QColor m_window = QColor("#F8F8F8");
    QColor m_base = QColor("#FFFFFF");
    QColor m_alternatebase = QColor(0, 0, 0, 0.03*255);
    QColor m_toolTipBase = QColor(255, 255, 255, 0.8*255);
    QColor m_toolTipText = QColor("#000000");
    QColor m_placeholderText = QColor(85, 85, 85, 0.4*255);
    QColor m_text = QColor("#414D68");
    QColor m_light = QColor("#E6E6E6");
    QColor m_midlight = QColor("#E5E5E5");
    QColor m_buttonText = QColor("#414D68");
    QColor m_dark = QColor("#E3E3E3");
    QColor m_mid = QColor("#E4E4E4");
    QColor m_shadow = QColor(0, 0, 0, 0.05*255);
    QColor m_highlight = QColor("#0081FF");
    QColor m_highlightedText = QColor("#FFFFFF");
    QColor m_link = QColor("#0082FA");
    QColor m_linkVisited = QColor("#AD4579");
    QColor m_itemBackgroud = QColor(0, 0, 0, 0.03*255);
    QColor m_textTitle = QColor("#001A2E");
    QColor m_textTips = QColor("#8AA1B4");
    QColor m_textWaining = QColor("#FF5736");
    QColor m_frameBorder = QColor(0, 0, 0, 0.05*255);
    QColor m_frameShadowBorder = QColor(0, 0, 0, 0.1*255);
};

#endif // THEMEWINDOW_H
