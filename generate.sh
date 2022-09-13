#!/bin/bash

# Create files.
touch order.h {stock,broker,sell_stock,buy_stock}.{h,cpp} demo.cpp 

# Populate code.

echo "#pragma once

class IOrder {
    public:
        virtual void Execute() = 0; 
};" > order.h

echo "#pragma once
#include <string>

class Stock {
   public:
        Stock();
        ~Stock();
        void Buy();
        void Sell();

    private:
        std::string m_name;
        int         m_quantity;
        int         m_total;

};" > stock.h

echo "#include <iostream>
#include \"stock.h\"

Stock::Stock()
{
    m_name      = \"domati\";
    m_quantity  = 10;
    m_total     = 0;
    std::cout << \"Created Stock.\n\";
}

Stock::~Stock()
{
    std::cout << \"Destroy Stock.\n\";
}

void Stock::Buy()
{
    m_total += m_quantity;
    std::cout << \"Stock [ Name: \" << m_name << \" Quantity: \" <<  m_quantity << \" Total: \" << m_total << \" ] bought\n\";
}

void Stock::Sell()
{
    m_total -= m_quantity;
    std::cout << \"Stock [ Name: \" << m_name << \" Quantity: \" <<  m_quantity << \" Total: \" << m_total << \" ] sold\n\";
}" > stock.cpp

echo "#pragma once
#include \"order.h\"
#include \"stock.h\"

class BuyStock : public IOrder {
    public:
        BuyStock(Stock*);
        ~BuyStock();

        void Execute();

    private:
        Stock* m_pStock;
};" > buy_stock.h

echo "#include <iostream>
#include \"buy_stock.h\"

BuyStock::BuyStock(Stock *pStock)
{
    m_pStock = pStock;
    std::cout << \"Created BuyStock.\n\";
}

BuyStock::~BuyStock()
{
    std::cout << \"Destroy BuyStock.\n\";
}

void BuyStock::Execute()
{
    m_pStock->Buy();
}" > buy_stock.cpp

echo "#pragma once
#include \"order.h\"
#include \"stock.h\"

class SellStock : public IOrder {
    public:
        SellStock(Stock*);
        ~SellStock();

        void Execute();

    private:
        Stock* m_pStock;
};" > sell_stock.h

echo "#include <iostream>
#include \"sell_stock.h\"
#include \"stock.h\"

SellStock::SellStock(Stock* pStock)
{
    m_pStock = pStock;
    std::cout << \"Created Selltock.\n\";
}

SellStock::~SellStock()
{
    std::cout << \"Destroy Selltock.\n\";
}

void SellStock::Execute()
{
    m_pStock->Sell();
}" > sell_stock.cpp


echo "#include <memory>
#include \"stock.h\"
#include \"buy_stock.h\"
#include \"sell_stock.h\"
#include \"broker.h\"

#define CAST_2VOID_PTR(ptr)(reinterpret_cast<void*>((ptr)))

bool IsValidPointer(void *ptr)
{
    return nullptr != ptr;
}

int main() {
    Stock* pStock     = new Stock;
    bool   bCondition = IsValidPointer(CAST_2VOID_PTR(pStock));

    if (bCondition)
    {
        BuyStock*  pBuyStockOrder  = new BuyStock(pStock);
        SellStock* pSellStockOrder = new SellStock(pStock);
        Broker*    pBroker         = new Broker;

        bCondition = IsValidPointer(CAST_2VOID_PTR(pBuyStockOrder))  &&
                     IsValidPointer(CAST_2VOID_PTR(pSellStockOrder)) &&
                     IsValidPointer(CAST_2VOID_PTR(pBroker));

        if (bCondition)
        {
            pBroker->TakeOrder(pBuyStockOrder);
            pBroker->TakeOrder(pSellStockOrder);
        }

        pBroker->PlaceOrders();

        if (pBroker)
        {
            delete pBroker;
        }
        if (pSellStockOrder)
        {
            delete pSellStockOrder;
        }
        if (pBuyStockOrder)
        {
            delete pBuyStockOrder;
        }
    }

    if (pStock)
    {
        delete pStock;
    }

    return 0;
}" > demo.cpp

echo "#pragma once
#include <iostream>
#include <vector>
#include \"order.h\"

class Broker {
    public:
        Broker();
        ~Broker();

        void TakeOrder(IOrder*);
        void PlaceOrders();

    private:
        std::vector<IOrder*> m_orders;
};" > broker.h

echo "#include \"broker.h\"

Broker::Broker()
{
    std::cout << \"Created Broker.\n\";    
}

Broker::~Broker()
{
    std::cout << \"Destroy Broker.\n\";    
}

void Broker::TakeOrder(IOrder *pOrder)
{
    m_orders.push_back(pOrder);
}

void Broker::PlaceOrders()
{
    for (auto &o : m_orders)
    {
        o->Execute();
    }

    m_orders.clear();
}" > broker.cpp


g++ -o demo demo.cpp stock.cpp buy_stock.cpp sell_stock.cpp broker.cpp

./demo
