extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5  
@export var sensibility = 0.005
@export var aim_multiplier := 0.5

@onready var smooth_camera: Camera3D = $cameraPivot/Camera3D

@onready var smooth_camera_fov := smooth_camera.fov

@onready var cameraPivot = $cameraPivot
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion  := Vector2.ZERO
@export var jump_height: float = 1.0
@export var fall_multiplier: float = 2.5

@onready var raycastSeleccionaObjeto = $cameraPivot/Camera3D/RayCast3D

@onready var posisionAgarre = $grabPosition

var objetoAgarrado : Node3D


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	
	if objetoAgarrado:
		objetoAgarrado.global_position = posisionAgarre.global_position
	
	if(Input.is_action_just_pressed("agarrar")):
		if(objetoAgarrado):
			objetoAgarrado.seSolto()
			objetoAgarrado = null
		else:
			if(raycastSeleccionaObjeto.is_colliding()):
				var colision = raycastSeleccionaObjeto.get_collider() as Node3D
				if colision.is_in_group("agarrable"):
					objetoAgarrado = colision
					objetoAgarrado.seAgarro()
					pass
	
	if Input.is_action_pressed("secundario"):
		smooth_camera.fov = lerp(
			smooth_camera.fov, 
			smooth_camera_fov * aim_multiplier, 
			delta * 20.0
			)
	
	else:
		smooth_camera.fov = lerp(smooth_camera.fov, smooth_camera_fov, delta * 30.0)


func _physics_process(delta):
		
	moverRotacionCamara()
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("salta") and is_on_floor():
		velocity.y = sqrt(jump_height * 2.0 * gravity)

	var input_dir = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_pressed("secundario"):
			velocity.x *= aim_multiplier
			velocity.z *= aim_multiplier
	move_and_slide()


func _input(event:InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = event.relative*sensibility
		if Input.is_action_pressed("secundario"):
				mouse_motion *= aim_multiplier
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
func moverRotacionCamara():
	rotate_y(-mouse_motion.x)
	cameraPivot.rotate_x(-mouse_motion.y)
	cameraPivot.rotation_degrees.x = clampf(
		cameraPivot.rotation_degrees.x,-90,60
	)
	 
	mouse_motion = Vector2.ZERO
	pass
