// Vertex shader Phong Shading - Per-pixel lighting

uniform mat4 uMVPMatrix;
uniform mat4 normalMatrix;

// eye pos
uniform vec3 eyePos;

// position and normal of the vertices
attribute vec4 position;
attribute vec3 normal;

// lighting
uniform vec4 lightPos;
uniform vec4 lightColor;

// material
uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

// normals to pass on
varying vec3 vNormal;
varying vec3 EyespaceNormal;

varying vec3 lightDir, eyeVec;

void main() {
	// normal
	EyespaceNormal = vec3(normalMatrix * vec4(normal, 1.0));
	
	// the vertex position
	vec4 p = uMVPMatrix * position;
	
	// light dir
	lightDir = lightPos.xyz - p.xyz;
	eyeVec = -position.xyz;
	
	gl_Position = uMVPMatrix * position;
}