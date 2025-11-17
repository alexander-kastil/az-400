using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.Configuration;

namespace FoodApp
{
    public class FoodTelemetryInitializer(IConfiguration cfg) : ITelemetryInitializer
    {
        private readonly string title = cfg.GetValue<string>("title");

        public void Initialize(ITelemetry telemetry)
        {            
            if (string.IsNullOrEmpty(telemetry.Context.Cloud.RoleName))
            {
                telemetry.Context.Cloud.RoleName = title;
            }
        }
    }
}