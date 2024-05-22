<cfinclude template="config.cfm">
<cfsetting requesttimeout="900">
<cfoutput>

<cftry>
    <cfif request.keyExists("fixinator_runner_config")>
        <cfset config = request.fixinator_runner_config>
    <cfelse>
        <cfthrow message="Missing config">
    </cfif>
    <h2>Configuration</h2>
    <p>Fixinator API Server: #encodeForHTML(config.fixinator_api_url)#</p>
    <p>Report Format: #encodeForHTML(config.report_format)#</p>
    <cfset fixinatorClient = new fixinatorclient.models.fixinator.FixinatorClient()>
    <cfset fixinatorClient.setAPIURL(config.fixinator_api_url)>
    <cfset fixinatorReport = new fixinatorclient.models.fixinator.FixinatorReport()>
    <cfif config.keyExists("fixinator_api_key") AND len(config.fixinator_api_key)>
        <cfset fixinatorClient.setAPIKey(config.fixinator_api_url)>
    <cfelse>
        <p><em>Fixinator API Key was not set (not defined in config), will use environment variables instead</em></p>
    </cfif>
    <cfif NOT ListFind(config.report_format, "html,pdf")>
        <cfthrow message="Invalid report_format, must be html or pdf">
    </cfif>
    <cfcatch>
        <cfoutput>
            <p>❌ Error initializing FixinatorClient / FixinatorReport.</p>
            <ul>
                <li><cfif fileExists(ExpandPath("./fixinatorclient/models/fixiantor/FixinatorClient.cfc"))>✅ FixinatorClient.cfc found<cfelse>❌ fixinatorclient/models/fixiantor/FixinatorClient.cfc missing</cfif> 
                <li><cfif fileExists(ExpandPath("./fixinatorclient/models/fixiantor/FixinatorReport.cfc"))>✅ FixinatorReport.cfc found<cfelse>❌ fixinatorclient/models/fixiantor/FixinatorReport.cfc missing</cfif> 
                <li><cfif fileExists(ExpandPath("./fixinatorclient/mixins/generate-pdf.cfm"))>✅ generate-pdf.cfm found<cfelse>❌ fixinatorclient/mixins/generate-pdf.cfm missing</cfif> 
            </ul>
            <p>#encodeForHTML(cfcatch.message)#</p>
            <cfdump var="#cfcatch#">
        </cfoutput>
    </cfcatch>
</cftry>
<h2>Applications</h2>
</cfoutput>
<cfif config.keyExists("applications") AND isArray(config.applications)>
<cfloop array="#config.applications#" index="app">
    <cfoutput>
        <h4>Scanning #encodeForHTML(app.name)#...</h4>
        <cftry>
            <!--- run scan --->
            <cfset result = fixinatorClient(path=app.path, config=app.fixinator_config)>

            <cfif url.keyExists("dump_results") AND url.dump_results>
                <cfdump var="#result#">
            </cfif>

            <!--- create report --->
            
            <cfset reportFile = config.report_directory & "fixiantor-#reReplace(lcase(app.name), "[^a-z0-9_-]", "", "ALL")#-#dateFormat(now(), "yyyy-mm-dd")#-#timeFormat(now(), "HH-mm")#.lcase(config.report_format)")>
            
            <cfset fixinatorReport.generateReport(format=config.report_format, resultFile=reportFile, data=result)>

            <p>Created report file: #encodeForHTML(getFileFromPath(reportFile))#</p>
            <cfif len(app.email_reports_to)>
                <cfmail to="#app.email_reports_to#" from="#config.email_reports_from#" subject="Fixinator Scan: #app.name#" type="html>
                    <cfif config.report_format IS "html">
                        <cfoutput>#fileRead(reportFile)#</cfoutput>
                    <cfelse>
                        <p>PDF Report is Attached</p>
                        <cfmailparam file="#reportFile#" type="application/pdf">
                    </cfif>
                </cfmail>
                <p>Sent report to: #encodeForHTML(app.email_reports_to)#</p>
            </cfif>

            <p>✅ Finished #encodeForHTML(app.name)#</p>
            <cfcatch type="any">
                <p>❌ Error while scanning #encodeForHTML(app.name)#</p>
                <p>#encodeForHTML(cfcatch.message)#</p>
                <cfdump var="#cfcatch#">
            </cfcatch>
        </cftry>
        <cftry><cfflush><cfcatch><!--- ignore flush error ---></cfcatch></cftry>
    </cfoutput>
</cfloop>
<cfelse>
<p>No applications configured.</p>
</cfif>