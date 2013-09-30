function webserver([string]$rootdirectory){
        cd "C:\Users\David\AeroFS\web" # Script location
        if ($PSBoundParameters.ContainsKey('rootdirectory')){
                node server.js $rootdirectory
        } else {
                echo "Listing contents of AeroFS\web"
                ls
        }
}

function sharetmp{
        webserver "C:\Users\David\tmp" # share your tmp directory
}
