#ifndef VARIABLE_H
#define VARIABLE_H

#include <QObject>
#include <QVariant>

class Property : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString      name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QVariant     value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString      path READ path WRITE setPath)
    Q_PROPERTY(int          flags READ flags WRITE setFlags NOTIFY flagsChanged)
    Q_PROPERTY(QVariantMap  option READ option WRITE setOption NOTIFY optionChanged)
    Q_PROPERTY(int          editorType READ editorType WRITE setEditorType NOTIFY editorTypeChanged)
    Q_ENUMS(FlagType)
    Q_ENUMS(EditorType)
public:
    enum        FlagType {ReadOnly=1};
    enum        EditorType {TextEditor,NumberEditor,BoolEditor,ColorEditor,ListEditor,PathEditor};

    explicit    Property();
    explicit    Property(const QString &name, const QVariant &value, int flags=0);
    explicit    Property(const QString &name, const QVariant &value, const QVariantMap& option, int flags=0);
    explicit    Property(const QString& name, const QVariant& value, const QVariantList& domain, int flags=0);
    explicit    Property(const QString& name, int value, int min, int max, int flags=0);
    explicit    Property(const QString& name, double value, double min, double max, int flags=0);

    QString     name() const;
    QVariant    value() const;
    QVariant::Type type() const;
    QString     path() const;
    int         flags() const;
    int         editorType() const;
    QVariantMap option() const;

signals:
    void        nameChanged(QString name);
    void        valueChanged(QVariant value);
    void        flagsChanged(int flags);
    void        editorTypeChanged(int editorType);
    void        optionChanged(QVariantMap option);

public slots:
    void        setName(QString name);
    void        setValue(QVariant value);
    void        setPath(QString path);
    void        setFlags(int flags);
    void        setEditorType(int editorType);
    void        setOption(QVariantMap option);

protected:
    int         suitableEditor() const;
private:
    QString     name_;
    QVariant    value_;
    QString     path_; // deprecated
    int         flags_;
    int         editorType_;
    QVariantMap option_;
};

#endif // VARIABLE_H
