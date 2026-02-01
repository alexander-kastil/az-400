using System.Threading;
using System.Threading.Tasks;
using MediatR;

namespace FoodApp
{
    public class GetOrdersByIdHandler (IOrderAggregates orderAggregates) : IRequestHandler<GetOrdersById, Order>
    {
        public async Task<Order> Handle(GetOrdersById request, CancellationToken cancellationToken)
        {
            return await orderAggregates.GetOrderByIdAsync(request.orderId, request.CustomerId);
        }
    }    
}