[![Build Status](https://travis-ci.org/scottberke/g_chat_backend.svg?branch=master)](https://travis-ci.org/scottberke/g_chat_backend)
Live App: https://protected-wildwood-40844.herokuapp.com/
* To use live app open url in two tabs in a browser. Sign up/Sign in and click on another user to chat. One known issue is that sending a logged in user a message doesn't auto-open a chat window on the other users session. Other user must click your username to open the chat window to see chats. Will fix this soon.

# G(uild) Chat
G Chat chat is a basic chat application that enables users to create an account, login and send messages to other users of the app. The application is built with Ruby on Rails as the backend API and React for the frontend.

ActionCable is utilized to provide realtime communication between users. An endpoint for messages does exist, however, it is not documented below as all messages are created over an ActionCable channel. After a message is created, a broadcast job is created, queued and then broadcast to recipients subscribed to the channel.

Devise with Doorkeeper are used to provide signup and Oauth Token access.

## Notes
* Backend tests cover the main controllers as well as the models. If I was going to spend more time on this, I would certainly test all of the ActionCable interactions as well as the ActiveJob thats created. The ActiveJob is only tested via the after commit test in the message model spec.

The frontend does not include any tests at this time. Again, if more time was allowed I would write a bunch of feature tests.

* I don't consider myself much of a frontend engineer. With that in mind, I initially tried keeping both the backend and the frontend in two distinct repos. I was have a lot of difficulty deploying the frontend so that it would communicate with the backend via a websocket. Lots of CORS issues. So, I wound up stumbling on a solution that pulled the frontend into a g_chat_frontend directory within the API root and creating a deploy script that enabled Heroku to build the front and the back on one dyno. I'm sure my React isn't idiomatic but I'm working toward that.


## To Run Locally
Clone https://github.com/scottberke/g_chat_backend.git

```bash
$ gem install foreman # if foreman is not already installed
$ foreman start -f Procfile.dev # to run both back end and front end locally
```

## To Deploy To Heroku
Deploying to Heroku depends on the package.json file in the root of the Rails app. This includes build scripts to first build the frontend before building the backend.

```bash
$ heroku apps:create # create app
$ heroku addons:add redistogo # add redis for ActionCable in prod
$ heroku buildpacks:add heroku/nodejs --index 1 # make sure heroku knows to look for node first
$ heroku buildpacks:add heroku/ruby --index 2 # then ruby build
$ git push heroku master
```

Below is a description of available endpoints.

# End Points
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

Response 202 (application/json)
```json
{
    "access_token": "ACCESS_TOKEN",
    "token_type": "bearer",
    "expires_in": 7200,
    "created_at": 1529095325,
    "username": "USERNAME",
    "userid": 1
}
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
