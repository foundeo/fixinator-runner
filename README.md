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

