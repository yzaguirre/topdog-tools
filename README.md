topdog-tools
============

Una colección de scripts python, node.js, powershell, etc.
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
nc-client pelicula-yify.mp4 pc-4k.local
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
lanchat, lanclipboard
====
Sends text to all connected servers via tcp sockets

Levantar un Servidor, puerto por defecto 1990. 
Revisa los servidores al rededor, si no hay que bien.
si hay, esperar recibir comunicación de un texto, del primer servidor de la lista
desde punto de vista POV
Envio una peticion de:
	isalive: true si esta atendiendo en su puerto. Si es el primero de la lista, solicito un gettext
	gettext: obtengo su texto, el servidor responde con un comportamiento similar a settext.
	settext: envio texto. Para todos mis destinatarios

No agregar clientes durante la ejecución, solo a un fichero de texto
Avisar cuando se conecta un cliente
Yo levanto el servidor, escucha el 1990 por peticiones
Guardar un hash del texto por cada modificion que se realice al textbox.
Si yo acabo de agregar el primer destinatario, el destinatario debe enviarme algo?
Agregar clientes al destinatario manualmente o agregar cliente al recibir una peticion
Al agregar automaticamente, avisar
Al agregar de cualquier forma, enviar automaticamente el texto actual.
al recibir peticion de texto, agregar el texto al textarea

Al detectar cambios al textarea departe del usuario, habilitar boton "Enviar".
Enviar peticion al "Enviar" y deshabilitar ese boton.
Si no puede acceder a un cliente, eliminarlo de la lista de destinatarios
Save last clip 
