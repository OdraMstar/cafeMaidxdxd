extends CharacterBody3D
class_name Customer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigationAgent : NavigationAgent3D =  $NavigationAgent3D
var posisionAIr : Node3D
const SPEED = 3.0
const JUMP_VELOCITY = 4.5
var puntoInicio : Vector3
var servido : bool
var asientoAsignado : Silla = null
var esperando = false
@onready var globoTextoSprite := $globo
@onready var imagenPedidoSprite := $globo/Sprite3D
var pedido : String = "cafe"
var esperandoAsignarEntrada :bool = true
func _ready():
	puntoInicio = global_position
	pass

func _process(_delta):
	
	
	if(servido):
		navigationAgent.target_position = puntoInicio
		
	if asientoAsignado && !servido && posisionAIr:
		navigationAgent.target_position = posisionAIr.global_position
	
	
	#if asientoAsignado:
#		if asientoAsignado.asignado and asientoAsignado.asignado != self:
#			print ("se busca otra mesa por que se ocupo")
#			printt (name, asientoAsignado.asignado.name)
#			asientoAsignado = null
			 
	
#	if !posisionAIr and !servido:
#		for asiento : Silla in get_tree().get_nodes_in_group("asientos"):
#			if(!asiento.estaOcupada):
#				asiento.estaOcupada = true
#				posisionAIr = asiento
#		asiento.asignado = self 
#				asientoAsignado = asiento
#				return
	

func clienteServido():
	navigationAgent.target_position = puntoInicio
	servido = true
	posisionAIr = null
	esperandoAsignarEntrada = true	

func _physics_process(delta):
	
	var siguientePosision = navigationAgent.get_next_path_position()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction = global_position.direction_to(siguientePosision)
	#var distance = global_position.distance_to(jugador.global_position)

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	
	move_and_slide()


func _on_navigation_agent_3d_target_reached():
	if servido:
		print("se llego")
		servido = false
		
	if !esperando:
		print("esta esperando")
		esperando = true
		
		
	pass # Replace with function body.
func interactuar():
	if(esperando):
		print("se activa")
		globoTextoSprite.visible = true
		pass
	pass
