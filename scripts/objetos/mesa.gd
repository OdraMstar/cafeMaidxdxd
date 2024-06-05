extends Area3D
class_name Mesa

var objetoEnMesa : Node3D
@onready var posisionEnMesa = $Marker3D
@onready var sillas = $sillas as Node3D
var globalInformacion : Informacion
@onready var posisionesEnMesa := $posisionesEspera
var ObjetosEnMesa :Array = []
var PersonasEnMesa :Array = []
var personasEnMesaTotal : int
var mesaDisponible : bool= true

func _ready():
	globalInformacion = get_node("/root/Informacion") as Informacion
	
	for s : Area3D in sillas.get_children() :
		print("se intenta añadir silla")
		print (s.body_entered.connect(_on_silla_body_entered))
		pass
	

func _process(delta):	
	var i : int = 0
	for obj in ObjetosEnMesa:
		obj.global_position = posisionesEnMesa.get_child(i).global_position
		i+=1
		pass
	#if objetoEnMesa:
	#	objetoEnMesa.global_position = posisionEnMesa.global_position
	pass

func _on_body_entered(body):
	var objeto = body as ObjetoServible
	print("1")
	if espaciosDisponiblesComida():
		print("2")
		if(objeto is ObjetoServible) and !objeto.esta_ocupado and !ObjetosEnMesa.has(objeto) :
			print("3")
			ObjetosEnMesa.append(objeto)
			printt("PersonasEnMesa",PersonasEnMesa)
			printt("objetos en mesa",ObjetosEnMesa)
			revisarEstado()
			pass
		pass
	pass 

func espaciosDisponiblesComida() -> bool:
	return sillas.get_child_count()> ObjetosEnMesa.size()
	
func revisarEstado():
	if todosLlegaron() and verificarPedidosServidos() :
		mesaServida()
	pass
	
func todosLlegaron() -> bool:
	return personasEnMesaTotal == PersonasEnMesa.size()
	
func verificarPedidosServidos() -> bool:
	if (PersonasEnMesa.size() == 0):
		print("no hay personas")
		return false
	# Crear un diccionario para contar la cantidad de cada pedido
	var pedidos_requeridos := {}
	for persona in PersonasEnMesa:
		if persona.pedido in pedidos_requeridos:
			print("se solicita 1 cafe")
			pedidos_requeridos[persona.pedido] += 1
		else:
			print("se solicita 1 cafe")
			pedidos_requeridos[persona.pedido] = 1

	# Crear un diccionario para contar la cantidad de cada platillo servido
	var platillos_servidos := {}
	for objeto in ObjetosEnMesa:
		if objeto.nombre in platillos_servidos:
			print("se pone 1 cafe")
			platillos_servidos[objeto.nombre] += 1
		else:
			print("se pone 1 cafe")
			platillos_servidos[objeto.nombre] = 1
	print(pedidos_requeridos)
	print(platillos_servidos)
	# Verificar si hay suficientes platillos servidos para cada pedido requerido
	for pedido in pedidos_requeridos:
		if pedido not in platillos_servidos or platillos_servidos[pedido] < pedidos_requeridos[pedido]:
			return false

	return true

func _on_silla_body_entered(body):
	if body is Customer:
		print("p1")
		if body not in PersonasEnMesa  :
			print("p2")
			if personaPerteneceAMesa(body):
				print("p3")
				
				PersonasEnMesa.append(body)
				printt("PersonasEnMesa",PersonasEnMesa)
				printt("objetos en mesa",ObjetosEnMesa)
				revisarEstado()
		pass
	pass 

func personaPerteneceAMesa(body:Customer) -> bool:
	for s : Silla in sillas.get_children():
		printt("Silla asignado",s.asignado)
		if(s.asignado == body):
			
			return true
	return false
	pass

func mesaServida():
	for s : Silla in sillas.get_children():
		s.estaOcupada = false
		s.asignado = null
		pass
		
	print("mesa se sirvio")
	var arrayComida : Array = []
	globalInformacion.dinero += 25 * PersonasEnMesa.size()
	printt("personas en mesa",PersonasEnMesa)
	
	for c : Customer in PersonasEnMesa:
		printt(c,"atendido")
		arrayComida.append(c.pedido)
		c.clienteServido()
		pass
	for com in arrayComida:
		for o in ObjetosEnMesa:
			if com == o.nombre:
				ObjetosEnMesa.erase(o)
				o.queue_free()
				break
	
	printt("array comida",arrayComida)
	printt("objetos en mesa",ObjetosEnMesa)
	
	PersonasEnMesa.clear()
	
	
	
	print("mesa servida")
	
	mesaDisponible = true
	
	pass
