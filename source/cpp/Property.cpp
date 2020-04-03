#include "Property.h"
#include "MyType.h"

#include <QtGlobal>



Property::Property() : QObject(), name_(""), value_(""), path_(""), flags_(0)  {
}

Property::Property(const QString &name, const QVariant &value, int flags) : QObject(), name_(name), value_(value), path_(""), flags_(flags)  {
    editorType_=suitableEditor();
}

Property::Property(const QString &name, const QVariant &value, const QVariantMap &option, int flags)
    : Property (name, value,flags) {
    option_ = option;
}

Property::Property(const QString &name, const QVariant &value, const QVariantList &domain, int flags)
    : Property(name,value,QVariantMap{{"values",domain}},flags)  {
    editorType_ = ListEditor;
}

Property::Property(const QString &name, int value, int min, int max, int flags)
    : Property(name, value,  {{"min", min},{"max", max}},flags)   {
    editorType_ = NumberEditor;
}

Property::Property(const QString &name, double value, double min, double max, int flags)
    : Property(name, value, {{"min",min},{"max",max}}, flags)   {
    editorType_ = NumberEditor;
}

QString Property::name() const  {
    return name_;
}
QVariant Property::value() const {
    return value_;
}
QVariant::Type Property::type() const   {
    return value_.type();
}
QString Property::path() const  {
    return path_;
}
int Property::flags() const {
    return flags_;
}
int Property::editorType() const {
    return editorType_;
}

QVariantMap Property::option() const {
    return option_;
}

void Property::setName(QString name)    {
    if (name_ != name) emit nameChanged(name_ = name);
}
void Property::setValue(QVariant value) {
    if (value_ != value)    emit valueChanged(value_ = value);
}
void Property::setPath(QString path)    {
    path_ = path;
}
void Property::setFlags(int flags)  {
    if (flags_ != flags)   emit flagsChanged(flags_ = flags);
}
void Property::setEditorType(int EditorType) {
    if (editorType_ != EditorType)     emit editorTypeChanged(editorType_ = EditorType);
}

void Property::setOption(QVariantMap option) {
    if (option_ != option)  emit optionChanged(option_ = option);
}

using namespace  MetaTypeNamespace;


int Property::suitableEditor() const {
    unsigned int type = value_.type();
    static QVector<unsigned int> numerical { Type::Int,Type::UInt,Type::LongLong ,Type::ULongLong, Type::Double,Type::Long,Type::Short,Type::ULong,Type::UShort,Type::Float,};
    if (type == Type::Bool)             return BoolEditor;
    if (type == Type::QColor)           return ColorEditor;
    if (numerical.contains(type))       return NumberEditor;
    return TextEditor;
}

