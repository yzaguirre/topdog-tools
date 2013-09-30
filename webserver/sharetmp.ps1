function webserver([string]$rootdirectory){
        if ($PSBoundParameters.ContainsKey('rootdirectory')){
                node C:\topdog-tools\webserver\webserver.js $rootdirectory
        } else {
                echo "Must specify an absolute or relative path."
        }
}

function sharetmp{
        webserver "C:\Users\David\tmp" # share your tmp directory
}
