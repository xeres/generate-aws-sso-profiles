# generate-aws-sso-profiles

AWS SSO から ~/.aws/config を自動生成します。

## 使い方

```
Usage: generate-aws-sso-profiles [OPTION]

Options:
    -p PROFILE     指定されたプロファイルを設定ファイルから使用します
    -d DELIM       アカウント名とアクセス権限セットの間の区切り文字を "-" の代わりに置き換えます
    -h             ヘルプを表示して終了します
    -v             バージョン情報を出力して終了します
```

## クイックスタート

最初に、AWS SSO にログインできるプロファイルを1つだけ作成します。
このプロファイルは AWS SSO にログインさえ出来れば何でも良いです。
管理アカウントへのプロファイルである必要もありません。

```ini:~/.aws/config
[profile "tmp"]
sso_start_url = https://<your-sso-domain>.awsapps.com/start
sso_region = us-east-1
sso_account_id = 123456789012
sso_role_name = ReadOnlyAccess
```

このプロファイルで AWS SSO にログインします。

```shell-session
aws sso login --profile tmp
```

ログインが完了したら、`generate-aws-sso-profiles` を実行します。

```shell-session
./generate-aws-sso-profiles -p tmp
```

一連の作業には `$AWS_PROFILE` を使用することも可能です。

```shell-session
export AWS_PROFIL=tmp
aws sso login
generate-aws-sso-profiles
```

プロンプトで続行してよいか質問されるので、`y` と答えます。

```shell-session
❯ ./generate-aws-sso-profiles
The following AWS SSO will be checked.

    https://<your-sso-domain>.awsapps.com/start

Do you want to run the script? [y/N]: y
```

スクリプトは、ログインした AWS SSO の全てのアカウントとアクセス権限セットの
組み合わせを調査します。この作業にはしばらく時間が掛かります。

全ての調査が完了すると、プロンプトで結果を出力してよいか質問されるので、"y" と
答えます。

```shell-session
Do you want to flush to ./aws_config? [y/N]: y
```

既に同名のファイルが存在する場合、`aws_config~` というファイルにバックアップ
されます。

## プロファイル名の変更

プロファイル名は AWS アカウント名とアクセス権限セット名から自動的に生成されます。
これが気に入らない場合、サンプルの `sed` スクリプトを参考に、プロファイル名を
使いやすいものに書き換えることが可能です。

```shell-session
sed -f rename-profile-sample.sed aws_config
```

内容に問題がなければ、このファイルをあなたの新しい `~/.aws/config` として
使用できます。

## Licence

```
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Author

Xeres
