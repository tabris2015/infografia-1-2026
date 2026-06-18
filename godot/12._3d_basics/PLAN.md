# PLAN — Módulo 12: Godot 3D básico (diseño, no para estudiantes)

## Por qué este módulo y por qué aquí

Va **después** del capstone (módulo 11). El arco del curso ya cerró en 2D: el estudiante
*envió* un juego. Este módulo abre una puerta nueva — la tercera dimensión — sin ser
prerrequisito de nada anterior. El mensaje es: *"ya sabes hacer un juego; mira lo poco
que cambia para hacerlo en 3D."*

## La columna pedagógica: el Rosetta 2D → 3D

No enseñamos game-dev desde cero: enseñamos a **re-coordinar** lo que ya saben. Casi todo
lo de 2D tiene un gemelo en 3D. Esa tabla es el corazón de la primera diapositiva.

| Ya sabes (2D) | Gemelo en 3D | Qué cambia de verdad |
|---|---|---|
| `Node2D` | `Node3D` | `Transform3D`/`Basis`: hay un eje más (Z) y rotación en 3 ejes |
| `Sprite2D` | `MeshInstance3D` + `StandardMaterial3D` | la imagen pasa a ser malla + material PBR |
| `Camera2D` | `Camera3D` | hay perspectiva; **y sin luz no se ve nada** |
| (la luz era plana) | `DirectionalLight3D` + `WorldEnvironment` | aparece iluminación, sombras, cielo, ambiente |
| `CharacterBody2D` / `move_and_slide` | `RigidBody3D` / fuerzas | en este módulo el payoff es **físico**, no cinemático |
| shader de `CanvasItem` (mód. 10) | material PBR / shader `spatial` | el sombreado físico ya viene resuelto en el material |
| proyección a mano (mód. 6) | el motor multiplica las matrices | la matemática que hiciste a mano ahora es transparente |

Dos pagos de deuda explícitos: **módulo 6** (proyección 3D→2D a mano → ahora la hace el
motor) y **módulo 10** (escribías un shader 2D → ahora ajustas un material físico).

## Forma del módulo: 2 sesiones, 10 escenas

Mismo patrón que los módulos 8/9/10/11: tres niveles (✅ demo / 🔨 docente en vivo /
🎓 ejercicio + `_solutions/` gitignored), escenas `NN_` numeradas con nombre en español,
identificadores y comentarios en español neutro (tuteo).

- **Sesión 1 — El espacio 3D** (`01`–`06`): ver y construir. De un cubo quieto → primitivas
  → cámara/luz/entorno → materiales PBR → transformar en código → importar un modelo.
- **Sesión 2 — Moverse en 3D** (`07`–`10` + `exercises/`): física → jugable. De cuerpos que
  caen → empujar con fuerzas → cámara que sigue + recolectar → **roll-a-ball** completo.

### Decisiones tomadas con el docente
- **Payoff de la sesión 2 = roll-a-ball** (`RigidBody3D`, física), no un controlador
  cinemático. Mantiene la sesión 2 como una sola historia limpia: cuerpos → fuerzas → juego.
- **Assets = primitivas + un modelo glTF**. Casi todo se arma con mallas de fábrica; un solo
  `assets/gema.gltf` (generado por `gen_gema.py`, no dibujado a mano) enseña el pipeline de
  importación. Se instancia por código para que el demo corra sin cablear nada en el editor.

## Los dos 🔨 (docente en vivo, una línea cada uno)

- `05_transformaciones`: la luna ya orbita (dado); el planeta NO gira hasta escribir
  `planeta.rotate_y(...)`. Conecta con la matemática del módulo 6.
- `08_input_fuerzas`: la bola no se mueve hasta escribir `apply_central_force(dir * fuerza)`.

Solución de cada uno en `_solutions/0X_*_solved.gd` (gitignored).

## Los cuatro 🎓 (estado roto visible + predicción + escalera de pistas)

1. **Salto** — `apply_central_impulse` hacia arriba, solo si la bola toca el piso.
2. **Zona rebotona** — autorar un `PhysicsMaterial` (bounce) y un `Area3D` que empuja.
3. **Peligro orbital** — reusar el transform-en-código de la sesión 1 para orbitar un peligro.
4. **Cámara doble** — alternar cenital ↔ persecución (dos `Camera3D`, swap de `current`).

## Fuera de alcance (a propósito, es una intro de 2 sesiones)
Controladores `CharacterBody3D` cinemáticos, animación importada de glTF
(`AnimationPlayer`), `NavigationAgent3D`, `GPUParticles3D`, autoría de shaders `spatial`
(solo materiales) y multijugador.

## Verificación
No hay CLI de Godot en este entorno: la verificación es **abrir `12._3d_basics/` en Godot
4.6**. El proyecto importa sin errores; cada escena corre con F6; `10_roll_a_ball` con F5.
Los dos 🔨 dejan algo quieto hasta escribir su línea. Construcción en dos pasos: primero
sesión 1 (`01`–`06`) para validar el formato `.tscn`, luego sesión 2 y ejercicios.
