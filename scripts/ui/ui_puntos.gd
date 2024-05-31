extends Control

var dinero : int
var informacionPartida : Informacion
@onready var labelDinero = $MarginContainer/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	informacionPartida = get_node("/root/Informacion") as Informacion;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dinero != informacionPartida.dinero:
		dinero = informacionPartida.dinero
		labelDinero.text = "$ " + str(dinero)
		print(dinero)
	pass
