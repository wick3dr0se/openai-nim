import httpclient, asyncdispatch, json

type
  Completion = object
    id: string
    created: int
    model: string
    choices: seq[Choices]
    usage: Usage
  Choices = object
    index: int
    message: Message
    finish_reason: string
  Message = object
    role: string
    content: string
  Usage = object
    prompt_tokens: int
    completion_tokens: int
    total_tokens: int

const api = "https://api.openai.com/v1/chat/completions"

proc newAIClient*(key: string): AsyncHttpClient =
  return newAsyncHttpClient(
    headers = newHttpHeaders({
      "Content-Type": "application/json",
      "Authorization": "Bearer " & key
    })
  )

proc chat*(client: AsyncHttpClient, text: string, model = "gpt-3.5-turbo", temperature = 1.0, role = "user"): Future[string] {.async.} =
  let
    body = %*{
      "model": model,
      "temperature": temperature,
      "messages": [{
        "role": role,
        "content": text
      }]
    }
    response = await client.request(api, httpMethod = HttpPost, body = $body)
    jsonObject = parseJson(await response.body)
    c = to(jsonObject, Completion)
  
  return c.choices[0].message.content