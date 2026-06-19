extends Area3D
# 🎓 Ejercicio 2 — ZONA REBOTONA (trampolín)
#
# Estado roto: hay un pad brillante en el piso, pero al rodar sobre él NO pasa nada. La
# bola lo cruza como si fuera piso normal.
#
# 🔮 PREDICE antes de escribir: si aplicaras el impulso en _process (cada frame mientras
#    la bola está encima) en vez de UNA vez al entrar, ¿qué se sentiría?
#
# Tu tarea: que el trampolín LANCE hacia arriba a la bola cuando la pisa.
#
# Escalera de pistas 🪜
#   1. Qué  — un Area3D detecta cuándo un cuerpo entra (señal `body_entered`), y desde ahí
#             le damos un impulso hacia arriba.
#   2. Con qué — el `body` que llega es la bola (un RigidBody3D); tiene
#             `apply_central_impulse(Vector3.UP * fuerza_rebote)`.
#   3. Casi la línea —
#             if body is RigidBody3D:
#                 body.apply_central_impulse(Vector3.UP * fuerza_rebote)
#
# Bonus (para discutir): otra forma de rebotar es un PhysicsMaterial con `bounce` alto en
# el piso. ¿Por qué un impulso fijo es más predecible para un trampolín de juego?

@export var fuerza_rebote := 12.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	# TODO: lanza el cuerpo hacia arriba.
	pass
