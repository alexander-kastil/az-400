using System;
using Newtonsoft.Json;

namespace FoodApp
{
    public class PaymentRequest{
        public PaymentRequest() {
            this.Id = Guid.NewGuid().ToString();
        }

        [JsonProperty("Id")]
        public string Id {get;set;}
        [JsonProperty("orderId")]
        public string OrderId {get;set;}
        [JsonProperty("amount")]
        public decimal Amount {get;set;}
        [JsonProperty("paymentInfo")]
        public PaymentInfo PaymentInfo {get;set;}
    }
}