varying mediump vec2 tCoord;
uniform sampler2D texture;

void main()
{
	gl_FragColor = texture2D(texture,tCoord);
}