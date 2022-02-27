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
