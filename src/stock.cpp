#include <iostream>
#include "../api/stock.h"

Stock::Stock()
{
    m_name      = "domati";
    m_quantity  = 10;
    std::cout << "Created Stock.\n";
}

Stock::~Stock()
{
    std::cout << "Destroy Stock.\n";
}

void Stock::Buy()
{
    std::cout << "Stock [ Name: " << m_name << " Quantity: " <<  m_quantity << " ] bought\n";
}

void Stock::Sell()
{
    std::cout << "Stock [ Name: " << m_name << " Quantity: " <<  m_quantity << " ] sold\n";
}
