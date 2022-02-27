# SQL
## DATABASE unichat
### TABLE users
|id						|username							|tag							|registered_at			|verified					|
|UUID	NOT NULL|varchar(30) NOT NULL	|smallint	NOT NULL|timestamp NOT NULL	|boolean NOT NULL	|

### TABLE servers
|id						|name									|owner				|categories	|emojis	|stamps	|created_at					|
|UUID	NOT NULL|varchar(30) NOT NULL	|UUID	NOT NULL|UUID[]			|UUID[]	|UUID[]	|timestamp NOT NULL	|

### TABLE categories
|id						|name									|server				|channels	|created_at					|
|UUID	NOT NULL|varchar(30) NOT NULL	|UUID NOT NULL|UUID[]		|timestamp NOT NULL	|

### TABLE channels
|id						|name									|description	|server				|category			|created_at					|
|UUID	NOT NULL|varchar(30) NOT NULL	|varchar(120)	|UUID NOT NULL|UUID NOT NULL|timestamp NOT NULL	|

### TABLE messages
|id						|user						|content							|server				|channel			|created_at					|
|UUID	NOT NULL|UUID NOT NULL	|varchar(300) NOT NULL|UUID NOT NULL|UUID NOT NULL|timestamp NOT NULL	|

# nginx
## /
ホームページ
## /api
expressにつながる(リバースプロキシ)

# express
## POST /user/signup
ユーザー情報をDBに登録して確認メールを送る。4時間以内に確認できなければユーザー情報を削除。
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