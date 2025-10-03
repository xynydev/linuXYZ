let rpm_url = http get https://app.gitbutler.com/downloads
    | split row "\n"
    | where $it =~ "rpm"
    | where not ($it =~ "Nightly")
    | split row '"'
    | get 1

dnf5 install -y $rpm_url
