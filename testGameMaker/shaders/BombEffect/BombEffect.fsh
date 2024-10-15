//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_colour;
uniform vec2 u_uv;
uniform float u_speed;
uniform float u_time;
uniform float u_section;
uniform float u_saturation;
uniform float u_brightness;
uniform float u_mix;


vec3 hsv3rgb(vec3 c)
{
	vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z*mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 hsv2rgb(vec3 c)
{
	vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


void main()
{
	// 현재 픽셀의 텍스처를 가져와 색상인 vector4를 반환
    // gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	// 이렇게 하면 모든 스프라이트는 직사각형이기 때문에 투명도를 고려하지 않으면 그냥 네모가 나와버림..
	//vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	//float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
	//gl_FragColor = v_vColour * vec4(gray, gray, gray, texColor.a); // 
	
	//vec3 col = vec3(v_vTexcoord.x, 1.0, 1.0);
	//float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
	//gl_FragColor = v_vColour * vec4(hsv3rgb(col), alpha);
	
	float pos = (v_vTexcoord.x - u_uv[0]) / (u_uv[1] - u_uv[0]);
	//vec3 col = vec3(pos, 1.0, 1.0);
	//vec3 col = vec3((u_time * u_speed) + pos, 1.0, 1.0);
	//float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
	
	vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	vec3 col = vec3(u_section * ((u_time * u_speed) + pos), u_saturation, u_brightness);
	vec4 finalCol = mix(texColor, vec4(hsv2rgb(col), texColor.a), u_mix);
	gl_FragColor = v_vColour * finalCol;
}
