using System;

namespace FoodApp
{
    public interface IOrderEvent
    {
        string Id { get; }
        DateTime Timestamp { get; }
        string OrderId { get; set; }
        string CustomerId { get; set; }
        string EventType { get; set; }
        object Data { get; set; }
    }
}