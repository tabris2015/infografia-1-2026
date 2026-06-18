extends Node3D
# Escena 06 — Importar un modelo .gltf (✅ demo)
#
# Una primitiva la trae el motor; un MODELO lo trae un archivo. El estándar es glTF
# (.gltf de texto o .glb binario). Trae de una vez: malla + normales + MATERIALES.
# Godot lo importa como una ESCENA (PackedScene): en el editor la arrastras al árbol;
# aquí la cargamos por código para que el demo corra solo.
#
# El "gotcha" clásico: ESCALA y ORIENTACIÓN. Cada herramienta exporta en su unidad y su
# eje; al lado dejamos un cubo de 1×1×1 como regla para comparar el tamaño con el que
# entró la gema. Si un modelo aparece gigante, minúsculo o de costado, casi siempre es
# esto (se ajusta en la pestaña Import, o con scale/rotation al instanciar).

@onready var soporte: Node3D = $Soporte

func _ready() -> void:
	var escena := load("res://assets/gema.gltf") as PackedScene
	if escena == null:
		push_warning("No se pudo cargar gema.gltf — ¿ya lo importó Godot?")
		return
	var gema := escena.instantiate()
	soporte.add_child(gema)

func _process(delta: float) -> void:
	# Giro lento para ver las facetas y los dos materiales (corona clara, pabellón oscuro).
	soporte.rotate_y(deg_to_rad(30.0) * delta)
