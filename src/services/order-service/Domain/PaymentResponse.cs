using System;
using Newtonsoft.Json;

namespace FoodApp
{
    public class PaymentResponse{
        public PaymentResponse()
        {
            this.Id = Guid.NewGuid().ToString();
        }

        [JsonProperty("Id")]
        public string Id { get; set; }
        [JsonProperty("orderId")]
        public string OrderId { get; set; }
        [JsonProperty("status")]
        public string Status { get; set; }
        [JsonProperty("data")]
        public object Data { get; set; }
    }
}