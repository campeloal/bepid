varying mediump vec2 tCoord;
uniform sampler2D texture;

void main()
{
	gl_FragColor = texture2D(texture,tCoord);
    //gl_FragColor = vec4(tCoord.x, tCoord.y, 0.0, 1.0);
}