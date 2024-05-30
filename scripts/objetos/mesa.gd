extends Area3D

var objetoEnMesa : Node3D
@onready var posisionEnMesa = $Marker3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if objetoEnMesa:
		objetoEnMesa.global_position = posisionEnMesa.global_position
	pass


func _on_body_entered(body):
	var objeto = body as Node3D
	print("1")
	if !objetoEnMesa:
		print("2")
		if(objeto is ObjetoServible) and !objeto.esta_ocupado:
			print("3")
			objetoEnMesa = objeto
			
			pass
		pass
	pass # Replace with function body.
