using System.IO;
using System.Net;
using System.Text.Json;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace payment_net;

public class ProcessPayment
{
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
    private readonly ILogger<ProcessPayment> _logger;

    public ProcessPayment(ILogger<ProcessPayment> logger)
    {
        _logger = logger;
    }

    [Function("ProcessPayment")]
    public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "post")] HttpRequestData req)
    {
        _logger.LogInformation("Processing payment request");

        var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
        if (string.IsNullOrWhiteSpace(requestBody))
        {
            return await CreateBadRequest(req, "Request body is empty");
        }

        PaymentRequest? paymentRequest;
        try
        {
            paymentRequest = JsonSerializer.Deserialize<PaymentRequest>(requestBody, JsonOptions);
        }
        catch (JsonException ex)
        {
            _logger.LogError(ex, "Failed to parse payment request");
            return await CreateBadRequest(req, "Invalid JSON format");
        }

        if (paymentRequest?.Payment == null)
        {
            return await CreateBadRequest(req, "Invalid payment data");
        }

        _logger.LogInformation("Processing payment for amount: {Amount} {Currency}", paymentRequest.Payment.Amount, paymentRequest.Payment.Currency);

        var cardNumber = paymentRequest.Payment.Card?.Number ?? string.Empty;
        var last4 = cardNumber.Length >= 4 ? cardNumber[^4..] : cardNumber;

        var responsePayload = new
        {
            status = "success",
            transactionId = Guid.NewGuid().ToString(),
            amount = paymentRequest.Payment.Amount,
            currency = paymentRequest.Payment.Currency,
            cardNumber = last4
        };

        var response = req.CreateResponse(HttpStatusCode.OK);
        response.Headers.Add("Content-Type", "application/json");
        await response.WriteStringAsync(JsonSerializer.Serialize(responsePayload, JsonOptions));
        return response;
    }

    private static async Task<HttpResponseData> CreateBadRequest(HttpRequestData req, string message)
    {
        var response = req.CreateResponse(HttpStatusCode.BadRequest);
        response.Headers.Add("Content-Type", "text/plain; charset=utf-8");
        await response.WriteStringAsync(message);
        return response;
    }
}