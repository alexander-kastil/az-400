using System;
using Newtonsoft.Json;

namespace FoodApp
{
        public class OrderEvent : IOrderEvent
    {
        public OrderEvent(){
            Id = Guid.NewGuid().ToString();
            Timestamp = DateTime.UtcNow;
        }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("orderId")]
        public string OrderId { get; set; }

        [JsonProperty("customerId")]
        public string CustomerId { get; set; }

        [JsonProperty("eventType")]
        public string EventType { get; set; }

        [JsonProperty("data")]
        public object Data { get; set; }

        [JsonProperty("timestamp")]
        public DateTime Timestamp { get; private set; }
    }
}