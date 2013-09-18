#!/usr/bin/env python3
# Copyright 2012 David Y. Gonzalez

# This file is part of A.L.E.C.
# A.L.E.C. is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# [at your option] any later version.
# A.L.E.C. is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with A.L.E.C.  If not, see <http://www.gnu.org/licenses/>.

import sys,os,platform
from subprocess import call
from time import sleep	
#conseguir os username
un = os.environ['USERNAME']
#conseguir cwd
sep = os.sep #"/" on linux "\\" on Win
cwd = os.getcwd()
script_path = sys.path[0] + sep + "Endgame" # "Endgame" would be the name of your Netbeans project folder

project_name = script_path.split(sep)[-1].lower()
pardir = os.pardir
pathsep = os.pathsep #":" on linux ";" on Win
curdir = os.curdir #mostly "."
linesep = os.linesep # \n or \f\n
#conseguir os name 
osname = sys.platform
isLinux = osname.startswith('linux')
isWin = osname.startswith('win')
#otras variables
cup = os.environ["CUP"]
jflex = os.environ["JFLEX"]

#Cambiando nombre de la ventana
if isWin:
	call("title A.L.E.C. C2 Flavor - %s" % project_name, shell=True)
else:
	call("\x1b]2;A.L.E.C. C2 Flavor - %s\x07" % project_name, shell=True)
#definiendo metodos
def handle_jflex(package_name="analisis", jflex_name="scanner01.lex"):
	#java -jar "%JFLEX%\lib\JFlex.jar" 4scanner.lex -d src\analisis
	str_jflex = "java -jar \"{1}{0}lib{0}JFlex.jar\" src{0}{3}{0}{2} -d src{0}{4}".format(sep,jflex,jflex_name,project_name,package_name)
	print_exe(str_jflex)
	call(str_jflex, shell=True)
def handle_cup(package_name="analisis", parser_java="Parser01.java", simbolos_java="Simbolos01.java", cup_name="parser01.cup"):
	#java -jar "%CUP%\java-cup-11a.jar" -package analisis -parser Parser -symbols Simbolos 5parser.cup	
	str_cup = "java -jar \"{1}{0}java-cup-11a.jar\" -package {2} -parser {3} -interface -symbols {4} src{0}{6}{0}{5}".format(sep, cup, package_name, parser_java.split('.')[-2], simbolos_java.split('.')[-2], cup_name,project_name)
	print_exe(str_cup)
	res = call(str_cup, shell=True)
	if not res == 0:
		print("%sCUP program didn't end well, master %s. I recommend you check the logs." % (linesep, un))
		return
	print("Moving Files")
	# antes de mover, modificar el fichero
	with open(parser_java, "r+") as f:
		f.seek(558, 0)
		f.write("BigParser                 ")
	if isWin:
		#move Parser.java src/analisis
		#move Simbolos.java src/analisis
		str_move = "move {1} src{0}{2}"
		call(str_move.format(sep, parser_java, package_name), shell=True)
		call(str_move.format(sep, simbolos_java, package_name), shell=True)
	elif isLinux:
		#mv Parser.java Simbolos.java src/analisis
		call("mv -v {1} {2} src{0}{3}".format(sep, parser_java, simbolos_java, package_name), shell=True)
	else:
		print("could't move files... dang it!")
def compile_java():
	#cd "src"
	os.chdir("src")
	print("cd src")
	#javac -d "../build/classes" -cp ".;../lib/java-cup-11a-runtime.jar" proyecto1_200819312/proyecto1_200819312.java
	str_javac = "javac -d \"{3}{0}build{0}classes\" -cp \"{2}{1}{3}{0}lib{0}java-cup-11a-runtime.jar\" {4}{0}{5}".format(sep, pathsep, curdir, pardir, project_name, "Main.java")
	print_exe(str_javac)
	call(str_javac, shell=True)
	os.chdir(pardir)#go back
	print("cd",pardir)
def run_java(graphical = False):
	#cd build/classes
	chdir = "build{0}classes".format(sep)
	os.chdir(chdir)
	print("cd " + chdir)
	#java -Dswing.defaultlaf=com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel -cp ".;../../lib/java-cup-11a-runtime.jar;" proyecto1_200819312.Proyecto1_200819312 
	if graphical:
		str_java = "{6}java -Dswing.defaultlaf=com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel -cp \"{2}{1}{3}{0}{3}{0}lib{0}java-cup-11a-runtime.jar{1}{3}{0}{3}{0}lib{0}log4j-1.2.17.jar\" {4}.{5}{7}".format(sep, pathsep, curdir, pardir, project_name, "Main", "start \"%s\" cmd /K " % project_name if isWin else "terminator -T \"A.L.E.C. - %s Flavor\" -x " % project_name, " &" if isLinux else "")
	else:
		str_java = "java -cp \"{2}{1}{3}{0}{3}{0}lib{0}java-cup-11a-runtime.jar\" {4}.{5} {6}".format(sep, pathsep, curdir, pardir, project_name, "Main", "{1}{0}{1}{0}src{0}test.txt".format(sep, pardir))
	print_exe(str_java)
	res = call(str_java, shell=True)
	sleep(1)
	if not res == 0:
		print("%sIt is to my knowledge your last excecution ended with code %d. I recommend you visit the logs." % (linesep, res))
	chdir = pardir + sep + pardir
	os.chdir(chdir)#go back
	#print(linesep + "cd",chdir)
def erase_log(log_name="log-file.txt"):
	chdir = "log"
	os.chdir(chdir)
	print("cd " + chdir)
	try:
		f = open(log_name, "w")
		f.close()
		print('"{0}" has been wiped clean!'.format(log_name))
	except IOError:
		print("File must be in use or may not exist, %s" % un)
		pass
	chdir = pardir
	os.chdir(chdir)#go back
def run_jar():
	#cd build/classes
	# chdir = "build{0}classes".format(sep)
	chdir = "dist"
	os.chdir(chdir)
	print("cd " + chdir)
	#java -Dswing.defaultlaf=com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel -cp ".;../../lib/java-cup-11a-runtime.jar;" proyecto1_200819312.Proyecto1_200819312 
	# str_java = "{5}java -jar -Dswing.defaultlaf=com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel -cp \"{2}{1}lib{0}java-cup-11a-runtime.jar{1}lib{0}log4j-1.2.17.jar{1}lib{0}AbsoluteLayout.jar\" {4}.jar {6}".format(sep, pathsep, curdir, pardir, project_name, "start \"%s\" cmd /K " % project_name if isWin else "terminator -T \"A.L.E.C. - %s Flavor\" -x ", " &" if isLinux else "")
	str_java = "{1}java -jar -Dswing.defaultlaf=com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel {0}.jar {2}".format(project_name, "start \"%s\" cmd /K " % project_name if isWin else "terminator -T \"A.L.E.C. - %s Flavor\" -x ", " &" if isLinux else "")
	print_exe(str_java)
	res = call(str_java, shell=True)
	sleep(1)
	if not res == 0:
		print("%sIt is to my knowledge your last excecution ended with code %d. I recommend you visit the logs." % (linesep, res))
	chdir = pardir
	os.chdir(chdir)#go back
	#print(linesep + "cd",chdir)
def handle_Input(key):
	if key == 1:
		handle_jflex()
	elif key == 2:
		handle_cup()
	elif key == 3:
		erase_log()
	elif key == 4:
		run_java(graphical=True)
	elif key == 5:
		run_jar()
	else:
		print("selection invalid!")
def clear_clr():
	if isWin:
		call("cls",shell=True)
	elif isLinux:
		call("clear",shell=True)
	else:
		print("couldn't clear the screen!")
def print_exe(str_command):
	#print("Excecuting Statement: ")
	print(str_command)
def check_cwd():
	global cwd
	print("CWD -> %s" % cwd)
	if cwd != script_path:
		print("Changing CWD to -> " + script_path)
		cwd = script_path
		os.chdir(cwd)
def press_any_key():
	# try:
		# input("%sPress ENTER to continue, %s" % (linesep,un))
	# except SyntaxError:#for python2
		# pass
	print("%sPress ANY KEY to continue, %s" % (linesep,un))
	if isWin:
		import msvcrt
		getch = msvcrt.getch()
		
	elif isLinux:
		import tty, termios
		fd = sys.stdin.fileno()
		old_settings = termios.tcgetattr(fd)
		try:
			tty.setraw(sys.stdin.fileno())
			ch = sys.stdin.read(1)
		finally:
			termios.tcsetattr(fd, termios.TCSANOW, old_settings)
		#return ch
def print_mainheader():
	clear_clr()
	print("A.L.E.C. Accomplice Library for Exclusive Coding - \"Compiladores 2\" Flavor")
	print("Greetings master %s!%s" % (un, linesep))
	
	print("You're working on %s%s" % (platform.platform(), linesep))
	check_cwd()
	print("Project name: " + project_name)
#menu princpal
def go():
	while True:
		print_mainheader()
		print("%sThese are your options for \"Compiladores 2\"" % linesep)
		print('1.) JFlex "Scanner01.lex"')
		print('2.) CUP "Parser01.cup"')
		print("3.) Erase Log")
		print("4.) Run Java")
		print("5.) Run Jar")
		print("%sJust press ENTER or type 0 to EXIT" % linesep)
		key = ""
		try:
			key = input('Select option: ') # python3 doesn't throw SyntaxError
		except SyntaxError:#for python2
			pass
		if not key or key == "0": break;
		print()
		try:
			handle_Input(int(key))
		except ValueError:
			print("Not a valid choice, %s" % un)
		press_any_key()
	print("%sWe're done here" % linesep)
go()
