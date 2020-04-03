#ifndef VARIABLE_H
#define VARIABLE_H

#include <QObject>
#include <QVariant>

class Variable : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QVariant value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription)
    Q_PROPERTY(QString path READ path WRITE setPath)
    Q_PROPERTY(int flags READ flags WRITE setFlags NOTIFY flagsChanged)
    Q_ENUMS(FlagType)
    Q_PROPERTY(QVariantList domain READ domain WRITE setDomain NOTIFY domainChanged)
public:
    explicit    Variable(QObject *parent = nullptr);
                Variable(const QString& name, const QVariant& value, const QString& path="",const QVariantList& domain=QVariantList(), int flags=0, QObject *parent = nullptr);
    QString     name() const;
    QVariant    value() const;
    QVariant::Type type() const;
    QString     description() const;
    QString     path() const;
    enum        FlagType {ReadOnly=1,DomainList=2, };
    int         flags() const;
    QVariantList domain() const;

signals:
    void        nameChanged(QString name);
    void        valueChanged(QVariant value);
    void        flagsChanged(int flags);
    void        domainChanged(QVariantList domain);

public slots:
    void        setName(QString name);
    void        setValue(QVariant value);
    void        setDescription(QString description);
    void        setPath(QString path);
    void        setFlags(int flags);
    void setDomain(QVariantList domain);

private:
    QString     m_name;
    QVariant    m_value;
    QString     m_description;
    QString     m_path;
    int         m_flags;
    QVariantList m_domain;
};

#endif // VARIABLE_H
