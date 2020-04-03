#include "TableModel.h"
#include "Property.h"
#include <QDebug>
#include <QColor>
#include <QDir>

void TableModel::createIncrementalRowLabel() {
    for (int i=0; i< rowCount(); ++i) rowNames_ << QString::number(i);
}

void TableModel::testData()     {
    beginResetModel();
    clearData();

    properties_ = {    new Property{"Name","mogrify"},
                       new Property{"Description","a R/O value", Property::ReadOnly},
                       new Property{"Value",1.0},
                       new Property{"Enabled",true},
                       new Property{"Visible",false,Property::ReadOnly} ,
                       new Property{"Width",500},
                       new Property{"thickness",10, 1, 20},
                       new Property{"Delta",10.2, -20.0, 20.0},
                       new Property{"FG color",QColor("red")},
                       new Property{"BG color",QColor("yellow")},
                       new Property{"Float [ ]",2.22, {1.11, 2.22, 3.33} },
                       new Property{"Search Path ", QDir::homePath() }, };
    properties_.last()->setEditorType(Property::PathEditor);

    columnNames_ << "Name" << "Value";
    createIncrementalRowLabel();
    endResetModel();
    emit columnNamesChanged(columnNames_);
    emit rowNamesChanged(rowNames_);
    emit countChanged(count());
}

void TableModel::clearData() {
    properties_.clear();
    columnNames_.clear();
    rowNames_.clear();
    qDeleteAll(properties_);
}

void TableModel::clear()    {
    beginResetModel();
    clearData();
    endResetModel();
    emit columnNamesChanged(columnNames_);
    emit rowNamesChanged(rowNames_);
    emit countChanged(count());
}

TableModel::TableModel(QObject *parent) : QAbstractTableModel (parent)  {
}

int TableModel::rowCount(const QModelIndex &parent) const   {           Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return properties_.count();
}

int TableModel::columnCount(const QModelIndex &parent) const    {   Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return columnNames().count();
}

QVariant TableModel::data(const QModelIndex &index, int role) const {
    QVariant result;
    if (!index.isValid() || !indexInRange(index)) return result;
    auto property = properties_.at(index.row());
    bool isNameColumn (index.column() == 0);
    switch (role) {
        case CellDataRole:      result = isNameColumn  ?  property->name() :  property->value();
            break;
        case CellTypeRole:      result = isNameColumn  ?  QMetaType::QString : property->type();
            break;
        case CellFlagsRole:     result = isNameColumn  ?  Property::ReadOnly : property->flags();
            break;
        case CellEditorRole:    result = isNameColumn  ?  Property::TextEditor : property->editorType();
            break;
        case CellOptionRole:    result = isNameColumn  ?  QVariant() : property->option();
            break;
        default:
            break;
    }
    return result;
}

QVariant TableModel::headerData(int section, Qt::Orientation orientation, int role) const {
    QVariant result;
    if (role == Qt::DisplayRole) {
        if (orientation == Qt::Horizontal)   result=columnNames_.at(section);
        if (orientation == Qt::Vertical)     result=rowNames_.at(section);
    }
    return result;
}

QHash<int, QByteArray> TableModel::roleNames() const    {
    return {
        {CellDataRole,  "cellData"},
        {CellTypeRole,  "cellType"},
        {CellFlagsRole, "cellFlags"},
        {CellEditorRole,"cellEditor"},
        {CellOptionRole,"cellOption"},
    };
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || !indexInRange(index)) return false;
    switch (role) {
        case CellDataRole:
            if (index.column()== 0)    properties_[index.row()]->setName(value.toString());
            else                       properties_[index.row()]->setValue(value);
            break;
        default:
            return false;
    }

    emit dataChanged(index, index, {role});
    return true;
}

Qt::ItemFlags TableModel::flags(const QModelIndex &index) const { Q_UNUSED(index)
            return Qt::ItemIsEditable;
                                                                }

QStringList TableModel::columnNames() const {
    return columnNames_;
}

QStringList TableModel::rowNames() const {
    return rowNames_;
}

int TableModel::count() const {
    return rowCount();
}

bool TableModel::indexInRange(const QModelIndex &index) const {
    return index.row()>=0 && index.row()<rowCount() && index.column()>=0 && index.column()<columnCount();
}

void TableModel::setColumnNames(QStringList columnNames) {
    if (columnNames_ != columnNames)   emit columnNamesChanged(columnNames_ = columnNames);
}

void TableModel::setRowNames(QStringList rowNames)  {
    if (rowNames_ != rowNames)         emit rowNamesChanged(rowNames_ = rowNames);
}
