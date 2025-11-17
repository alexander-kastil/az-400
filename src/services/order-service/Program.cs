using FoodApp;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);
builder.AddConfig();
builder.AddApplicationInsights();

// Add OrderAggregates and OrderEvents
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblyContaining<Program>());
builder.Services.AddSingleton<IOrderAggregates, OrderAggregates>();
builder.Services.AddSingleton<IOrderEventsStore, OrderEventsStore>();

builder.AddEndpointsApiExplorer();
builder.AddNoCors();
builder.Services.AddControllers();
var app = builder.Build();
app.UseSwaggerUI();
app.UseNoCors();
app.MapControllers();
app.Run();