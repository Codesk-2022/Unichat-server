# 定義
`$<number>`は引数、`*`はワイルドカードとする。

クエリーにある`null`は省略可能とする。
```
<User>      	= /types/user.ts
<Server>    	= /types/server.ts
<Category>  	= /types/category.ts
<Channel>   	= /types/channel.ts
<Message>   	= /types/message.ts
<jwt>       	= (node-jsonwebtoken でパース可能なjwt)
<token>				= (明確に決まっていないユーザー認証用のトークン)
<*[]>					=	(*の配列)
<?>						=	(不明の文字列)
```

# SQL
## DATABASE unichat
### TABLE users
|id						|email									|username							|password							|tag							|registered_at			|verified					|
|-------------|-----------------------|---------------------|---------------------|-----------------|-------------------|-----------------|
|UUID	NOT NULL|varchar(256) NOT NULL	|varchar(30) NOT NULL	|varchar(30) NOT NULL	|smallint	NOT NULL|timestamp NOT NULL	|boolean NOT NULL	|

### TABLE servers
|id						|name									|owner				|emojis	|stamps	|created_at					|
|-------------|---------------------|-------------|-------|-------|-------------------|
|UUID	NOT NULL|varchar(30) NOT NULL	|UUID	NOT NULL|UUID[]	|UUID[]	|timestamp NOT NULL	|

### TABLE channels
|id						|name									|description	|server				|is_private	|members|created_at					|
|-------------|---------------------|-------------|-------------|-----------|-------|-------------------|
|UUID	NOT NULL|varchar(30) NOT NULL	|varchar(120)	|UUID NOT NULL|boolean		|UUID[]	|timestamp NOT NULL	|

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
<!--#region user -->
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
:::note note
jwtはまだ検討中なので使わない
:::

Basic認証を使ってjwtトークンを生成する
### Request
#### header
```
Authorization: Basic <email:password>
```
#### body
```
<jwt>
```

<!--#endregion user -->
----
<!--#region server -->

## GET /server/:id
サーバー`:id`を返します
- 存在しないサーバーの場合はステータスを`404`に指定し空のデータを返す。

## POST /server/create
ユーザーのサーバーを作成
### Request
#### header
```
Authorization: Basic <token>
Content-Type: application/json
```
#### body
```
{
	"name":string
}
```
### Response
#### header
```
Content-Type: application/json
```
#### body
```
<Server>
```

## DELETE /server/:id/delete
ユーザーのサーバーを削除
### Request
#### header
```
Authorization: Basic <token>
Content-Type: application/json
```
#### body
```
{
	"id":UUID
}
```
### Response
#### body
```
```

## /server/:id/channels
サーバー`:id`のチャンネル一覧を返します
### queries
|private																	|
|-----------------------------------------|
|`type T = "true"\|"false"\|"all"\|null`	|
サーバー`:id` のチャンネル一覧。

- ユーザーに閲覧許可がないチャンネル[^server-channels-1]の場合はレスポンスで渡さない。
- クエリ`private`が`true`であればプライベートチャンネルだけに絞り込む。
- クエリ`private`が`false`であればプライベートチャンネル以外だけに絞り込む。
- クエリ`private`が`all`または`null`であれば絞り込みをしない。
### Request
#### header
```
Authentication: Basic <email:password>
```

### Response
#### header
```
Content-Type: application/json
```
#### body
```
<Channel[]>
```
[^server-channels-1]: 例: プライベートチャンネル

## GET /server/:id/members
サーバー`:id`のメンバー一覧を返します
### Request
#### header
```
Authentication: Basic <email:password>
```
#### body
```
```

### Response
#### header
```
Content-Type: application/json
```
#### body
```
<User[]>
```

## POST /server/:id/join
サーバー`:id`に参加します
### Request
#### haeder
```
Authentication: Basic <email:password>
```
#### body
```
```

### Response
#### header
```
Content-Type: application/json
```
#### body
```
<server>
```

## DELETE /server/:id/leave
サーバー`:id`から離脱します
### Request
#### header
```
Authentication: Basic <email:password>
```

### Response
#### header
```
Content-Type: application/json
```
#### body
```
<server>
```
<!--#endregion server -->
----
<!--#region channel -->
## GET /channels/:id/messages
### queries
|from						|to						|limit		|user					|
|---------------|-------------|---------|-------------|
|`Date\|null`		|`Date\|null`	|`Date`		|`UUID|null`	|

### Request
#### header
```
Authentication: Basic <email:password>
```

### Response
#### header
```
Content-Type: application/json
```

### body
```
<message[]>
```

<!--#endregion channel -->
