#define DISTANCE
varying vec3 vWorldPosition;
#include <common>
#include <batching_pars_vertex>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>



// /geo1/MAT/meshPhysical_CLOTH/clothSolverPosition1
// get vec2 tex coordinate from index
vec2 getClothSolverUV( float id, vec2 textureSize ) { 

	vec2 coords = vec2(
		floor( mod( ( id + 0.5 ), textureSize.x ) ),
		floor( ( id + 0.5 ) / textureSize.x )
	) + 0.5;

	return coords / textureSize;

}


vec3 clothSolverPosition(sampler2D tPosition0, sampler2D tPosition1, vec2 clothSolverUv) {
	return ( texture2D( tPosition0, clothSolverUv ).xyz + texture2D( tPosition1, clothSolverUv ).xyz ) / 1024.0;
}
vec3 clothSolverNormal(sampler2D tNormal, vec2 clothSolverUv) {
	return normalize( texture2D( tNormal, clothSolverUv ).xyz );
}







// /geo1/MAT/meshPhysical_CLOTH/clothSolverPosition1
uniform vec2 v_POLY_param_tSize;
uniform sampler2D v_POLY_texture_tPosition0;
uniform sampler2D v_POLY_texture_tPosition1;
uniform sampler2D v_POLY_texture_tNormal;

// /geo1/MAT/meshPhysical_CLOTH/attribute2
varying vec3 v_POLY_attribute_restP;

// /geo1/MAT/meshPhysical_CLOTH/attribute1
attribute float id;

// /geo1/MAT/meshPhysical_CLOTH/attribute2
attribute vec3 restP;




#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <batching_vertex>
	#include <skinbase_vertex>
	#ifdef USE_DISPLACEMENTMAP
// removed:
//		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinnormal_vertex>
	#endif
// removed:
//	#include <begin_vertex>



	// /geo1/MAT/meshPhysical_CLOTH/attribute1
	float v_POLY_attribute1_val = id;
	
	// /geo1/MAT/meshPhysical_CLOTH/attribute2
	v_POLY_attribute_restP = vec3(restP);
	
	// /geo1/MAT/meshPhysical_CLOTH/clothSolverPosition1
	vec2 v_POLY_clothSolverPosition1_clothSolverUv = getClothSolverUV(v_POLY_attribute1_val, v_POLY_param_tSize);
	vec3 v_POLY_clothSolverPosition1_position = clothSolverPosition(v_POLY_texture_tPosition0, v_POLY_texture_tPosition1, v_POLY_clothSolverPosition1_clothSolverUv);
	vec3 v_POLY_clothSolverPosition1_normal = clothSolverNormal(v_POLY_texture_tNormal, v_POLY_clothSolverPosition1_clothSolverUv);
	
	// /geo1/MAT/meshPhysical_CLOTH/output1
	vec3 transformed = v_POLY_clothSolverPosition1_position;
	vec3 objectNormal = normal;
	#ifdef USE_TANGENT
		vec3 objectTangent = vec3( tangent.xyz );
	#endif



	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <worldpos_vertex>
	#include <clipping_planes_vertex>
	vWorldPosition = worldPosition.xyz;
}