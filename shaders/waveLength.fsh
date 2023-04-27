//this code fucking sucks and I hope to be able to fix it someday.
float simple_interpolate(in float a, in float b, in float x) {
   return a + smoothstep(0.0,1.0,x) * (b-a);
}

float rand3D(in vec3 co){
	return fract(sin(dot(co.xyz ,vec3(12.9898,78.233,144.7272))) * 43758.5453);
}

float interpolatedNoise3D(in float x, in float y, in float z) {
	float integer_x = x - fract(x); float fractional_x = x - integer_x;
	float integer_y = y - fract(y); float fractional_y = y - integer_y;
	float integer_z = z - fract(z); float fractional_z = z - integer_z;

	float v1 = rand3D(vec3(integer_x, integer_y, integer_z));
	float v2 = rand3D(vec3(integer_x+1.0, integer_y, integer_z));
	float v3 = rand3D(vec3(integer_x, integer_y+1.0, integer_z));
	float v4 = rand3D(vec3(integer_x+1.0, integer_y +1.0, integer_z));

	float v5 = rand3D(vec3(integer_x, integer_y, integer_z+1.0));
	float v6 = rand3D(vec3(integer_x+1.0, integer_y, integer_z+1.0));
	float v7 = rand3D(vec3(integer_x, integer_y+1.0, integer_z+1.0));
	float v8 = rand3D(vec3(integer_x+1.0, integer_y +1.0, integer_z+1.0));

	float i1 = simple_interpolate(v1, v5, fractional_z);
	float i2 = simple_interpolate(v2, v6, fractional_z);
	float i3 = simple_interpolate(v3, v7, fractional_z);
	float i4 = simple_interpolate(v4, v8, fractional_z);

	float ii1 = simple_interpolate(i1, i2, fractional_x);
	float ii2 = simple_interpolate(i3, i4, fractional_x);

	return simple_interpolate(ii1 , ii2 , fractional_y);
}

vec4 Process(vec4 color) {
   return getTexel(gl_TexCoord[0].st) * (0.8 + interpolatedNoise3D(pixelpos.x / 512.f, pixelpos.y / 512.f, pixelpos.z / 512.f) * 0.4) * color;
}