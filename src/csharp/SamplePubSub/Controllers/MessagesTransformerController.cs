using Microsoft.AspNetCore.Mvc;
using Dapr.Client;
using SamplePubSub.Models;

namespace SamplePubSub.Controllers
{
    [Route("api/messages")]
    [ApiController]
    public class MessagesSubscriberController : ControllerBase
    {
        private readonly ILogger<MessagesSubscriberController> _logger;
        private readonly DaprClient _daprClient;

        public MessagesSubscriberController(DaprClient daprClient, ILogger<MessagesSubscriberController> logger)
        {
            _logger = logger;
            _daprClient = daprClient;
        }

        [Dapr.Topic(pubsubName: "iotoperations-pubsub", name: "messages", enableRawPayload: true)]
        [HttpPost("/messages")]
        public async Task<IActionResult> MessageReceived(SampleMessage incomingMessage)
        {
            if (incomingMessage is not null)
            {
                // for demo purposes, just log the message
                _logger.LogInformation($"Message content received: {incomingMessage.Content}");

                // publish back to other topic "outmessages"
                await _daprClient.PublishEventAsync("iotoperations-pubsub", "outmessages", incomingMessage);
            
                return Ok();
            }

            _logger.LogWarning($"No incoming message received.");
            return BadRequest();
        }
    }
}

