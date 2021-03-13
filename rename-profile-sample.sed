# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

/^\[profile/ {
    # extract profile name
    s/.*"\(.*\)"\]/\1/

    # for Organizations management account
    /^Master Account$/ {
        c master
    }

    # for Foo Project
    /^\[Foo\]/ {
        s/^\[Foo\]/foo/
    }

    # for Bar Project
    /^Bar Project/ {
        s/^Bar Project/bar/
        s/Development/dev/
        s/Production/prod/
    }

    # space to hyphen
    s/ /-/g

    # remove *Access suffix
    # ex.)
    #   - foo-ReadOnlyAccess -> foo-ReadOnly
    #   - foo-AdministratorAccess -> foo-Administrator
    s/Access$//

    # comment out to omit -ReadOnly
    # ex.)
    #   - foo-ReadOnly -> foo
    s/-ReadOnly\(Access\)??//

    # comment out to shorten Administrator to admin
    # ex.)
    #   - foo-Administrator -> foo-admin
    s/-Administrator\(Access\)?/-Admin/

    # comment out to add profile prefix
    # ex.)
    #   - foo -> corp-foo
    #   - foo-admin -> corp-foo-Admin
    s/^/corp-/

    # comment out to lower case profile name
    #   - foo-admin -> corp-foo-admin
    s/.*/\L\0/

    s/.*/[profile "\0"]/
}
