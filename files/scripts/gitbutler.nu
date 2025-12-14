#!/usr/libexec/bluebuild/nu/nu

let rpm_url = http get https://app.gitbutler.com/api/downloads?limit=1&channel=release
    | get builds
    | get 0
    | where file =~ rpm
    | where arch =~ $env.OS_ARCH
    | get 0
    | get url

dnf5 install -y $rpm_url
