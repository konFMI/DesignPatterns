#include <iostream>
#include "buy_stock.h"

BuyStock::BuyStock(Stock *pStock)
{
    m_pStock = pStock;
    std::cout << "Created BuyStock.\n";
}

BuyStock::~BuyStock()
{
    std::cout << "Destroy BuyStock.\n";
}

void BuyStock::Execute()
{
    m_pStock->Buy();
}

void BuyStock::Configure()
{
    std::cout << "Configure BuyStock.\n";
}
