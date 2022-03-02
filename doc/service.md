# 定義
`$<number>`は引数、`$$`はワイルドカードとする。
`$int`は整数値、`$float`は実数値、また次のように引数型にすることもできることにする。`$<number>:<typename>`
`...`は繰り返しを意味する。`(`,`)`で囲ったものはグループとする。
`[`,`]`で囲ったものは省略可能グループとする。
また以上で定義したものはただの単一の文字としても表記される。
```
<User>      	= /types/user.ts
<Server>    	= /types/server.ts
<Category>  	= /types/category.ts
<Channel>   	= /types/channel.ts
<Message>   	= /types/message.ts
<jwt>       	= (node-jsonwebtoken でパース可能なjwt)
<token>				= (明確に決まっていないユーザー認証用のトークン)
<$$[]>				=	($$の配列)
<$$[$0:int]>	=	(最大サイズ$0の$$の配列)
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
## POST /server/create
ユーザーのサーバーを作成
### Request
#### header
```
Authorization: <?> <token>
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

## POST /server/delete
ユーザーのサーバーを削除
### Request
#### header
```
Authorization: <?> <token>
Content-Type: application/json
```
#### body
```
{
	"id":UUID
}
```
### Response
|status	|
|-------|
|200		|
#### body
```
```

## /server/:id/channels
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
<Channel[]>
```
[^server-channels-1]: 例: プライベートチャンネル
<!--#endregion server -->