#define STANDARD
#ifdef PHYSICAL
	#define IOR
	#define USE_SPECULAR
#endif
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float roughness;
uniform float metalness;
uniform float opacity;
#ifdef IOR
	uniform float ior;
#endif
#ifdef USE_SPECULAR
	uniform float specularIntensity;
	uniform vec3 specularColor;
	#ifdef USE_SPECULAR_COLORMAP
		uniform sampler2D specularColorMap;
	#endif
	#ifdef USE_SPECULAR_INTENSITYMAP
		uniform sampler2D specularIntensityMap;
	#endif
#endif
#ifdef USE_CLEARCOAT
	uniform float clearcoat;
	uniform float clearcoatRoughness;
#endif
#ifdef USE_IRIDESCENCE
	uniform float iridescence;
	uniform float iridescenceIOR;
	uniform float iridescenceThicknessMinimum;
	uniform float iridescenceThicknessMaximum;
#endif
#ifdef USE_SHEEN
	uniform vec3 sheenColor;
	uniform float sheenRoughness;
	#ifdef USE_SHEEN_COLORMAP
		uniform sampler2D sheenColorMap;
	#endif
	#ifdef USE_SHEEN_ROUGHNESSMAP
		uniform sampler2D sheenRoughnessMap;
	#endif
#endif
#ifdef USE_ANISOTROPY
	uniform vec2 anisotropyVector;
	#ifdef USE_ANISOTROPYMAP
		uniform sampler2D anisotropyMap;
	#endif
#endif
varying vec3 vViewPosition;
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
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <alphahash_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <iridescence_fragment>
#include <cube_uv_reflection_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_physical_pars_fragment>
#include <fog_pars_fragment>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_physical_pars_fragment>
#include <transmission_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <clearcoat_pars_fragment>
#include <iridescence_pars_fragment>
#include <roughnessmap_pars_fragment>
#include <metalnessmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
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
	vec4 diffuseColor = vec4( diffuse, opacity );



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



	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive * POLY_emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <alphahash_fragment>
	float roughnessFactor = roughness * POLY_roughness;

#ifdef USE_ROUGHNESSMAP

	vec4 texelRoughness = texture2D( roughnessMap, vUv );

	// reads channel G, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	roughnessFactor *= texelRoughness.g;

#endif

	float metalnessFactor = metalness * POLY_metalness;

#ifdef USE_METALNESSMAP

	vec4 texelMetalness = texture2D( metalnessMap, vUv );

	// reads channel B, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	metalnessFactor *= texelMetalness.b;

#endif

	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <clearcoat_normal_fragment_begin>
	#include <clearcoat_normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_physical_fragment>
	#include <lights_fragment_begin>
if(POLY_SSSModel.isActive){
	RE_Direct_Scattering(directLight, geometryNormal, geometryViewDir, POLY_SSSModel, reflectedLight);
}


	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 totalDiffuse = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse;
	vec3 totalSpecular = reflectedLight.directSpecular + reflectedLight.indirectSpecular;
	
#ifdef USE_TRANSMISSION

	material.transmission = transmission * POLY_transmission;
	material.transmissionAlpha = 1.0;
	material.thickness = thickness * POLY_thickness;
	material.attenuationDistance = attenuationDistance;
	material.attenuationColor = attenuationColor;

	#ifdef USE_TRANSMISSIONMAP

		material.transmission *= texture2D( transmissionMap, vTransmissionMapUv ).r;

	#endif

	#ifdef USE_THICKNESSMAP

		material.thickness *= texture2D( thicknessMap, vThicknessMapUv ).g;

	#endif

	vec3 pos = vWorldPosition;
	vec3 v = normalize( cameraPosition - pos );
	vec3 n = inverseTransformDirection( normal, viewMatrix );

	vec4 transmitted = getIBLVolumeRefraction(
		n, v, material.roughness, material.diffuseColor, material.specularColor, material.specularF90,
		pos, modelMatrix, viewMatrix, projectionMatrix, material.ior, material.thickness,
		material.attenuationColor, material.attenuationDistance );

	material.transmissionAlpha = mix( material.transmissionAlpha, transmitted.a, material.transmission );

	totalDiffuse = mix( totalDiffuse, transmitted.rgb, material.transmission );

#endif

	vec3 outgoingLight = totalDiffuse + totalSpecular + totalEmissiveRadiance;
	#ifdef USE_SHEEN
		float sheenEnergyComp = 1.0 - 0.157 * max3( material.sheenColor );
		outgoingLight = outgoingLight * sheenEnergyComp + sheenSpecularDirect + sheenSpecularIndirect;
	#endif
	#ifdef USE_CLEARCOAT
		float dotNVcc = saturate( dot( geometryClearcoatNormal, geometryViewDir ) );
		vec3 Fcc = F_Schlick( material.clearcoatF0, material.clearcoatF90, dotNVcc );
		outgoingLight = outgoingLight * ( 1.0 - material.clearcoat * Fcc ) + ( clearcoatSpecularDirect + clearcoatSpecularIndirect ) * material.clearcoat;
	#endif
	#include <opaque_fragment>
	#include <tonemapping_fragment>
	#include <colorspace_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}