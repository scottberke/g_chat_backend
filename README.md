Live App: https://protected-wildwood-40844.herokuapp.com/
# G(uild) Chat
G Chat chat is a basic chat application that enables users to create an account, login and send messages to other users of the app. The application is built with Ruby on Rails serving as the backend API and a React frontend.

ActionCable is utilized to provide realtime communication between users. An endpoint for messages does exist, however, it is not documented below as all messages are created over an ActionCable channel. After a message is created, a broadcast job is created and queued that broadcasts the message to recipients subscribed to the channel.  

Below is a description of available endpoints.

## Access Token
#### POST /oauth/token
Use to retreive access token for existing user

Request
```bash
$ curl -X POST \
  http://shrouded-wave-69866.herokuapp.com/oauth/token \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F username=USERNAME \
  -F password=PASSWORD \
  -F grant_type=password
```
## Users
#### POST /api/v1/users
Use to create a new user

Request
```bash
$ curl -X POST \
  https://protected-wildwood-40844.herokuapp.com/api/v1/users \
  -H 'Cache-Control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F username=USERNAME \
  -F password=PASSWORD
```

Response 202 (application/json)
```json
{
    "id": 1,
    "username": "USERNAME",
    "created_at": "2018-06-14T21:25:19.827Z",
    "updated_at": "2018-06-14T21:25:19.827Z"
}
```
#### GET /api/v1/users/index
Use to retrieve users other than current/authenticated user
Requires access_token

Request
```bash
$ curl -X GET \
  https://protected-wildwood-40844.herokuapp.com/api/v1/users/index \
  -H 'Authorization: Bearer ACCESS_TOKEN' \
  -H 'Cache-Control: no-cache' \
```

Response 200 (application/json)
```json
[
    {
        "id": 2,
        "username": "OTHER_USER",
        "created_at": "2018-06-15T02:45:34.797Z",
        "updated_at": "2018-06-15T02:45:34.797Z"
    }
]
```

#### POST api/v1/chats
Use to create a new chat. If a chat already exists between the two users, the existing chat will be returned.
Requires access token

Request
```bash
$ curl -X POST \
  https://protected-wildwood-40844.herokuapp.com/api/v1/chats \
  -H 'Authorization: Bearer ec4ed9fe85506f452ac07f67ec192503b1a0d18e6b786866b69caff624964666' \
  -H 'Cache-Control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F user_id=2
```

Response 200 (application/json)
```json
{
    "id": 1,
    "recipient_id": 1,
    "sender_id": 2,
    "created_at": "2018-06-15T02:45:38.025Z",
    "updated_at": "2018-06-15T02:45:38.025Z"
}
```
