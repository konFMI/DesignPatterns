#pragma once

class IOrder {
    public:
        virtual void Execute() = 0; 
        virtual void Configure() = 0;
};
