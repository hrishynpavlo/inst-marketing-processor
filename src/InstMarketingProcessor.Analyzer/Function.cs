using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace InstMarketingProcessor.Analyzer;

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        var result = new Response("John Doe", DateTime.UtcNow, Random.Shared.Next());
        var response = JsonConvert.SerializeObject(result);
        await Ok(context, response);
    }

    private static async Task Ok(HttpContext context, string jsonResponse)
    {
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = StatusCodes.Status200OK;
        await context.Response.WriteAsync(jsonResponse, context.RequestAborted);
    }
    
    public record Response(string Name, DateTime Time, int RandomNumber);
}