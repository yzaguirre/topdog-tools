#!/usr/bin/env python3
from shutil import copy
import os
sep = os.sep #"/" on linux "\\" on Win
source="C:{0}Users{0}David{0}Documents{0}Proyecto1_200819312.jar".format(sep)
destination="C:{0}Users{0}David{0}Desktop{0}Proyecto1_200819312.jar".format(sep)
copy(source, destination)
