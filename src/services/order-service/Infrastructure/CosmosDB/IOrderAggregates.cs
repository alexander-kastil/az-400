using System.Collections.Generic;
using System.Threading.Tasks;

namespace FoodApp
{
    public interface IOrderAggregates
    {        
        Task<Order> GetOrderByIdAsync(string id, string customerId);
        Task<IEnumerable<Order>> GetAllOrdersForCustomer(string customerId);
        Task<IEnumerable<Order>> GetAllOfTypeOrderAsync();
        Task<IEnumerable<Order>> GetOrdersByQueryAsync(string query);
    }
}