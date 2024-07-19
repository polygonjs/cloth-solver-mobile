// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { MeshBasicMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshBasic";
import { MeshPhysicalBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshPhysicalBuilder";
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
// obj
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { ActorSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Actor";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { ClothPrepareSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ClothPrepare";
import { ClothSolverSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ClothSolver";
import { FileOBJSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileOBJ";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { IcosahedronSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Icosahedron";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { ObjectPropertiesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ObjectProperties";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { RestAttributesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/RestAttributes";
import { SpotLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SpotLight";
import { SwitchSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Switch";
import { TextSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Text";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";

// named functions
import { addObjectToObjectPointerdownCheck } from "@polygonjs/polygonjs/dist/src/engine/functions/addObjectToObjectPointerdownCheck";
import { addObjectToPointerupCheck } from "@polygonjs/polygonjs/dist/src/engine/functions/addObjectToPointerupCheck";
import { clothConstraintSetPosition } from "@polygonjs/polygonjs/dist/src/engine/functions/clothConstraintSetPosition";
import { clothCreateConstraint } from "@polygonjs/polygonjs/dist/src/engine/functions/clothCreateConstraint";
import { clothDeleteConstraint } from "@polygonjs/polygonjs/dist/src/engine/functions/clothDeleteConstraint";
import { clothSolverReset } from "@polygonjs/polygonjs/dist/src/engine/functions/clothSolverReset";
import { clothSolverStepSimulation } from "@polygonjs/polygonjs/dist/src/engine/functions/clothSolverStepSimulation";
import { clothSolverUpdateMaterial } from "@polygonjs/polygonjs/dist/src/engine/functions/clothSolverUpdateMaterial";
import { getIntersectionAttributeNumberNearest } from "@polygonjs/polygonjs/dist/src/engine/functions/getIntersectionAttributeNumberNearest";
import { globalsRayFromCursor } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsRayFromCursor";
import { globalsTime } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTime";
import { globalsTimeDelta } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTimeDelta";
import { planeSet } from "@polygonjs/polygonjs/dist/src/engine/functions/planeSet";
import { rayIntersectPlane } from "@polygonjs/polygonjs/dist/src/engine/functions/rayIntersectPlane";

export const requiredImports_scene_01 = {
  nodes: [
    CameraOrbitControlsEventNode,
    MeshBasicMatNode,
    MeshPhysicalBuilderMatNode,
    MeshStandardBuilderMatNode,
    GeoObjNode,
    ActorSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    ClothPrepareSopNode,
    ClothSolverSopNode,
    FileOBJSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    IcosahedronSopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    ObjectPropertiesSopNode,
    PerspectiveCameraSopNode,
    PolarTransformSopNode,
    RestAttributesSopNode,
    SpotLightSopNode,
    SwitchSopNode,
    TextSopNode,
    TransformSopNode,
  ],
  operations: [],
  jsFunctions: [
    addObjectToObjectPointerdownCheck,
    addObjectToPointerupCheck,
    clothConstraintSetPosition,
    clothCreateConstraint,
    clothDeleteConstraint,
    clothSolverReset,
    clothSolverStepSimulation,
    clothSolverUpdateMaterial,
    getIntersectionAttributeNumberNearest,
    globalsRayFromCursor,
    globalsTime,
    globalsTimeDelta,
    planeSet,
    rayIntersectPlane,
  ],
};
