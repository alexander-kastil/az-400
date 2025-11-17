using System.Threading;
using System.Threading.Tasks;
using MediatR;

namespace FoodApp
{
    public class AddOrderEventHandler (IOrderEventsStore orderEventsStore) : IRequestHandler<AddOrderEventCommand, OrderEventResponse>
    {
        public async Task<OrderEventResponse> Handle(AddOrderEventCommand request, CancellationToken cancellationToken)
        {                                    
            return await orderEventsStore.CreateOrderEventAsync(request.Event);
        }
    }
}
