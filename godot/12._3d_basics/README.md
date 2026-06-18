# 12._3d_basics — Godot 3D básico

Proyecto Godot 4.6. **Módulo 12**, dos sesiones para abrir la **tercera dimensión**
*después* del capstone. No es prerrequisito de nada: el mensaje es "ya enviaste un juego
2D, mira lo poco que cambia en 3D".

- **Sesión 1 — El espacio 3D** (ver y construir): Node3D y `Transform3D`, primitivas,
  cámara + luz + entorno, materiales PBR, transformar en código, importar un modelo glTF.
- **Sesión 2 — Moverse en 3D** (física → jugable): `RigidBody3D` vs `StaticBody3D`, empujar
  con fuerzas desde el input, cámara que sigue + recolectar con `Area3D`, y un **roll-a-ball**
  completo como cierre.

**La idea del módulo:** casi todo lo que ya sabes en 2D tiene un **gemelo en 3D**. `Node2D`
→ `Node3D`, `Sprite2D` → `MeshInstance3D` + material, `Camera2D` → `Camera3D`,
`CharacterBody2D` → cuerpo físico. Lo nuevo de verdad: un eje más, la **iluminación**
(sin luz no se ve nada) y que la matemática de proyección que hiciste a mano en el módulo
6 ahora la multiplica el motor por ti. (Detalle de diseño en `PLAN.md`.)

## Cómo correr

Abre la carpeta en Godot 4.6. Cada escena se corre sola con **F6**; el juego final
(`10_roll_a_ball`) con **F5**.

| Escena | Tier | Sesión | Qué muestra |
|---|---|---|---|
| `scenes/01_node3d_transform.tscn` | ✅ demo | 1 | Node3D + un `Transform3D`: una caja trasladada, rotada y escalada. |
| `scenes/02_primitivas.tscn` | ✅ demo | 1 | Las mallas de fábrica: caja, esfera, cilindro, cápsula, plano. |
| `scenes/03_camara_luz.tscn` | ✅ demo | 1 | `Camera3D` + `DirectionalLight3D` + `WorldEnvironment`. Teclas **1..4**: el "¿por qué negro?". |
| `scenes/04_materiales.tscn` | ✅ demo | 1 | `StandardMaterial3D`/PBR: albedo, roughness, metallic, emission. |
| `scenes/05_transformaciones.tscn` | 🔨 docente | 1 | Girar en código (`rotate_y`). La luna orbita; el planeta no gira hasta tu línea. |
| `scenes/06_modelo_gltf.tscn` | ✅ demo | 1 | Importar `assets/gema.gltf`: malla + materiales; el "gotcha" de escala. |
| `scenes/07_cuerpos_fisicos.tscn` | ✅ demo | 2 | `RigidBody3D` vs `StaticBody3D`: caen, rebotan, chocan con el piso y los muros. |
| `scenes/08_input_fuerzas.tscn` | 🔨 docente | 2 | Empujar la bola con `apply_central_force`. No se mueve hasta tu línea. |
| `scenes/09_camara_pickups.tscn` | ✅ demo | 2 | Cámara que sigue + monedas `Area3D` (recolectar, contar, desaparecer). |
| `scenes/10_roll_a_ball.tscn` | ✅ demo | 2 | **Juego completo**: junta todas las monedas para ganar. Escena principal. |
| `scenes/exercises/01_salto.tscn` | 🎓 ej. 1 | 2 | **Salto**: impulso hacia arriba solo si tocas el piso. |
| `scenes/exercises/02_rebote.tscn` | 🎓 ej. 2 | 2 | **Zona rebotona**: autora un `PhysicsMaterial` y un `Area3D` que lanza. |
| `scenes/exercises/03_orbital.tscn` | 🎓 ej. 3 | 2 | **Peligro orbital**: reusa el transform-en-código para orbitar un peligro. |
| `scenes/exercises/04_camara_doble.tscn` | 🎓 ej. 4 | 2 | **Cámara doble**: alterna cenital ↔ persecución. |

> Escena principal del proyecto: `scenes/10_roll_a_ball.tscn`.
> Teclas del juego: WASD/flechas (rodar), Espacio (saltar, en el ejercicio 1), R (reiniciar).

## Los tres niveles del proyecto

- **✅ Demos completos** — corren sin tocar nada: las escenas `01`–`04`, `06`, `07`, `09` y el
  juego `10` muestran cada concepto funcionando.
- **🔨 Placeholders del docente (`# TODO (en vivo)`)** — corren sin error pero les falta *la*
  línea que se escribe en clase (mismo patrón de los módulos 9/10/11):
  - `scripts/transformaciones.gd`: girar el planeta sobre su eje (`rotate_y`).
  - `scripts/pelota.gd`: empujar la bola con el input (`apply_central_force`).
  Hasta completarlas: el planeta queda quieto (la luna sí orbita) y la bola no rueda.
- **🎓 Ejercicios (`scenes/exercises/` + `scripts/exercises/`)** — uno por idea, cada uno con
  **estado roto visible**, una **predicción** y una **escalera de pistas** (qué → con qué →
  casi-la-línea). Soluciones en `_solutions/` (gitignored: no se reparte).

## Sobre el modelo glTF

`assets/gema.gltf` **no está dibujado a mano**: lo genera `assets/gen_gema.py` (Python con
solo la stdlib) como un glTF 2.0 de texto con el buffer embebido en base64. Es una gema
low-poly facetada con **dos materiales** (corona clara, pabellón oscuro), para que la
importación traiga malla + normales + varios materiales. Para regenerarlo:
`python3 assets/gen_gema.py`.

## Estructura

```
12._3d_basics/
├── project.godot          # 4.6 Forward Plus; escena principal = 10_roll_a_ball; mapa de input
├── scenes/                # 01..10 + exercises/
├── scripts/               # .gd de las escenas (2 con 🔨) + exercises/ (🎓)
├── assets/                # gema.gltf + gen_gema.py (generador)
└── _solutions/            # soluciones de 🔨 y 🎓 (gitignored)
```

## Verificación

Sin CLI de Godot: se verifica **abriendo la carpeta en Godot 4.6**. El proyecto importa sin
errores; cada escena corre con F6 y el juego con F5; rodar junta las monedas y se llega a la
victoria. Los dos 🔨 dejan algo quieto hasta escribir su línea, y luego funcionan.
