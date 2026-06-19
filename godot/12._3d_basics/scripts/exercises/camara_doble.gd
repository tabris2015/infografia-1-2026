extends Node3D
# 🎓 Ejercicio 4 — CÁMARA DOBLE
#
# Estado roto: hay dos cámaras (una cenital, una de persecución), pero la tecla C no cambia
# nada: siempre ves la misma.
#
# 🔮 PREDICE antes de escribir: si pusieras las DOS cámaras como activas (`current = true`)
#    a la vez, ¿cuál crees que se vería?
#
# Tu tarea: alternar con la tecla C entre la cámara cenital y la de persecución.
#
# Escalera de pistas 🪜
#   1. Qué  — solo UNA Camera3D puede estar activa a la vez; alternar = activar una y
#             apagar la otra.
#   2. Con qué — cada cámara tiene la propiedad booleana `.current`. La variable
#             `usando_cenital` ya te dice cuál toca.
#   3. Casi las líneas —
#             cenital.current = usando_cenital
#             persecucion.current = not usando_cenital

@onready var cenital: Camera3D = $Cenital
@onready var persecucion: Camera3D = $Persecucion

var usando_cenital := false

func _ready() -> void:
	_aplicar()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_C:
		usando_cenital = not usando_cenital
		_aplicar()

func _aplicar() -> void:
	# TODO: activa la cámara que toca y apaga la otra (usa `usando_cenital`).
	pass
