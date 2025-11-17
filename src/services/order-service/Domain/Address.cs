using Newtonsoft.Json;

namespace FoodApp
{
    public record Address
    {
        [JsonProperty("street")]
        public string Street { get; set; }
        [JsonProperty("zipCode")]
        public string ZipCode { get; set; }
        [JsonProperty("city")]
        public string City { get; set; }
        [JsonProperty("country")]
        public string Country { get; set; }
    }
}