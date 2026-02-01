using Newtonsoft.Json;

namespace FoodApp
{
    public class Customer
    {
        [JsonProperty("Id")]
        public string Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("email")]
        public string EMail { get; set; }
        [JsonProperty("phone")]
        public string Phone { get; set; }
    }
}