<div align="center">
<h1>OpenAI-Nim</h1>
<p>An OpenAI API module for Nim</p>
</div>

## Getting Started
```nim
import openai
```

Start an asynchronous OpenAI client
```nim
var ai = newAIClient(getEnv("AI_TOKEN")
```

Text chat with openai
```nim
waitFor ai.chat("Say 'test'")
```
