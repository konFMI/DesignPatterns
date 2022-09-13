#include <memory>
#include "stock.h"
#include "buy_stock.h"
#include "sell_stock.h"
#include "broker.h"

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
}
