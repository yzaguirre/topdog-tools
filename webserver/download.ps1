# only available to PS > v3.0
function download(){
        Invoke-WebRequest http://david-toshiba.local/HelloWorld2-debug.exe -OutFile C:\tmp\HelloWorld2-debug.exe
        cd C:\tmp
        HelloWorld2-debug.exe
}

