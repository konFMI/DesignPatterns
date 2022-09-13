#pragma once

class IOrder {
    public:
        virtual ~IOrder() = default;

        virtual void Execute() = 0; 
        virtual void Configure() = 0;
};
