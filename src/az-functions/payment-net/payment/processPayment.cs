using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Company.Function
{
    public class processPayment
    {
        private readonly ILogger<processPayment> _logger;

        public processPayment(ILogger<processPayment> logger)
        {
            _logger = logger;
        }
        [Function("processPayment")]
        public async Task<IActionResult> ProcessPayment([HttpTrigger(AuthorizationLevel.Anonymous, "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();

            if (string.IsNullOrEmpty(requestBody))
            {
                return new BadRequestObjectResult("Request body is empty");
            }

            try
            {
                var paymentRequest = JsonConvert.DeserializeObject<PaymentRequest>(requestBody);

                if (paymentRequest?.Payment == null)
                {
                    return new BadRequestObjectResult("Invalid payment data");
                }

                _logger.LogInformation($"Processing payment for amount: {paymentRequest.Payment.Amount} {paymentRequest.Payment.Currency}");

                // Process the payment here
                var result = new
                {
                    status = "success",
                    transactionId = Guid.NewGuid().ToString(),
                    amount = paymentRequest.Payment.Amount,
                    currency = paymentRequest.Payment.Currency,
                    cardNumber = paymentRequest.Payment.Card.Number.Substring(paymentRequest.Payment.Card.Number.Length - 4)
                };

                return new OkObjectResult(result);
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Failed to parse payment request");
                return new BadRequestObjectResult("Invalid JSON format");
            }
        }
    }
}
