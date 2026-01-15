using Microsoft.AspNetCore.OpenApi;
using Scalar.AspNetCore;
using System.Runtime.Serialization;


var builder = WebApplication.CreateBuilder(args);
builder.Services.AddOpenApi();

var app = builder.Build();

// Map OpenAPI and Scalar UI
app.MapOpenApi();              // serves /openapi/v1.json
app.MapScalarApiReference();   // serves Scalar UI at /scalar/v1

// Redirect root to Scalar UI in all environments
app.MapGet("/", () => Results.Redirect("/scalar/v1"));

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast");

app.Run();

[DataContract]
record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    [DataMember]
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
