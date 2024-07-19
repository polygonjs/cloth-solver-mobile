
// INSERT DEFINES

#define DISTANCE

uniform vec3 referencePosition;
uniform float nearDistance;
uniform float farDistance;
varying vec3 vWorldPosition;

#include <common>



// /geo1/MAT/meshPhysical_CLOTH/grid1
// https://www.shadertoy.com/view/XtBfzz
// https://iquilezles.org/articles/checkerfiltering/

float gridTextureGradBox( in vec2 p, in float lineWidth, in vec2 ddx, in vec2 ddy )
{
	// filter kernel
	vec2 w = max(abs(ddx), abs(ddy)) + 0.01;

	// analytic (box) filtering
	vec2 a = p + 0.5*w;
	vec2 b = p - 0.5*w;
	vec2 i = (floor(a)+min(fract(a)/lineWidth,1.0)-
				floor(b)-min(fract(b)/lineWidth,1.0))/(w/lineWidth);
	//pattern
	return (1.0-i.x)*(1.0-i.y);
}

float grid( in vec2 p, in float lineWidth )
{
    // coordinates
    vec2 i = step( fract(p), vec2(1.0*lineWidth) );
    //pattern
    return (1.0-i.x)*(1.0-i.y);   // grid (N=10)
    
    // other possible patterns are these
    //return 1.0-i.x*i.y;           // squares (N=4)
    //return 1.0-i.x-i.y+2.0*i.x*i.y; // checker (N=2)
}







// /geo1/MAT/meshPhysical_CLOTH/attribute2
varying vec3 v_POLY_attribute_restP;




#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <clipping_planes_pars_fragment>

struct SSSModel {
	bool isActive;
	vec3 color;
	float thickness;
	float power;
	float scale;
	float distortion;
	float ambient;
	float attenuation;
};

void RE_Direct_Scattering(
	const in IncidentLight directLight,
	const in vec3 geometryNormal,
	const in vec3 geometryViewDir,
	const in SSSModel sssModel,
	inout ReflectedLight reflectedLight
	){
	vec3 scatteringHalf = normalize(directLight.direction + (geometryNormal * sssModel.distortion));
	float scatteringDot = pow(saturate(dot(geometryViewDir, -scatteringHalf)), sssModel.power) * sssModel.scale;
	vec3 scatteringIllu = (scatteringDot + sssModel.ambient) * (sssModel.color * (1.0-sssModel.thickness));
	reflectedLight.directDiffuse += scatteringIllu * sssModel.attenuation * directLight.color;
}

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( 1.0 );

	#include <map_fragment>
	#include <alphamap_fragment>



	// /geo1/MAT/meshPhysical_CLOTH/constant2
	vec3 v_POLY_constant2_val = vec3(0.07036009568874305, 0.5906188409113381, 0.06662593863608139);
	
	// /geo1/MAT/meshPhysical_CLOTH/constant1
	vec3 v_POLY_constant1_val = vec3(1.0, 1.0, 1.0);
	
	// /geo1/MAT/meshPhysical_CLOTH/attribute2
	vec3 v_POLY_attribute2_val = v_POLY_attribute_restP;
	
	// /geo1/MAT/meshPhysical_CLOTH/constant3
	float v_POLY_constant3_val = 5.0;
	
	// /geo1/MAT/meshPhysical_CLOTH/vec3ToFloat1
	float v_POLY_vec3ToFloat1_y = v_POLY_attribute2_val.y;
	float v_POLY_vec3ToFloat1_z = v_POLY_attribute2_val.z;
	
	// /geo1/MAT/meshPhysical_CLOTH/vec3ToFloat2
	float v_POLY_vec3ToFloat2_x = v_POLY_attribute2_val.x;
	float v_POLY_vec3ToFloat2_y = v_POLY_attribute2_val.y;
	
	// /geo1/MAT/meshPhysical_CLOTH/floatToVec2_1
	vec2 v_POLY_floatToVec2_1_vec2 = vec2(v_POLY_vec3ToFloat1_y, v_POLY_vec3ToFloat1_z);
	
	// /geo1/MAT/meshPhysical_CLOTH/floatToVec2_2
	vec2 v_POLY_floatToVec2_2_vec2 = vec2(v_POLY_vec3ToFloat2_x, v_POLY_vec3ToFloat2_y);
	
	// /geo1/MAT/meshPhysical_CLOTH/grid1
	vec2 v_POLY_grid1_coord = v_POLY_floatToVec2_1_vec2*vec2(1.0, 1.0)*v_POLY_constant3_val;
	float v_POLY_grid1_grid = gridTextureGradBox(v_POLY_grid1_coord, 0.1, dFdx(v_POLY_grid1_coord), dFdy(v_POLY_grid1_coord));
	
	// /geo1/MAT/meshPhysical_CLOTH/grid2
	vec2 v_POLY_grid2_coord = v_POLY_floatToVec2_2_vec2*vec2(1.0, 1.0)*v_POLY_constant3_val;
	float v_POLY_grid2_grid = gridTextureGradBox(v_POLY_grid2_coord, 0.1, dFdx(v_POLY_grid2_coord), dFdy(v_POLY_grid2_coord));
	
	// /geo1/MAT/meshPhysical_CLOTH/mult2
	float v_POLY_mult2_product = (v_POLY_grid1_grid * v_POLY_grid2_grid * 1.0);
	
	// /geo1/MAT/meshPhysical_CLOTH/mix1
	vec3 v_POLY_mix1_mix = mix(v_POLY_constant2_val, v_POLY_constant1_val, v_POLY_mult2_product);
	
	// /geo1/MAT/meshPhysical_CLOTH/output1
	diffuseColor.xyz = v_POLY_mix1_mix;
	float POLY_metalness = 1.0;
	float POLY_roughness = 1.0;
	vec3 POLY_emissive = vec3(1.0, 1.0, 1.0);
	SSSModel POLY_SSSModel = SSSModel(/*isActive*/false,/*color*/vec3(1.0, 1.0, 1.0), /*thickness*/0.1, /*power*/2.0, /*scale*/16.0, /*distortion*/0.1,/*ambient*/0.4,/*attenuation*/0.8 );
	float POLY_transmission = 1.0;
	float POLY_thickness = 1.0;




	// INSERT BODY

	#include <alphatest_fragment>

	float dist = length( vWorldPosition - referencePosition );
	dist = ( dist - nearDistance ) / ( farDistance - nearDistance );
	dist = saturate( dist ); // clamp to [ 0, 1 ]

	gl_FragColor = packDepthToRGBA( dist );

}
