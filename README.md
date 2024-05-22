# fixinator-runner
A simple little CFML app to run scans with fixinator

## Setup

1) Download [this code](https://github.com/foundeo/fixinator-runner/archive/refs/heads/main.zip) unzip it, and place it in a folder, eg `fixinator_runner` on your CF server
2) Download the [FixinatorClient.zip](https://github.com/foundeo/fixinator/archive/refs/heads/master.zip) and extract all the files into a sub folder: `fixinator_runner/fixinatorclient`

Your file structure should look like this:

```
/fixinator_runner/
    config.cfm
    scan.cfm
    /fixinatorclient/
        box.json
        models/
        mixins/
    ...
```

