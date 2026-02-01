using MediatR;

namespace FoodApp
{
    public record AddOrderEventCommand(OrderEvent Event) : IRequest<OrderEventResponse>;
}