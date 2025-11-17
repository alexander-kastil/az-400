using System.IO;
using Microsoft.Extensions.Configuration;
using Microsoft.SemanticKernel;

var builder = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

IConfiguration configuration = builder.Build();

var useLocal = configuration["UseLocalLLM"];

var kernelBuilder = Kernel.CreateBuilder();
if (useLocal != "true")
{
    var model = configuration["SemanticKernel:DeploymentModel"];
    var endpoint = configuration["SemanticKernel:Endpoint"];
    var resourceKey = configuration["SemanticKernel:ApiKey"];
    
    kernelBuilder.Services.AddAzureOpenAIChatCompletion(
    model,
    endpoint,
    resourceKey
);
}
else
{
    var localEndpoint = configuration["LocalModelSettings:Endpoint"];
    var url = $"{localEndpoint}/v1/chat/completions";
    HttpClient client = new(new LocalServerClientHandler(url));
    
    kernelBuilder.AddOpenAIChatCompletion("local-model", url, "not required", httpClient: client);
}

var kernel = kernelBuilder.Build();

Console.WriteLine("Enter a prompt (or press Enter to use the default):");
var prompt = Console.ReadLine();
if (string.IsNullOrWhiteSpace(prompt))
{
    prompt = "Give me a list of breakfast foods with eggs and cheese";
}

Console.WriteLine("Prompt: " + prompt);
var result = await kernel.InvokePromptAsync(prompt);

Console.WriteLine(result);