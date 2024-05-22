<cfscript>
  request.fixinator_runner_config = {
    "fixinator_api_url": "https://fixinator.example.com/scan/",
    "fixinator_api_key": "KEY-HERE",
    "report_directory": "c:\fixinator\reports\"
    "report_format": "pdf",
    "applications": [
      {
        "name": "my_example_app",
        "path": "C:\my_example_app\",
        "fixinator_config": {
          "minConfidence": "high",
          "minSeverity": "high"
        }
      },
      {
        "name": "my_other_app",
        "path": "C:\my_other_app\",
        "fixinator_config": {
          "minConfidence": "low",
          "minSeverity": "low"
        }
      }
    ]
  };
</cfscript>
