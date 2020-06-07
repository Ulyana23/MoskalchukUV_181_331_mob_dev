#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QAbstractItemModel>

class FriendObject
{
public:
    FriendObject();
    FriendObject(const QString p_name,
                 const QString p_secondName,
                 bool p_online,
                 const QString p_city,
                 const QString p_photo,
                 const int p_id,
                 const QString p_domain,
                 const QString p_sex,
                 const QString p_status);

    QString getName() const;
    QString getSecondName() const;
    bool getOnlineStatus() const;
    QString getCity() const;
    QString getPhoto() const;
    int getId() const;
    QString getSex() const;
    QString getStatus() const;
    QString getDomain() const;



private:
    QString m_name;
    QString m_secondName;
    bool m_online;
    QString m_city;
    QString m_photo;
    int m_id;
    QString m_domain;
    QString m_sex;
    QString m_status;
};

//###########################################################################################

class Model : public QAbstractListModel
{
    Q_OBJECT
public:
    enum enmRoles {
        name = Qt::UserRole + 1,
        secondName,
        online,
        city,
        photo,
        id,
        sex,
        status,
        domain
    };

    explicit Model(QObject *parent = nullptr);
    void addItem(const FriendObject & newItem);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    QVariantMap get(int idx) const;
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<FriendObject> friends;

};

#endif // MODEL_H
