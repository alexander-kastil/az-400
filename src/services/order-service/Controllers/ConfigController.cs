using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace FoodApp
{
    [Route("[controller]")]
    [ApiController]
    public class ConfigController (IConfiguration cfg, AILogger logger) : ControllerBase
    {
        // https://localhost:5002/config/
        [HttpGet]
        public ActionResult GetConfig()
        {           
            logger.LogEvent("GetConfig", cfg.AsEnumerable());
           //get string typed config
           var config = cfg.Get<AppConfig>();
           return Ok(config);  
        }

        // https://localhost:5002/config/getEnvVars
        [HttpGet("getEnvVars")]
        public ActionResult GetEnvVars()
        {
            var val = Environment.GetEnvironmentVariables();
            return Ok(val);  
        }
    }
}