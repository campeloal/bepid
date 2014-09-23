uniform mat4 uMVPMatrix;
attribute vec4 position;

void main()
{	

   vec4 v = position;
   v.z = 0.0;
   gl_Position = uMVPMatrix * v;

}
