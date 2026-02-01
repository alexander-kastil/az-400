"""Card model for payment processing."""

class Card:
    """Represents a payment card with number, expiry, and CVV."""
    
    def __init__(self, number: str = "", expiry: str = "", cvv: str = ""):
        self.number = number
        self.expiry = expiry
        self.cvv = cvv
    
    def to_dict(self) -> dict:
        """Convert Card object to dictionary."""
        return {
            "number": self.number,
            "expiry": self.expiry,
            "cvv": self.cvv
        }
    
    @classmethod
    def from_dict(cls, data: dict) -> 'Card':
        """Create Card object from dictionary."""
        return cls(
            number=data.get("number", ""),
            expiry=data.get("expiry", ""),
            cvv=data.get("cvv", "")
        )
