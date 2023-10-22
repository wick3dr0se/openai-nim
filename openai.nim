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

type
  Image = object
    created: int
    data: seq[Data]
  Data = object
    url: string

proc newAIClient*(apiKey: string): AsyncHttpClient =
  return newAsyncHttpClient(
    headers = newHttpHeaders({
      "Authorization": "Bearer " & apiKey
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
    response = await client.request(
      "https://api.openai.com/v1/chat/completions",
      headers = newHttpHeaders({"Content-Type": "application/json"}),
      httpMethod = HttpPost, body = $body
    )
    jsonObject = parseJson(await response.body)
    c = to(jsonObject, Completion)
  
  return c.choices[0].message.content

proc imageGen*(client: AsyncHttpClient, prompt: string, size = "256x256"): Future[string] {.async.} =
  let
    body = %*{
      "prompt": prompt,
      #"n": 1,
      "size": size,
      #"response_format": "url"
    }
    response = await client.request(
      "https://api.openai.com/v1/images/generations",
      headers = newHttpHeaders({"Content-Type": "application/json"}),
      httpMethod = HttpPost, body = $body
    )
    jsonObject = parseJson(await response.body)
    i = to(jsonObject, Image)
    
  return i.data[0].url
  #[ ERR RESPONSE
    {
  "error": {    "code": null,
    "message": "'256\u00d7256' is not one of ['256x256', '512x512', '1024x1024'] - 'size'",
    "param": null,
    "type": "invalid_request_error"
  }
  }
  ]#