namespace payment_net;

public class Payment
{
    public decimal Amount { get; set; }
    public string Currency { get; set; } = string.Empty;
    public Card? Card { get; set; }
}

public class Card
{
    public string Number { get; set; } = string.Empty;
    public string Expiry { get; set; } = string.Empty;
    public string CVV { get; set; } = string.Empty;
}

public class PaymentRequest
{
    public Payment? Payment { get; set; }
}
