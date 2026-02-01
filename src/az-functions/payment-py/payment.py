"""Payment model for payment processing."""

from typing import Optional
from decimal import Decimal
from card import Card


class Payment:
    """Represents a payment with amount, currency, and card information."""
    
    def __init__(self, amount: Decimal = Decimal('0.00'), currency: str = "USD", card: Optional[Card] = None):
        self.amount = amount
        self.currency = currency
        self.card = card or Card()
    
    def to_dict(self) -> dict:
        """Convert Payment object to dictionary."""
        return {
            "amount": str(self.amount),
            "currency": self.currency,
            "card": self.card.to_dict()
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> 'Payment':
        """Create Payment object from dictionary."""
        amount = Decimal(str(data.get("amount", "0.00")))
        currency = data.get("currency", "USD")
        card_data = data.get("card", {})
        card = Card.from_dict(card_data) if card_data else Card()
        
        return cls(amount=amount, currency=currency, card=card)
