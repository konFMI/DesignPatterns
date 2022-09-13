#pragma once
#include "order.h"
#include "stock.h"

class BuyStock : public IOrder {
    public:
        BuyStock(Stock*);
        ~BuyStock();

        virtual void Execute();
        virtual void Configure();

    private:
        Stock* m_pStock;
};
