topdog-tools
============

Una colección de scripts python, node.js, powershell, etc.
alec
====

Asistente para CUP and JFlex escrito en python3. 
webserver
====
Servidor Web de ficheros estáticos de un directorio.
Utiliza node.js y connect.
Instalación
```Bash
$ cd topdog-tools/webserver/
```
Ejecutable para todo usuario *NIX
```Bash
$ chmod +x webserver.js 
```
Conseguir `connect`, especificado en `package.json`
```Bash
$ npm update
```
Recibe el directorio como argumento. Puede ser una dirección absoluto o relativo.
Uso en *NIX: Requiere de usuario `root`, dado que ocupa el puerto tcp 80
```Bash
$ su -
./webserver.js /tmp
```
Uso en Windows:
```
node webserver.js C:\tmp
```
