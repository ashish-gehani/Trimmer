import os
import sys
import utils
from debloat import Debloat

def main(args):
	Debloat(utils.parse_args(args)).run()

main(sys.argv[1:])