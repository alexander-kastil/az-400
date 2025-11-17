using MediatR;

namespace FoodApp
{
    public record CreateOrderEventCommand(Order order) : IRequest<OrderEventResponse>;
}