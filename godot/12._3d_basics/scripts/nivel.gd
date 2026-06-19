extends Node3D
# Controlador del nivel (escenas 09 y 10).
#
# Cuenta las monedas. No conoce a cada moneda de antemano: busca todas las del grupo
# "monedas", se suscribe a su señal `recogida` y lleva el marcador. Cuando no queda
# ninguna → victoria. Es el mismo patrón de señales del módulo 9: el productor (moneda)
# no sabe quién escucha; el nivel se suscribe.

@onready var etiqueta: Label = $HUD/Etiqueta

var total := 0
var recogidas := 0

func _ready() -> void:
	var monedas := get_tree().get_nodes_in_group("monedas")
	total = monedas.size()
	for m in monedas:
		m.recogida.connect(_on_recogida)
	_actualizar()

func _on_recogida() -> void:
	recogidas += 1
	_actualizar()

func _actualizar() -> void:
	if recogidas >= total:
		etiqueta.text = "¡Ganaste! 🎉   (R para reiniciar)"
	else:
		etiqueta.text = "Monedas: %d / %d" % [recogidas, total]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reiniciar"):
		get_tree().reload_current_scene()
