namespace FoodApp {

     public class AppConfig : IAppConfig
    {
        public string Title { get; set; }
        public Logging Logging { get; set; }
        public CosmosDB CosmosDB { get; set; }
        public string AllowedHosts { get; set; }
        public ApplicationInsights ApplicationInsights {get;set;}
        public string PUBSUB_NAME { get; set; }
        public string PAYMENT_REQUESTED_TOPIC { get; set; }
        public string PAYMENT_RECEIVED_TOPIC { get; set; }
    }
     public class CosmosDB
    {
        public string AccountEndpoint { get; set; }
        public string AccountKey { get; set; }
        public string DBName { get; set; }
        public string OrderAggregatesContainer { get; set; }
        public string OrderEventsContainer { get; set; }

        public string GetConnectionString()
        {
            return $"AccountEndpoint={AccountEndpoint};AccountKey={AccountKey};";
        }
    }

    public class ApplicationInsights{
        public string ConnectionString {get;set;}
    }

    public class Logging
    {
        public LogLevel LogLevel { get; set; }
    }

    public class LogLevel
    {
        public string Default { get; set; }
        public string MicrosoftAspNetCore { get; set; }
    }   
}