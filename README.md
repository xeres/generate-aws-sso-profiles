# generate-aws-sso-profiles

Auto generate ~/.aws/config profiles from AWS SSO.

## Usage

```
Usage: generate-aws-sso-profiles [OPTION]

Options:
    -p PROFILE     use a specific AWS SSO profile from your configuration file
    -d DELIM       use DELIM instead of "-" between an account name and a permission set
    -h             display this help and exit
    -v             output version information and exit
```

## Quick Start

First, create only one profile that can log in to AWS SSO.
This profile can be anything as long as it can log in to AWS SSO.
It doesn't even have to be a profile to an administrative account.

```ini:~/.aws/config
[profile "tmp"]
sso_start_url = https://<your-sso-domain>.awsapps.com/start
sso_region = us-east-1
sso_account_id = 123456789012
sso_role_name = ReadOnlyAccess
```

Log in to AWS SSO with this profile.

```shell-session
aws sso login --profile tmp
```

Once the login is complete, run `generate-aws-sso-profiles`.

```shell-session
./generate-aws-sso-profiles -p tmp
```

You can also use `$AWS_PROFILE` for a series of tasks.

```shell-session
export AWS_PROFIL=tmp
aws sso login
generate-aws-sso-profiles
```

You will be prompted if you want to continue; answer `y`.

```shell-session
❯ ./generate-aws-sso-profiles
The following AWS SSO will be checked.

    https://<your-sso-domain>.awsapps.com/start

Do you want to run the script? [y/N]: y
```

The script will examine all the AWS SSO account and permission set
combinations you have logged into. This process will take some time.

When all the investigations are complete, you will be asked if you want
to output the file, answer `y`.

```shell-session
Do you want to flush to ./aws_config? [y/N]: y
```

If a file with the same name already exists, it will be backed up to
an `aws_config~`.

## Rename profile names

The profile name is automatically generated from the AWS account name
and permission set name. If you don't like this, you can refer to the
sample sed script to rewrite the profile name to something more user-
friendly.

```shell-session
sed -f rename-profile-sample.sed aws_config
```

If you are satisfied with the contents, you can use this file as your
new ~/.aws/config.

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
