using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;
using Microsoft.Extensions.Configuration;

namespace FoodApp
{
    public class OrderEventsStore(IConfiguration config) : IOrderEventsStore
    {
        private Container container = new CosmosClient(config.Get<AppConfig>().CosmosDB.GetConnectionString())
            .GetContainer(config.Get<AppConfig>().CosmosDB.DBName, config.Get<AppConfig>().CosmosDB.OrderEventsContainer);

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