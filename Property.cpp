#include "Variable.h"


Variable::Variable(QObject *parent) : QObject(parent), m_flags(0)   {
}

Variable::Variable(const QString &name, const QVariant &value, const QString &path, const QVariantList &domain, int flags, QObject *parent) : Variable(parent)  {
    m_name=name;
    m_value=value;
    m_path=path;
    m_flags=flags;
    m_domain=domain;
//    if (!m_domain.isEmpty()) m_flags |= Variable::DomainList;
}

QString Variable::name() const  {
    return m_name;
}

QVariant Variable::value() const {
    return m_value;
}

QVariant::Type Variable::type() const   {
    return m_value.type();
}

QString Variable::description() const   {
    return m_description;
}

QString Variable::path() const  {
    return m_path;
}

int Variable::flags() const {
    return m_flags;
}

QVariantList Variable::domain() const {
    return m_domain;
}

void Variable::setName(QString name)    {
    if (m_name != name) emit nameChanged(m_name = name);
}

void Variable::setValue(QVariant value) {
    if (m_value != value)    emit valueChanged(m_value = value);
}

void Variable::setDescription(QString description)  {
    m_description = description;
}

void Variable::setPath(QString path)    {
    m_path = path;
}

void Variable::setFlags(int flags)  {
    if (m_flags != flags)   emit flagsChanged(m_flags = flags);
}

void Variable::setDomain(QVariantList domain) {
    if (m_domain != domain)     emit domainChanged(m_domain = domain);
}

