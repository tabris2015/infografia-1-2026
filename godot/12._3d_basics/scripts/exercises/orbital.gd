extends Node3D
# 🎓 Ejercicio 3 — PELIGRO ORBITAL
#
# Estado roto: hay un bloque rojo (un AnimatableBody3D) colgado de este pivote, pero está
# QUIETO. Debería orbitar el centro del nivel y empujar tu bola si te alcanza.
#
# 🔮 PREDICE antes de escribir: si giras pero NO multiplicas por `delta`, ¿se verá igual
#    en una compu de 30 FPS y en una de 144 FPS? (Es el mismo punto de la sesión 1.)
#
# Tu tarea: hacer que este pivote gire sobre su eje Y para que el peligro orbite.
#
# Escalera de pistas 🪜
#   1. Qué  — el bloque cuelga desplazado de este pivote; si el pivote gira, el bloque
#             describe un círculo (es la órbita de la luna de la escena 05, otra vez).
#   2. Con qué — este nodo tiene `rotate_y(radianes)`; convierte grados→radianes y escala
#             por `delta`.
#   3. Casi la línea —
#             rotate_y(deg_to_rad(velocidad) * delta)

@export var velocidad := 60.0

func _process(delta: float) -> void:
	# TODO: gira el pivote para que el peligro orbite.
	pass
