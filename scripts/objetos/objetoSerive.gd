extends RigidBody3D
class_name  ObjetoServible

@export var nombre : String = "cafe"
var esta_ocupado : bool
@onready var colision = $CollisionShape3D

func seAgarro():
	esta_ocupado = true
	colision.disabled = true
	pass

func seSolto():
	esta_ocupado = false
	colision.disabled = false
	pass

