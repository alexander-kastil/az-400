import azure.functions as func
import logging
from card import Card
from payment import Payment

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="process_payment")
def process_payment(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    
    try:
        # Get JSON payload from request
        req_body = req.get_json()
        logging.info(f'Request body: {req_body}')
        
        # Also try to get raw body for debugging
        if req_body is None:
            try:
                raw_body = req.get_body().decode('utf-8')
                logging.info(f'Raw body: {raw_body}')
                import json
                req_body = json.loads(raw_body)
            except Exception as parse_error:
                logging.error(f'Failed to parse raw body: {parse_error}')
        
        if req_body and 'payment' in req_body:
            # Create Payment object from the JSON payload
            payment = Payment.from_dict(req_body['payment'])
            
            # Log the payment details
            logging.info(f'Processing payment: Amount={payment.amount} {payment.currency}, Card ending in {payment.card.number[-4:] if payment.card.number else "****"}')
            
            # Return success response with payment details
            return func.HttpResponse(
                f"Response from processPayment: Payment of {payment.amount} {payment.currency} processed successfully",
                status_code=200,
                mimetype="text/plain"
            )
        else:
            # No payment data in request
            return func.HttpResponse(
                "Response from processPayment: No payment data provided",
                status_code=400,
                mimetype="text/plain"
            )
            
    except ValueError as e:
        # Invalid JSON
        logging.error(f'Invalid JSON in request: {e}')
        return func.HttpResponse(
            f"Response from processPayment: Invalid JSON - {str(e)}",
            status_code=400,
            mimetype="text/plain"
        )
    except Exception as e:
        # Other errors
        logging.error(f'Error processing payment: {e}')
        return func.HttpResponse(
            f"Response from processPayment: Error processing payment - {str(e)}",
            status_code=500,
            mimetype="text/plain"
        )