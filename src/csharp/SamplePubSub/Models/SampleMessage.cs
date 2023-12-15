using System.Text.Json.Serialization;

namespace SamplePubSub.Models
{
    public class SampleMessage
    {
        [JsonPropertyName("content")]
        public string? Content { get; set; }
        [JsonPropertyName("tag")]
        public string? Tag { get; set; }
    }
}
