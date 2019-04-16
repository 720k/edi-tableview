#include "TableModel.h"
#include "Variable.h"
#include <QDebug>
#include <QColor>

void TableModel::testData() {
    beginResetModel();
    m_columnNames.clear();
    m_rowNames.clear();
    qDeleteAll(m_variables);
    m_variables.clear();
    m_variables = {
        new Variable{"alfa","value1","/"},
        new Variable{"beta","a simple value","/"},
        new Variable{"beta.2","a R/O value","/",QVariantList(), Variable::ReadOnly},
        new Variable{"gamma",1.0,"/"},
        new Variable{"delta",true,"/"},
        new Variable{"teta",false,"/",QVariantList(), Variable::ReadOnly},
        new Variable{"omega",-500,"/"},
        new Variable{"ChromaLeft",QColor("red"),"/"},
        new Variable{"ChromaCenter",QColor("green"),"/", QVariantList(),Variable::ReadOnly},
        new Variable{"ChromaRight",QColor("blue"),"/"},
        new Variable{"Float [ ]",2.22,"/",QVariantList() << 1.11 << 2.22 << 3.33, Variable::DomainList},
    };
    m_columnNames << "Name" << "Value";
    for (int i=0; i< m_variables.count(); ++i)        m_rowNames << QString::number(i);
    endResetModel();
    emit columnNamesChanged(m_columnNames);
    emit rowNamesChanged(m_rowNames);
    emit countChanged(count());
}

void TableModel::clear()
{
    beginResetModel();
    m_columnNames.clear();
    m_rowNames.clear();
    qDeleteAll(m_variables);
    m_variables.clear();
    endResetModel();
    emit columnNamesChanged(m_columnNames);
    emit rowNamesChanged(m_rowNames);
    emit countChanged(count());
}

TableModel::TableModel(QObject *parent) : QAbstractTableModel (parent)  {

}

int TableModel::rowCount(const QModelIndex &parent) const   { Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return m_variables.count();
}

int TableModel::columnCount(const QModelIndex &parent) const    {   Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return columnNames().count();
}

QVariant TableModel::data(const QModelIndex &index, int role) const {
    QVariant result;
    if (!index.isValid() || !indexInRange(index)) return result;
    switch (role) {
        case CellDataRole: result = index.column() == 0  ?  m_variables.at(index.row())->name() : m_variables.at(index.row())->value();
            break;
        case CellTypeRole: result = index.column() == 0  ?  QMetaType::QString : m_variables.at(index.row())->type();
            break;
        case CellFlagsRole: result = index.column() == 0  ?  Variable::ReadOnly : m_variables.at(index.row())->flags();
            break;
        case CellDomainRole: result = index.column() == 0  ?  QVariant() : m_variables.at(index.row())->domain();
            break;
        default:
            break;
    }
    return result;
}

QVariant TableModel::headerData(int section, Qt::Orientation orientation, int role) const {
    QVariant result;
    if (role == Qt::DisplayRole) {
        if (orientation == Qt::Horizontal)   result=m_columnNames.at(section);
        if (orientation == Qt::Vertical)     result=m_rowNames.at(section);
    }
    return result;
}

QHash<int, QByteArray> TableModel::roleNames() const    {
    return {
        {CellDataRole,  "cellData"},
        {CellTypeRole,  "cellType"},
        {CellFlagsRole, "cellFlags"},
        {CellDomainRole,"cellDomain"}
    };
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || !indexInRange(index)) return false;
    switch (role) {
        case CellDataRole:
             if (index.column()== 0)    m_variables[index.row()]->setName(value.toString());
             else                       m_variables[index.row()]->setValue(value);
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
    return m_columnNames;
}

QStringList TableModel::rowNames() const {
    return m_rowNames;
}

int TableModel::count() const {
    return rowCount();
}

bool TableModel::indexInRange(const QModelIndex &index) const {
    return index.row()>=0 && index.row()<rowCount() && index.column()>=0 && index.column()<columnCount();
}

void TableModel::setColumnNames(QStringList columnNames) {
    if (m_columnNames != columnNames)   emit columnNamesChanged(m_columnNames = columnNames);
}

void TableModel::setRowNames(QStringList rowNames)  {
    if (m_rowNames != rowNames)         emit rowNamesChanged(m_rowNames = rowNames);
}
