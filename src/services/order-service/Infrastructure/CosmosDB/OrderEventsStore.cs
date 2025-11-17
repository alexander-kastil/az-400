using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;
using Microsoft.Extensions.Configuration;

namespace FoodApp
{
    public class OrderEventsStore : IOrderEventsStore
    {
        private Container container;
        public OrderEventsStore(IConfiguration config)
        {
            AppConfig cfg = config.Get<AppConfig>();
            CosmosClient client = new CosmosClient(cfg.CosmosDB.GetConnectionString());
            container = client.GetContainer(cfg.CosmosDB.DBName, cfg.CosmosDB.OrderEventsContainer);
        }

        public async Task<OrderEventResponse> CreateOrderEventAsync(OrderEvent evt)
        {
            var resp = await container.CreateItemAsync<OrderEvent>(evt, new PartitionKey(evt.Id));
            return new OrderEventResponse
            {
                Id = resp.Resource.Id,
                EventType = resp.Resource.EventType,
                OrderId = resp.Resource.OrderId,
                CustomerId = resp.Resource.CustomerId,
                Timestamp = resp.Resource.Timestamp
            };
        }
    }
}