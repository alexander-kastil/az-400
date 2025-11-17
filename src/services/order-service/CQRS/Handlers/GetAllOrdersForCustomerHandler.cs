using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using MediatR;

namespace FoodApp
{
    public class GetAllOrdersForCustomerHandler (IOrderAggregates orderAggregates) : IRequestHandler<GetAllOrdersForCustomer, IEnumerable<Order>>
    {
        public async Task<IEnumerable<Order>> Handle(GetAllOrdersForCustomer request, CancellationToken cancellationToken)
        {
            return await orderAggregates.GetAllOrdersForCustomer(request.CustomerId);
        }
    }    
}