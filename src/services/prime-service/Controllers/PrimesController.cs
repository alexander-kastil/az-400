using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace PrimesService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PrimesController : ControllerBase
    {
        [HttpGet]
        [Route("{n}")]
        public IActionResult Get(int n)
        {
            Stopwatch watch = new Stopwatch();
            watch.Start();
            var count = getPrimesCount(n);
            watch.Stop();
            return Ok($"Primes - {count}, Time Taken - {watch.ElapsedMilliseconds}ms, Instance Id - {Environment.GetEnvironmentVariable("WEBSITE_INSTANCE_ID")}");
        }

        public static int getPrimesCount(int lessThanN)
        {
            Func<int, bool> isPrime = new Func<int, bool>((n) =>
            {
                int i, m = 0, flag = 0;
                m = n / 2;
                for (i = 2; i <= m; i++)
                {
                    if (n % i == 0)
                    {
                        return false;
                    }
                }
                return flag == 0;
            });

            int primeCount = 0;
            for (int i = 1; i < lessThanN; i++)
                primeCount += isPrime(i) ? 1 : 0;
            return primeCount;
        }

    }
}