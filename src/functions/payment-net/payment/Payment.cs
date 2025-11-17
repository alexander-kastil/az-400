public class Payment
{
    public decimal Amount { get; set; }
    public string Currency { get; set; }
    public Card Card { get; set; }
}

public class Card
{
    public string Number { get; set; }
    public string Expiry { get; set; }
    public string CVV { get; set; }
}

public class PaymentRequest
{
    public Payment Payment { get; set; }
}
