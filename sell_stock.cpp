#include <iostream>
#include "sell_stock.h"
#include "stock.h"

SellStock::SellStock(Stock* pStock)
{
    m_pStock = pStock;
    std::cout << "Created Selltock.\n";
}

SellStock::~SellStock()
{
    std::cout << "Destroy Selltock.\n";
}

void SellStock::Execute()
{
    m_pStock->Sell();
}

void SellStock::Configure()
{
    std::cout << "Configure SellStock.\n";
}
