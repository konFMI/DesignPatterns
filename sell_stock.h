#pragma once
#include "order.h"
#include "stock.h"

class SellStock : public IOrder {
    public:
        SellStock(Stock*);
        ~SellStock();

        virtual void Execute();
        virtual void Configure();

    private:
        Stock* m_pStock;
};
