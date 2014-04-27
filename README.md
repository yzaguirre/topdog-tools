topdog-tools
============

Una colección de scripts python, node.js, powershell, bash, etc.
netbest
====
Transferencia de ficheros via LAN en plano utilizando `ncat` (requiere `nmap`, compatible con `netcat` via ligera modificacion)
Habilitar puerto tcp 55556 INBOUND
Servidor
```
nc-server
```
Cliente
```
nc-client pelicula-yify.mp4 computadora-escritorio.local
```
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
Ejecutable para todo usuario NIX
```Bash
$ chmod +x webserver.js 
```
Conseguir `connect`, especificado en `package.json`
```Bash
$ npm update
```
Recibe el directorio como argumento. Puede ser una dirección absoluto o relativo.

Uso en NIX: Requiere de usuario `root`, dado que ocupa el puerto tcp 80
```Bash
$ su
./webserver.js /tmp
```
Uso en Windows:
```
node webserver.js C:\tmp
```
