using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;

namespace InstMarketingProcessor.Analyzer;

class Program
{
    static async Task Main(string[] args)
    {
        var f = new Function();
        var ctx = new DefaultHttpContext();
        await f.HandleAsync(ctx);
    }
}

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        await context.Response.WriteAsync("{ \"test\": \"test\" }", context.RequestAborted);
    }
}