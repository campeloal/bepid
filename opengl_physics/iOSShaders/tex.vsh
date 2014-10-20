uniform mat4 uMVPMatrix;
attribute vec4 position;
attribute vec2 textCoord;
varying mediump vec2 tCoord;

void main() {
	tCoord = textCoord;
	gl_Position = uMVPMatrix * position;
}