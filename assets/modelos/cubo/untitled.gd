extends Node3D

var numeroActual : float = 0.0
var aumento : bool = true
@onready var cubo  := $Cube
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if numeroActual >= 1.0:
		aumento = false
	if numeroActual <= 0:
		aumento = true
		
	if aumento:
		numeroActual += delta
	else:
		numeroActual-=delta
	
	print(numeroActual)
	cubo.set("blend_shapes/a",numeroActual)
	pass
