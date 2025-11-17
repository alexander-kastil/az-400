using MediatR;

namespace FoodApp
{
    public record GetOrdersById(string orderId, string CustomerId) : IRequest<Order>;    
}