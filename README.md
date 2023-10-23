<div align="center">
<h1>OpenAI-Nim</h1>
<p>OpenAI API for Nim</p>
</div>

## Acquisition
Install with Nimble
```bash
nimble install https://github.com/wick3dr0se/openai-nim@#head
```

Install from source
```bash
git clone https://github.com/wick3dr0se/openai-nim; cd openai-nim
```

## Getting Started
Import openai module
```nim
# from nimble
import openai
# or from source
import ./openai
```

Start an asynchronous OpenAI client
```nim
var ai = newAIClient(getEnv("AI_KEY")
```

Text chat with OpenAI
```nim
ai.chat("Say 'test'")
```

Generate an image with DALL-E
```nim
ai.imageGen("Puppy")
```
