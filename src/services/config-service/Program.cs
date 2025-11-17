using Azure.Data.AppConfiguration;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

IConfiguration Configuration = builder.Configuration;
builder.Services.AddSingleton<IConfiguration>(Configuration);

// Add Key Vault Client to DI
var cfg = Configuration.Get<AppConfig>()!;
var client = new SecretClient(new Uri($"https://{cfg.Settings!.KeyVault!}"), new DefaultAzureCredential());
builder.Services.AddSingleton<SecretClient>(client);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapGet("/getConfig", ([FromServices] IConfiguration config) =>
{
    var cfg = config.Get<AppConfig>()!;
    return cfg;
})
.WithName("GetConfig")
.WithOpenApi();


app.MapGet("/getSecretFromVault", async ([FromServices] IConfiguration config, [FromServices] SecretClient secretClient) =>
{
    var response = await secretClient.GetSecretAsync("conSQLite");
    return response.Value.Value!;
})
.WithName("GetSecretFromVault")
.WithOpenApi();

app.MapGet("/getFromAppConfig/{ConfigItem}", ([FromServices] IConfiguration config, string ConfigItem) =>
{
    var cfg = config.Get<AppConfig>()!;
    var client = new ConfigurationClient(new Uri(cfg.Settings!.AppConfigEndpoint!), new DefaultAzureCredential());
    ConfigurationSetting setting = client.GetConfigurationSetting(ConfigItem);
    return setting.Value!;
})
.WithName("GetFromAppConfig")
.WithOpenApi();

app.UseHttpsRedirection();

app.Run();
