extends Camera3D
# Cámara que sigue (escenas 09 y 10).
#
# Clave: la cámara NO es hija de la bola. Si lo fuera, giraría con ella y marearía. En vez
# de eso la seguimos por código: cada frame nos acercamos a "la posición del objetivo + un
# desfase fijo", de forma SUAVE, y miramos hacia el objetivo.

@export var objetivo_path: NodePath
@export var desfase := Vector3(0, 7, 9)
@export var suavidad := 5.0

var objetivo: Node3D

func _ready() -> void:
	objetivo = get_node_or_null(objetivo_path)

func _physics_process(delta: float) -> void:
	if objetivo == null:
		return
	var deseada := objetivo.global_position + desfase
	# Suavizado independiente de los FPS (cuanto más lejos, más rápido se acerca).
	global_position = global_position.lerp(deseada, 1.0 - exp(-suavidad * delta))
	look_at(objetivo.global_position, Vector3.UP)
