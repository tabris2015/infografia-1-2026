extends RigidBody3D
# Escena 08 — Empujar la bola (🔨 placeholder del docente)
#
# La bola es un RigidBody3D: NO le ponemos la posición a mano. La gobierna la física
# (gravedad, choques). Para moverla, le aplicamos FUERZA en la dirección del input.
#
# Va en _physics_process (no _process): la física corre en su propio reloj, fijo.
#
# Nota: ésta es la versión 🔨 de la clase. La versión completa que usan el demo de cámara
# y el juego es scripts/jugador.gd (idéntica, con la línea ya escrita).

@export var fuerza := 25.0

func _physics_process(_delta: float) -> void:
	# Input.get_vector arma un Vector2: x = derecha−izquierda, y = abajo−arriba.
	var entrada := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Lo llevamos al plano del piso (XZ): x → X, y → Z. Y se queda en 0 (no empujamos hacia arriba).
	var dir := Vector3(entrada.x, 0.0, entrada.y)

	# TODO (en vivo): empuja la bola en esa dirección.
	# Pista: apply_central_force(dir * fuerza)
	pass
