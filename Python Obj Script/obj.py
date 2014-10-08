import sys
import numpy as np

vertexBuffer = []
positions = []
normals = []
textures = []
onlyVertices = []
hasTexture = False
numberIndices = 0

def  readFaces(line):

        triangle = []
        splitFactor = '' 
                
        for vertex in line:
                texIndex = 0
                
                if hasTexture:
                        triangle = vertex.split('/')
                        texIndex = int(triangle[2])
                else:
                        triangle = vertex.split('//')
                
                posIndex = int(triangle[0])
                normalIndex = int(triangle[1])
                

                posStartIndex = (posIndex*3) - 3
                normStartIndex = (normalIndex*3) - 3
                texStartIndex = (texIndex*2) - 2

                vertexBuffer.append(positions[posStartIndex])
                vertexBuffer.append(positions[posStartIndex + 1])
                vertexBuffer.append(positions[posStartIndex + 2])
                onlyVertices.append(positions[posStartIndex])
                onlyVertices.append(positions[posStartIndex + 1])
                onlyVertices.append(positions[posStartIndex + 2])
                vertexBuffer.append(normals[normStartIndex])
                vertexBuffer.append(normals[normStartIndex + 1])
                vertexBuffer.append(normals[normStartIndex + 2])

                if hasTexture:
                        texIndex = triangle[2]
                        vertexBuffer.append(textures[texStartIndex])
                        vertexBuffer.append(textures[texStartIndex + 1])


def readObj(path):

	file = open(path, 'r')
	lines  = []

	for line in file:
                lineArgs = []
                lineArgs = line.split()
                

		if len(lineArgs) >= 3:
                        verticeType = lineArgs[0]
			if verticeType == 'v':
                                positions.append(lineArgs[1])
				positions.append(lineArgs[2])
				positions.append(lineArgs[3])

			elif verticeType == 'vn':
				normals.append(lineArgs[1])
                                normals.append(lineArgs[2])
                                normals.append(lineArgs[3])

			elif verticeType == 'vt':
				textures.append(lineArgs[1])
				textures.append(lineArgs[2])
				textures.append(lineArgs[3])
				hasTexture = True

			elif verticeType == 'f':
                                del lineArgs[0]
                                global numberIndices
                                numberIndices+=1
				readFaces(lineArgs)
        file.close()

def writeFile(path):
        file = open(path, 'w')
        vertexBufferString = ''
        file.write("vertexBuffer[] = {")
        
        for coordinate in vertexBuffer:
                vertexBufferString += coordinate
                vertexBufferString += ','

        #remove last ,
        vertexBufferString = vertexBufferString[:-1]
        file.write(vertexBufferString)
        file.write("};\n")
        file.write("onlyVertices[] = {")

        onlyVertString = ''
        
        for coordinate in onlyVertices:
                onlyVertString += coordinate
                onlyVertString += ','

        file.write(onlyVertString)
        file.write('};\n')

        global numberIndices
        numberIndices= numberIndices*3

        file.write('int numberIndices = ')

        file.write(str(numberIndices))
        file.write(';')
        file.close()

if len(sys.argv) > 1:

	fileInput = sys.argv[1]
	fileOutput = sys.argv[2]

	readObj(fileInput)
        writeFile(fileOutput)

        print 'File created.' 


