extends Node3D
# Escena 05 — Transformaciones en código (🔨 placeholder del docente)
#
# En el módulo 6 multiplicabas matrices a mano para rotar un punto. Aquí el motor ya
# trae Transform3D / Basis hechos: girar es UNA línea por frame. rotate_y(rad) acumula
# una rotación sobre el eje Y local del nodo, frame a frame.
#
# Nota del eje del tiempo: multiplicamos por `delta` (segundos desde el último frame)
# para que el giro sea por SEGUNDO y no por frame — así se ve igual a 30 o 144 FPS.

@export var giro_planeta_grados := 45.0
@export var giro_luna_grados := 90.0

@onready var planeta: Node3D = $Planeta
@onready var pivote_luna: Node3D = $PivoteLuna

func _process(delta: float) -> void:
	# ✅ DADO: la luna orbita. Su pivote está en el centro; al girar el pivote, la luna
	# (que cuelga desplazada) describe un círculo. Esto ya es "transform en código".
	pivote_luna.rotate_y(deg_to_rad(giro_luna_grados) * delta)

	# TODO (en vivo): haz que el PLANETA gire sobre su propio eje Y.
	# Pista: planeta.rotate_y(deg_to_rad(giro_planeta_grados) * delta)
	pass
