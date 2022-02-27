# 定義
```
<User>      = /src/types/user.ts
<Server>    = /src/types/server.ts
<Category>  = /src/types/category.ts
<Channel>   = /src/types/channel.ts
<Message>   = /src/types/message.ts
<jwt>       = (node-jsonwebtoken でパース可能なjwt)
```

# SQL
## DATABASE unichat
### TABLE users
|id						|email									|username							|password							|tag							|registered_at			|verified					|
|-------------|-----------------------|---------------------|---------------------|-----------------|-------------------|-----------------|
|UUID	NOT NULL|varchar(256) NOT NULL	|varchar(30) NOT NULL	|varchar(30) NOT NULL	|smallint	NOT NULL|timestamp NOT NULL	|boolean NOT NULL	|

### TABLE servers
|id						|name									|owner				|categories	|emojis	|stamps	|created_at					|
|-------------|---------------------|-------------|-----------|-------|-------|-------------------|
|UUID	NOT NULL|varchar(30) NOT NULL	|UUID	NOT NULL|UUID[]			|UUID[]	|UUID[]	|timestamp NOT NULL	|

### TABLE categories
|id						|name									|server				|channels	|created_at					|
|-------------|---------------------|-------------|---------|-------------------|
|UUID	NOT NULL|varchar(30) NOT NULL	|UUID NOT NULL|UUID[]		|timestamp NOT NULL	|

### TABLE channels
|id						|name									|description	|server				|category			|created_at					|
|-------------|---------------------|-------------|-------------|-------------|-------------------|
|UUID	NOT NULL|varchar(30) NOT NULL	|varchar(120)	|UUID NOT NULL|UUID NOT NULL|timestamp NOT NULL	|

### TABLE messages
|id						|user						|content							|server				|channel			|created_at					|
|-------------|---------------|---------------------|-------------|-------------|-------------------|
|UUID	NOT NULL|UUID NOT NULL	|varchar(300) NOT NULL|UUID NOT NULL|UUID NOT NULL|timestamp NOT NULL	|

# nginx
## /
ホームページ

## /api/
expressへのリバースプロキシ。
リバースプロキシはwebsocketに対応しているものが好まれます

# express
## POST /user/signup
ユーザー情報をDBに登録して確認メールを送る。`0時`, `12時`の間に確認がされなければユーザー情報を削除。
### Request
#### header
```
Content-Type: application/json
```
#### body
```
{
	"email":string,
	"username":string,
	"password":string
}
```

### Response
### header
```
Content-Type: application/json
```
### body
```
<User>
```

## POST /user/login
ベーシック認証を使ってjwtトークンを生成する
### Request
#### header
```
Authorization: Basic <email:password>
```
#### body
```
<jwt>
```