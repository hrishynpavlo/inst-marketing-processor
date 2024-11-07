using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;

namespace InstMarketingProcessor.Analyzer;

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        await context.Response.WriteAsync("{ \"test\": \"test\" }", context.RequestAborted);
    }
}