#pragma once
#include <iostream>
#include <vector>
#include "order.h"

class Broker {
    public:
        Broker();
        ~Broker();

        void TakeOrder(IOrder*);
        void PlaceOrders();

    private:
        std::vector<IOrder*> m_orders;
};
