#include "model.h"
#include <QDebug>



Model::Model(QObject *parent) : QAbstractListModel(parent)
{

}

void Model::addItem(const FriendObject &newItem)
{
    beginInsertRows(QModelIndex(),
    rowCount(), //номер строки вставки
    rowCount()); //номер строки, соответствующей концу вставляемого участка
    friends << newItem; //вставка нового элемента данных
    endInsertRows();

}

int Model::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent); //скрывает сообщение о том, что параметр не используется
    return friends.count();
}

QHash<int, QByteArray> Model::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[name] = "name";
    roles[secondName] = "secondName";
    roles[online] = "online";
    roles[city] = "city";
    roles[photo] = "photo";
    roles[id] = "idU";
    roles[sex] = "sex";
    roles[status] = "status";
    roles[domain] = "domain";

    return roles;
}

QVariant Model::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || (index.row() >= friends.count()))
    return QVariant();

    const FriendObject & itemToReturn = friends[index.row()];

    if (role == name)
    return itemToReturn.getName();
    else if (role == secondName)
    return itemToReturn.getSecondName();
    else if (role == online)
    return itemToReturn.getOnlineStatus();
    else if (role == city)
    return itemToReturn.getCity();
    else if (role == photo)
    return itemToReturn.getPhoto();
    else if (role == id)
    return itemToReturn.getId();
    else if (role == sex)
    return itemToReturn.getSex();
    else if (role == domain)
    return itemToReturn.getDomain();
    else if (role == status)
    return itemToReturn.getStatus();

    return QVariant();
}

QVariantMap Model::get(int idx) const
{
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
    map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;

}

void Model::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    friends.clear();
    endRemoveRows();
}



FriendObject::FriendObject(const QString p_name,
                           const QString p_secondName,
                           bool p_online,
                           const QString p_city,
                           const QString p_photo,
                           const int p_id,
                           const QString p_domain,
                           const QString p_sex,
                           const QString p_status)

    :m_name(p_name), m_secondName(p_secondName), m_online(p_online),
      m_city(p_city), m_photo(p_photo), m_id(p_id),
      m_domain(p_domain), m_sex(p_sex), m_status(p_status)
{

}

QString FriendObject::getName() const
{
    return m_name;
}

QString FriendObject::getSecondName() const
{
    return m_secondName;
}

bool FriendObject::getOnlineStatus() const
{
    return m_online;
}

QString FriendObject::getCity() const
{
    return m_city;
}

QString FriendObject::getPhoto() const
{
    return m_photo;
}

int FriendObject::getId() const
{
    return m_id;
}

QString FriendObject::getSex() const
{
    return m_sex;
}

QString FriendObject::getStatus() const
{
    return  m_status;
}

QString FriendObject::getDomain() const
{
    return m_domain;
}
