#pragma once
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

};
