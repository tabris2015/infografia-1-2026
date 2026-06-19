extends RigidBody3D
# 🎓 Ejercicio 1 — SALTO
#
# Estado roto: ruedas con WASD/flechas, pero Espacio NO hace nada. La bola nunca salta.
#
# 🔮 PREDICE antes de escribir: si saltaras SIN revisar el piso (saltar siempre que
#    aprietas Espacio), ¿qué pasaría si mantienes Espacio apretado en el aire?
#
# Tu tarea: que la bola salte con Espacio, pero SOLO si está tocando el piso.
#
# Escalera de pistas 🪜
#   1. Qué  — un salto es un golpe instantáneo de velocidad hacia arriba (un IMPULSO),
#             distinto de la fuerza continua del rodar.
#   2. Con qué — `apply_central_impulse(Vector3.UP * impulso_salto)` da ese golpe.
#             Para saber si tocas el piso, ya tienes un RayCast3D apuntando hacia abajo:
#             `sensor_piso.is_colliding()`.
#   3. Casi la línea —
#             if sensor_piso.is_colliding():
#                 apply_central_impulse(Vector3.UP * impulso_salto)

@export var fuerza := 25.0
@export var impulso_salto := 8.0

@onready var sensor_piso: RayCast3D = $SensorPiso

func _physics_process(_delta: float) -> void:
	var entrada := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	apply_central_force(Vector3(entrada.x, 0.0, entrada.y) * fuerza)

	if Input.is_action_just_pressed("saltar"):
		# TODO: salta hacia arriba, solo si el sensor toca el piso.
		pass
