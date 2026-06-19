extends RigidBody3D
# Jugador del juego (escenas 09 y 10) — la bola que rueda.
#
# Es la versión COMPLETA de scripts/pelota.gd: lo que en la escena 08 se escribe en vivo,
# aquí ya está. Empuja la bola con fuerza en el plano del piso a partir del input.

@export var fuerza := 25.0

func _physics_process(_delta: float) -> void:
	var entrada := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var dir := Vector3(entrada.x, 0.0, entrada.y)
	apply_central_force(dir * fuerza)
