uniform mat4 uMVPMatrix;
uniform vec3 lightDir;
attribute vec3 normal;
attribute vec4 position;
varying lowp float intensity;

void main()
{
	intensity = dot(lightDir,normal);
	gl_Position = uMVPMatrix * position;
} 