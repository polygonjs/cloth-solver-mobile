import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1721399315933",
  root: "1721399315933",
  nodes: {
    geo1: "1721399315933",
    "geo1/clothSolver1": "1721399315933",
    "geo1/MAT": "1721399315933",
    "geo1/MAT/meshPhysical_CLOTH": "1721399315933",
    "geo1/actor_clothSolver1": "1721399315933",
    ground: "1721399315933",
    "ground/MAT": "1675552563896",
    "ground/MAT/meshStandardBuilder1": "1721399315933",
    lights: "1721399315933",
    cameras: "1721399315933",
    "cameras/cameraControls1": "1721399315933",
    text: "1721399315933",
    "text/MAT": "1721399315933",
  },
  shaders: {
    "/geo1/clothSolver1": { position: "1721399315933" },
    "/geo1/MAT/meshPhysical_CLOTH": {
      vertex: "1721399315933",
      fragment: "1721399315933",
      "customDepthMaterial.vertex": "1721399315933",
      "customDepthMaterial.fragment": "1721399315933",
      "customDistanceMaterial.vertex": "1721399315933",
      "customDistanceMaterial.fragment": "1721399315933",
      "customDepthDOFMaterial.vertex": "1721399315933",
      "customDepthDOFMaterial.fragment": "1721399315933",
    },
    "/ground/MAT/meshStandardBuilder1": {
      vertex: "1721399315933",
      fragment: "1721399315933",
      "customDepthMaterial.vertex": "1721399315933",
      "customDepthMaterial.fragment": "1721399315933",
      "customDistanceMaterial.vertex": "1721399315933",
      "customDistanceMaterial.fragment": "1721399315933",
      "customDepthDOFMaterial.vertex": "1721399315933",
      "customDepthDOFMaterial.fragment": "1721399315933",
    },
  },
  jsFunctionBodies: { "/geo1/actor_clothSolver1": "1721399315933" },
};

export const loadSceneData_scene_01 = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "scene_01",
    urlPrefix: sceneDataRoot + "/scene_01",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
