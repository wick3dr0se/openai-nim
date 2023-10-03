<div align="center">
<h1>OpenAI-Nim</h1>
<p>An OpenAI API module for Nim</p>
</div>

## Acquisition
Install with Nimble
```bash
nimble install https://github.com/wick3dr0se/openai-nim
```

Install from source
```bash
git clone https://github.com/wick3dr0se/openai-nim; cd openai-nim
```

## Getting Started

```nim
# from nible
import openai
# or from source
import ./openai-nim
```

Start an asynchronous OpenAI client
```nim
var ai = newAIClient(getEnv("AI_TOKEN")
```

Text chat with openai
```nim
echo waitFor ai.chat("Say 'test'")
```
