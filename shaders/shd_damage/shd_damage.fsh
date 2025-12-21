//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    
	vec4 sample_color = texture2D( gm_BaseTexture, v_vTexcoord );
	
	sample_color.rgb = vec3(1);
	
	gl_FragColor = sample_color;
}
