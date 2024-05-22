<cfscript>
  request.fixinator_runner_config = {
    "fixinator_api_url": "https://fixinator.example.com/scan/",
    "fixinator_api_key": "",
    "report_directory": "c:\fixinator\reports\"
    "report_format": "pdf",
    "email_reports_from": "team@example.com",
    "applications": [
      {
        "name": "my_example_app",
        "path": "C:\my_example_app\",
        "email_reports_to": "",
        "fixinator_config": {
          "minConfidence": "high",
          "minSeverity": "high"
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
  };
</cfscript>
