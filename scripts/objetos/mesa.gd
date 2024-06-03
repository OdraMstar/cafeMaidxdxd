extends Area3D

var objetoEnMesa : Node3D
@onready var posisionEnMesa = $Marker3D
@onready var sillas = $sillas as Node3D
var asignado1 : Customer
var asignado2 : Customer
var globalInformacion : Informacion
@onready var posisionesEnMesa := $posisionesEspera
var ObjetosEnMesa :Array = []
var PersonasEnMesa :Array = []

func _ready():
	globalInformacion = get_node("/root/Informacion") as Informacion
	
	for s : Area3D in sillas.get_children() :
		print("se intenta añadir silla")
		print (s.body_entered.connect(_on_silla_body_entered))
		pass
	

func _process(delta):	
	for obj in ObjetosEnMesa:
		obj.global_position= posisionEnMesa.global_position
		pass
	#if objetoEnMesa:
	#	objetoEnMesa.global_position = posisionEnMesa.global_position
	pass

func _on_body_entered(body):
	var objeto = body as Node3D
	print("1")
	if espaciosDisponiblesComida():
		print("2")
		if(objeto is ObjetoServible) and !objeto.esta_ocupado:
			print("3")
			ObjetosEnMesa.append(objeto)
			revisarEstado()
			pass
		pass
	pass 

func espaciosDisponiblesComida() -> bool:
	return sillas.get_child_count()>= ObjetosEnMesa.size()
	
func revisarEstado():
	var i = 0
	for s in sillas.get_children():
		pass
		#if (buscarObjeto() )
		#pass
#	if asignado2 and asignado1 and objetoEnMesa:
#				mesaServida()

func _on_silla_body_entered(body):
	if body is Customer:
		PersonasEnMesa.append(body)
		revisarEstado()
		pass
	pass 


func mesaServida():
	for s : Silla in sillas.get_children():
		s.estaOcupada = false
		s.asignado = null
		pass
	print("mesa servida")
	asignado2.clienteServido()
	asignado2 = null
	asignado1.clienteServido()
	asignado2=null
	objetoEnMesa.queue_free()
	objetoEnMesa =null
	globalInformacion.dinero += 25
	
	pass
