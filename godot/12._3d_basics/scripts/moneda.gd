extends Area3D
# Moneda recolectable (escenas 09 y 10).
#
# Un Area3D no CHOCA: DETECTA. Es el mismo Area2D que viste en colisiones/UI, en 3D. Cuando
# un cuerpo entra en su volumen, dispara body_entered. Aquí: avisamos "me recogieron" y nos
# borramos. El nivel lleva la cuenta (desacoplado, por señal).

signal recogida

@export var giro_grados := 90.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	# Gira sobre su eje — el mismo rotate_y de la sesión 1.
	rotate_y(deg_to_rad(giro_grados) * delta)

func _on_body_entered(_body: Node3D) -> void:
	recogida.emit()
	queue_free()
