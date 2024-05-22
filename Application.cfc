component {
    this.name = "fixinator_runner";
    this.sessionManagent = false;
    this.clientManagement = false;
    this.clientStorage = "memory";
    
    this.mappings["/fixinatorclient"] = getDirectoryFromPath(getCurrentTemplatePath()) & "fixinatorclient";
}