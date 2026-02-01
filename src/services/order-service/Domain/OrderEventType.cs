namespace FoodApp
{
    public enum OrderEventType
    {
        Created,
        PaymentRequested,
        PaymentSuccess,
        PaymentFailed,
        ProductionRequested,
        ProductionStarted,
        ProductionCompleted,
        ProductionNotCompleted,
        DeliveryStarted,
        DeliveryCompleted,
        Completed,
        Canceled
    }
}