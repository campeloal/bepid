varying lowp float intensity;
	
void main()
{
	lowp vec4 color;
	
	if (intensity > 0.95)
		color = vec4(0.5,1.0,0.5,1.0);
	else if (intensity > 0.5)
		color = vec4(0.3,0.6,0.3,1.0);
	else
		color = vec4(0.1,0.2,0.1,1.0);

	gl_FragColor = color;
}