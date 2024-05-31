extends Area3D

var objetoEnMesa : Node3D
@onready var posisionEnMesa = $Marker3D
@onready var sillas = $sillas as Node3D
var asignado1 : Customer
var asignado2 : Customer
var globalInformacion : Informacion
func _ready():
	globalInformacion = get_node("/root/Informacion") as Informacion

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
			if asignado2 and asignado1 and objetoEnMesa:
				mesaServida()
			pass
		pass
	pass 

func _on_silla_1_body_entered(body):
	print("sasdas")
	if body is Customer:
		asignado1 = body
		if asignado2 and asignado1 and objetoEnMesa:
			mesaServida()
		pass
	pass 

func _on_silla_2_body_entered(body):
	print("sasdas")
	if body is Customer:
		asignado2 = body
		if asignado2 and asignado1 and objetoEnMesa:
			mesaServida()
		pass
	pass
func mesaServida():
	print("mesa servida")
	asignado2.clienteServido()
	asignado2 = null
	asignado1.clienteServido()
	asignado2=null
	objetoEnMesa.queue_free()
	objetoEnMesa =null
	globalInformacion.dinero += 25
	for s : Silla in sillas.get_children():
		s.estaOcupada = false
		s.asignado = null
		pass
	pass
