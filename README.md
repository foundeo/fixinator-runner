# fixinator-runner
A simple little CFML app to run scans with fixinator

## Setup

1) Download [this code](https://github.com/foundeo/fixinator-runner/archive/refs/heads/main.zip) unzip it, and place it in a folder, eg `fixinator-runner` on your CF server
2) Download the [FixinatorClient.zip](https://github.com/foundeo/fixinator/archive/refs/heads/master.zip) and extract all the files into a sub folder: `fixinator-runner/fixinatorclient`
3) Edit the `fixinator-runner/config.cfm` and specify paths and applications
4) Hit `fixinator-runner/scan.cfm` in your browser to generate the reports, optionally setup a scheduled task to automate the process

Your file structure on your CF server web root should look like this:

```
/fixinator_runner/
    Application.cfc
    config.cfm
    scan.cfm
    /fixinatorclient/
        box.json
        models/
        mixins/
        ...
```

## Example Config

```
{
    "fixinator_api_url": "https://fixinator.example.com/scan/",
    "fixinator_api_key": "",
    "report_directory": "c:\fixinator\reports\",
    "report_format": "pdf",
    "email_reports_from": "team@example.com",
    "applications": [
      {
        "name": "my_example_app",
        "path": "C:\my_example_app\",
        "email_reports_to": "",
        "fixinator_config": {
          "minConfidence": "high",
          "minSeverity": "high",
          "ignoreScanners": ["xss"]
        }
      },
      {
        "name": "my_other_app",
        "path": "C:\my_other_app\",
        "email_reports_to": "bob@example.com,sally@example.com",
        "fixinator_config": {
          "minConfidence": "low",
          "minSeverity": "low"
        }
      }
    ]
}
```
