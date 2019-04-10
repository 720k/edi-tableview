#include "TableModel.h"
#include <QDebug>

void TableModel::testData() {
    beginResetModel();
    m_columnNames.clear();
    m_rowNames.clear();
    m_columnNames << "Name" << "Value";
    m_rowNames << "1" << "2" << "3" << "4";
    m_data = {
    {"hello","world"},
    {"think","twice"},
    {"before","speaking"},
    {"love","cats"},
    };
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
    m_data.clear();
    endResetModel();
    emit columnNamesChanged(m_columnNames);
    emit rowNamesChanged(m_rowNames);
    emit countChanged(count());
}

TableModel::TableModel(QObject *parent) : QAbstractTableModel (parent)  {

}

int TableModel::rowCount(const QModelIndex &parent) const   { Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return m_data.count();
}

int TableModel::columnCount(const QModelIndex &parent) const    {   Q_UNUSED(parent)
    if (parent.isValid())   return 0;
    return columnNames().count();
}

QVariant TableModel::data(const QModelIndex &index, int role) const {
    QVariant result;
    if (!index.isValid() || !indexInRange(index) || role != CellDataRole) return result;
    switch (role) {
        case CellDataRole: result = index.column() == 0  ? m_data.value(index.row()).first : m_data.value(index.row()).second;
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
        {CellDataRole, "cellData"},
    };
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || !indexInRange(index)) return false;
    switch (role) {
        case CellDataRole:
             if (index.column()== 0)    m_data[index.row()].first = value.toString();
             else                       m_data[index.row()].second = value;
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
