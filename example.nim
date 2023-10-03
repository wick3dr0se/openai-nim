import os
import asyncdispatch
import ./openai.nim

let apiKey = getEnv("AI_KEY")

var ai = newAIClient(apiKey)

waitFor ai.chat("Say 'test'")