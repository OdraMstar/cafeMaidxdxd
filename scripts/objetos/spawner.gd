extends Node3D

@export var tazaCafe : PackedScene
@onready var timer = $Timer

func _ready():
	pass 


func _process(delta):
	pass


func _on_area_exited(area):
	print("salio")
	timer.start()
	pass # Replace with function body.


func _on_timer_timeout():
	var tazaCafeIns = tazaCafe.instantiate() as Node3D
	add_child(tazaCafeIns)
	pass # Replace with function body.


func _on_body_exited(body):
	print("salio")
	timer.start()
	pass # Replace with function body.
