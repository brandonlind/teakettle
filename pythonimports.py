from __future__ import division
import numpy as np
import pandas as pd
from collections import OrderedDict, Counter
import os
from os import path as op
from os import listdir as ls
import pickle
import random
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.backends.backend_pdf import PdfPages
import string
from os import chdir as cd
from os import getcwd as cwd

import math
import shutil
from shutil import copy as cp
from shutil import move as mv

from matplotlib import pyplot as pl
import matplotlib.dates as mdates

def fs(DIR):
    return (sorted([op.join(DIR,f) for f in ls(DIR)]))
def uni(mylist):
    return (np.unique(mylist).tolist())
def luni(mylist):
    return (len(uni(mylist)))
def suni(mylist):
    return(sorted(uni(mylist)))
