using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace FoodApp
{
    public class Order 
    {
        public Order()
        {
            Id = Guid.NewGuid().ToString();
            Items = new List<OrderItem>();
            Events = new List<OrderEvent>();
            Timestamp = DateTime.UtcNow;
        }

        [JsonProperty("id")]
        public string Id { get; set; }
        [JsonProperty("type")]
        public string Type { get; set; }
        [JsonProperty("total")]
        public decimal Total { get; set; }
        [JsonProperty("customer")]
        public Customer Customer { get; set; }
        [JsonProperty("shippingAddress")]
        public Address ShippingAddress { get; set; }
        [JsonProperty("payment")]
        public PaymentInfo Payment { get; set; }
        [JsonProperty("items")]
        public List<OrderItem> Items { get; set; }
        [JsonProperty("status")]
        public string Status { get; set; }
        [JsonProperty("events")]
        public List<OrderEvent> Events { get; set; }
        [JsonProperty("timestamp")]
        public DateTime Timestamp { get; set; }
    }
}