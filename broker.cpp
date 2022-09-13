#include "broker.h"

Broker::Broker()
{
    std::cout << "Created Broker.\n";    
}

Broker::~Broker()
{
    std::cout << "Destroy Broker.\n";    
}

void Broker::TakeOrder(IOrder *pOrder)
{
    pOrder->Configure();
    m_orders.push_back(pOrder);
}

void Broker::PlaceOrders()
{
    for (auto &o : m_orders)
    {
        o->Execute();
    }

    m_orders.clear();
}
