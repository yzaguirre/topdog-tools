#!/usr/bin/env python
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-u", "--update", action="store_true", dest="update", default=False,
                  help="web server port to listen on PORT")
(options, args) = parser.parse_args()
import os, string
if options.update: # print all environment variables as on string
	with open("var_list.txt") as var_list, open("one_string.txt", "w") as one_string:
		one_string.write(string.replace(var_list.read(), os.linesep, os.pathsep))
		print 'check out file "one_string.txt"'
else:
	with open("var_list.txt", "w") as var_list:
		pathlist = string.replace(os.environ["PATH"], os.pathsep, os.linesep)
		var_list.write(pathlist)
		print 'check out file "var_list.txt"'
