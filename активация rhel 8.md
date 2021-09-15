# Инструкция по активации

## 1. Активация rhel 8
Заходим на сайт rhel http://www.redhat.com/products/enterprise-linux/server/download.html

Ристрируемся.

Заходим в терминал под своей учетной записью.

    # subscription-manager register --username rh-portal-user
где rh-portal-user — имя пользователя, которое мы указывали при регистрации аккаунта на сайте www.redhat.com

Дальше нужно ввести пароль.

Затем нужно привязать подписку, заходим на портал Red Hat

Subscriptions -> Subscription Management -> Unit

должны там увидеть нашу систему

нажимаем «Attach a subscription«.

Из списка выбираем нужную подписку, в зависимости от того, виртуальная система или физическая.
Дальше лезем в терминал и пишем команду:

    # subscription-manager subscribe --auto
и должны получить :

    Installed Product Current Status:
    Product Name:           Red Hat Enterprise Linux Server
    Status:                 Subscribed
теперь просмотрим список активных подписок:

    # subscription-manager list --available
и получаем 
        
    +-------------------------------------------+
        Available Subscriptions
    +-------------------------------------------+
    Subscription Name:      30 Day Self-Supported Red Hat Enterprise Linux Server, (2 sockets) (Up to 1 guest) Evaluation
    SKU:                    RH0111111
    Pool Id:                11111111dddddddd33333333hhhhhhhh77777777
    Quantity:               1
    Service Level:          Self-support
    Service Type:           L1-L3
    Multi-Entitlement:      No
    Ends:                   18/08/2021
    System Type:            Physical
