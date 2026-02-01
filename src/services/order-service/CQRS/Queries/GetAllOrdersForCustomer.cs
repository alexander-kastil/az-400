using System.Collections.Generic;
using MediatR;

namespace FoodApp
{
    public record GetAllOrdersForCustomer(string CustomerId) : IRequest<IEnumerable<Order>>;    
}