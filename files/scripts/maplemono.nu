#!/usr/libexec/bluebuild/nu/nu

let variants = http get https://api.github.com/repos/subframe7536/maple-font/releases | get 0 | get assets | where name =~ ".zip"

[
    "MapleMono-Variable.zip", "MapleMonoNormal-Variable.zip",
    "MapleMono-TTF.zip", "MapleMono-TTF-AutoHint.zip", "MapleMonoNormal-TTF.zip", "MapleMonoNormal-TTF-AutoHint.zip",
    "MapleMono-NF-unhinted.zip", "MapleMono-NF.zip", "MapleMonoNormal-NF-unhinted.zip", "MapleMonoNormal-NF.zip"
] | each { |variant| dl_variant $variant }


def dl_variant [variant: string] {
    let url = $variants | where name == $variant | get browser_download_url | get 0
    http get $url | save --force $"/tmp/($variant)"
    unzip $"/tmp/($variant)" -d $"/usr/share/fonts/($variant | str replace ".zip" "")"
}
