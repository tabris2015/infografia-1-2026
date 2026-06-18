"""Genera `gema.gltf`: una gema low-poly facetada, con DOS materiales.

No es arte dibujado a mano: es un modelo .gltf generado por código, igual que las
texturas generadas del módulo 10. Sirve para el demo de importación (escena 06):
un .gltf trae su malla, sus normales y sus materiales; Godot lo importa como una
escena (PackedScene) que se puede instanciar.

Formato: glTF 2.0 de texto, con el buffer binario embebido como data-URI base64
(self-contained, sin .bin aparte). Sombreado plano (flat): cada cara tiene sus
propios vértices con su normal, para que se vean las facetas.

Correr desde esta carpeta:
    python3 gen_gema.py
"""
from __future__ import annotations

import base64
import json
import math
import struct
from pathlib import Path

N = 6  # facetas alrededor (hexagonal)

# --- anillos de la gema (eje Y hacia arriba, como glTF) ---
TABLE_Y, TABLE_R = 0.5, 0.45   # mesa (tapa plana de arriba)
GIRDLE_Y, GIRDLE_R = 0.2, 0.78  # cintura (lo más ancho)
CULET_Y = -0.7                  # punta de abajo


def ring(y: float, r: float) -> list[tuple[float, float, float]]:
    out = []
    for i in range(N):
        a = 2.0 * math.pi * i / N
        out.append((r * math.cos(a), y, r * math.sin(a)))
    return out


table = ring(TABLE_Y, TABLE_R)
girdle = ring(GIRDLE_Y, GIRDLE_R)
culet = (0.0, CULET_Y, 0.0)
table_center = (0.0, TABLE_Y, 0.0)


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])


def cross(a, b):
    return (a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0])


def normalize(v):
    L = math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]) or 1.0
    return (v[0] / L, v[1] / L, v[2] / L)


def flat_tris(tris: list[tuple]) -> tuple[list[float], list[float]]:
    """Cada triángulo -> 3 vértices con la MISMA normal de cara (flat shading)."""
    pos, nrm = [], []
    for p0, p1, p2 in tris:
        n = normalize(cross(sub(p1, p0), sub(p2, p0)))
        for p in (p0, p1, p2):
            pos += [p[0], p[1], p[2]]
            nrm += [n[0], n[1], n[2]]
    return pos, nrm


# --- primitiva A: corona (mesa + facetas de arriba), material claro ---
corona_tris = []
# mesa: abanico desde el centro
for i in range(N):
    corona_tris.append((table_center, table[i], table[(i + 1) % N]))
# facetas de la corona: quad (table[i], table[i+1], girdle[i+1], girdle[i]) -> 2 tris
for i in range(N):
    j = (i + 1) % N
    corona_tris.append((table[i], girdle[i], girdle[j]))
    corona_tris.append((table[i], girdle[j], table[j]))

# --- primitiva B: pabellón (facetas hacia la punta), material oscuro ---
pabellon_tris = []
for i in range(N):
    j = (i + 1) % N
    pabellon_tris.append((girdle[i], culet, girdle[j]))

corona_pos, corona_nrm = flat_tris(corona_tris)
pabellon_pos, pabellon_nrm = flat_tris(pabellon_tris)


def pack_primitive(pos: list[float], nrm: list[float]) -> dict:
    n_verts = len(pos) // 3
    idx = list(range(n_verts))  # cada vértice se usa una vez (flat)
    return {"pos": pos, "nrm": nrm, "idx": idx, "n": n_verts}


prims = [pack_primitive(corona_pos, corona_nrm), pack_primitive(pabellon_pos, pabellon_nrm)]

# --- empaquetar todo en un buffer binario ---
blob = bytearray()
buffer_views = []
accessors = []


def add_view(data: bytes, target: int) -> int:
    # alinear a 4 bytes
    while len(blob) % 4 != 0:
        blob.append(0)
    offset = len(blob)
    blob.extend(data)
    buffer_views.append({"buffer": 0, "byteOffset": offset, "byteLength": len(data), "target": target})
    return len(buffer_views) - 1


def add_float_accessor(values: list[float], comps: int, target: int, with_minmax: bool) -> int:
    data = struct.pack("<%df" % len(values), *values)
    view = add_view(data, target)
    acc = {"bufferView": view, "componentType": 5126, "count": len(values) // comps,
           "type": "VEC3" if comps == 3 else "SCALAR"}
    if with_minmax:
        mins = [min(values[c::comps]) for c in range(comps)]
        maxs = [max(values[c::comps]) for c in range(comps)]
        acc["min"], acc["max"] = mins, maxs
    accessors.append(acc)
    return len(accessors) - 1


def add_index_accessor(values: list[int]) -> int:
    data = struct.pack("<%dH" % len(values), *values)
    view = add_view(data, 34963)  # ELEMENT_ARRAY_BUFFER
    accessors.append({"bufferView": view, "componentType": 5123, "count": len(values), "type": "SCALAR"})
    return len(accessors) - 1


mesh_primitives = []
for i, p in enumerate(prims):
    pos_acc = add_float_accessor(p["pos"], 3, 34962, with_minmax=True)
    nrm_acc = add_float_accessor(p["nrm"], 3, 34962, with_minmax=False)
    idx_acc = add_index_accessor(p["idx"])
    mesh_primitives.append({
        "attributes": {"POSITION": pos_acc, "NORMAL": nrm_acc},
        "indices": idx_acc,
        "material": i,
    })

data_uri = "data:application/octet-stream;base64," + base64.b64encode(bytes(blob)).decode("ascii")

gltf = {
    "asset": {"version": "2.0", "generator": "gen_gema.py (infografia módulo 12)"},
    "scene": 0,
    "scenes": [{"name": "Gema", "nodes": [0]}],
    "nodes": [{"name": "Gema", "mesh": 0}],
    "meshes": [{"name": "Gema", "primitives": mesh_primitives}],
    "materials": [
        {"name": "Corona",
         "pbrMetallicRoughness": {"baseColorFactor": [0.55, 0.85, 0.95, 1.0],
                                  "metallicFactor": 0.3, "roughnessFactor": 0.15}},
        {"name": "Pabellon",
         "pbrMetallicRoughness": {"baseColorFactor": [0.15, 0.35, 0.7, 1.0],
                                  "metallicFactor": 0.4, "roughnessFactor": 0.25}},
    ],
    "buffers": [{"byteLength": len(blob), "uri": data_uri}],
    "bufferViews": buffer_views,
    "accessors": accessors,
}

out = Path(__file__).resolve().parent / "gema.gltf"
out.write_text(json.dumps(gltf, indent=2), encoding="utf-8")
print(f"escrito {out}  ({len(blob)} bytes de buffer, {sum(len(p['idx']) for p in prims)//3} triángulos)")
