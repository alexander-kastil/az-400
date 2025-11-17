using System.Threading.Tasks;

namespace FoodApp
{
    public interface IOrderEventsStore
    {
        Task<OrderEventResponse> CreateOrderEventAsync(OrderEvent order);        
    }
}