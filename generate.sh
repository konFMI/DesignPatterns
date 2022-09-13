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

};" > stock.h

echo "#include <iostream>
#include \"stock.h\"

Stock::Stock()
{
    m_name      = \"domati\";
    m_quantity  = 10;
    std::cout << \"Created Stock.\n\";
}

Stock::~Stock()
{
    std::cout << \"Destroy Stock.\n\";
}

void Stock::Buy()
{
    std::cout << \"Stock [ Name: \" << m_name << \"Quantity: \" <<  m_quantity << \" ] bought\n\";
}

void Stock::Sell()
{
    std::cout << \"Stock [ Name: \" << m_name << \"Quantity: \" <<  m_quantity << \" ] sold\n\";
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

template <typename T>
bool IsValidPointer(std::unique_ptr<T>& ptr)
{
    return nullptr != ptr.get();
}

int main() {
    std::unique_ptr<Stock> pStock = std::make_unique<Stock>();
    bool   bCondition = IsValidPointer(pStock);

    if (bCondition)
    {
        std::unique_ptr<BuyStock>  pBuyStockOrder  = std::make_unique<BuyStock>(pStock.get());
        std::unique_ptr<SellStock> pSellStockOrder = std::make_unique<SellStock>(pStock.get());
        std::unique_ptr<Broker>    pBroker         = std::make_unique<Broker>();

        bCondition = IsValidPointer(pBuyStockOrder)  &&
                     IsValidPointer(pSellStockOrder) &&
                     IsValidPointer(pBroker);

        if (bCondition)
        {
            pBroker->TakeOrder(pBuyStockOrder.get());
            pBroker->TakeOrder(pBuyStockOrder.get());
            pBroker->TakeOrder(pBuyStockOrder.get());
            pBroker->TakeOrder(pBuyStockOrder.get());
            pBroker->TakeOrder(pBuyStockOrder.get());
            pBroker->TakeOrder(pSellStockOrder.get());
        }

        pBroker->PlaceOrders();
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
