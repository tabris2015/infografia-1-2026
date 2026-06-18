extends Node3D
# Escena 03 — Cámara + luz + entorno (✅ demo)
#
# "¿Por qué se ve negro?" En 3D no se ve NADA hasta que hay dos cosas:
#   1. una CÁMARA (Camera3D) — el ojo desde donde se mira.
#   2. LUZ — sin luz que rebote, toda superficie es negra.
# El WorldEnvironment agrega el cielo y la luz AMBIENTE (relleno suave).
#
# Presiona 1..4 para ir sumando ingredientes y ver qué aporta cada uno.

@onready var sol: DirectionalLight3D = $Sol
@onready var entorno: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	_modo(4)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_1: _modo(1)  # nada: superficies negras
			KEY_2: _modo(2)  # solo ambiente: plano, sin volumen
			KEY_3: _modo(3)  # solo sol direccional: sombras duras
			KEY_4: _modo(4)  # sol + ambiente: lo normal

func _modo(n: int) -> void:
	sol.light_energy = 1.0 if n == 3 or n == 4 else 0.0
	entorno.environment.ambient_light_energy = 1.0 if n == 2 or n == 4 else 0.0
	print("Modo %d — sol: %.0f   ambiente: %.0f" % [
		n, sol.light_energy, entorno.environment.ambient_light_energy])
