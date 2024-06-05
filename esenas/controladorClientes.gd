extends Node3D

@onready var mesas : Array 
@onready var timer := $Timer

func _ready():
	mesas = get_tree().get_nodes_in_group("mesas")
	timer.timeout.connect(asignaClientesMesas)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func asignaClientesMesas():
	
	##### seleccionar mesa
	print("se inicaCreacion")
	var mesas_disponibles = []
	for mesa : Mesa in get_tree().get_nodes_in_group("mesas"):
		if mesa.mesaDisponible:
			mesas_disponibles.append(mesa)
	if(mesas_disponibles.size() == 0):
		return
	printt("mesas disponibles",mesas_disponibles)		
	var mesaDisponibleAleatoria = numAleatorio(0,mesas_disponibles.size()-1)
	printt("mesa elejida",mesaDisponibleAleatoria)	
	var mesaEscogida : Mesa = mesas_disponibles[mesaDisponibleAleatoria]
	mesaEscogida.mesaDisponible = false
	
	###################
	
	#### seleccionarSilla
	
	var sillas_disponibles =  mesaEscogida.sillas.get_children()	
	
	################ clientes
	
	var clientes_disponibles = []
	
	for c in get_children():
		if c is Customer and c.esperandoAsignarEntrada:
			clientes_disponibles.append(c)
			pass
	#########
	
	var numClientesMesa : int = numAleatorio(1,mesaEscogida.sillas.get_child_count())
	print ("mesa de " + str(numClientesMesa))
	
	var clienteAleatorio : int 
	
	var clienteEscojido : Customer
	
	mesaEscogida.personasEnMesaTotal = numClientesMesa
	
	for i in numClientesMesa:
		clienteAleatorio = numAleatorio(0, clientes_disponibles.size()-1)
		print ("cliente " + str(clienteAleatorio))
		
		clienteEscojido = clientes_disponibles[clienteAleatorio]
		
		clientes_disponibles.remove_at(clienteAleatorio)
		asignaCliente(mesaEscogida,clienteEscojido)
		printt(str(i),clienteEscojido)
		
		pass
	pass

func asignaCliente(mesa : Mesa, customer :Customer):
	customer.esperandoAsignarEntrada = false
	for asiento : Silla in mesa.sillas.get_children():
			if(!asiento.estaOcupada):
				asiento.estaOcupada = true
				customer.posisionAIr = asiento
				asiento.asignado = customer 
				customer.asientoAsignado = asiento
				return

func numAleatorio(min:int,max:int):
	
	return randi() % (max - min + 1) + min
