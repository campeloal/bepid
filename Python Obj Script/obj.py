import sys
import numpy as np

def  readFaces():
	print 'faces'

def readObj(name):


	file = open(name, 'r')
	lines = file.readlines()
	file.close()

	for line in lines:

		line = np.asarray(line)
		line = line.split()

		print line

		if len(line) > 0:
			if line[0] == 'v':
				vertices = line.split()
				print 'vertice'

			elif line[0] == 'vn':
				normals = line.split()

				print 'normals'

			elif line[0] == 'vt':
				texture = line.split()
				print 'texture'

			elif line[0] == 'f':
				readFaces



if len(sys.argv) > 1:

	fileInput = sys.argv[1]
	fileOutput = sys.argv[2]

	readObj(fileInput)




