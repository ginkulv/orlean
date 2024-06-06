extends Node

const MAX_TURN = 18

var coins = 0
var turn = 1

var table_default_x = 0.292
var table_default_y = 2.566

var tablet_moves_in = false
var tablet_moves_out = false
var tablet_is_in = false

var peasant_scene = preload("res://scenes/peasant.tscn")

var mouse_is_pressed = false

var peasant

func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		print("E is pressed")
		if tablet_moves_in or tablet_moves_out:
			pass
		if not tablet_is_in:
			$PlayerTablet.set_linear_velocity( Vector3(0, 0, -10))
			tablet_moves_in = true
		if tablet_is_in:
			$PlayerTablet.set_linear_velocity( Vector3(0, 0, 10))
			tablet_moves_out = true
	
	if event is InputEventMouseButton:
		if mouse_is_pressed:
			print("mouse is released")
		else:
			print("mouse is pressed")
		mouse_is_pressed = !mouse_is_pressed
	if event is InputEventMouseMotion and mouse_is_pressed:
		#print(event.relative)
		print(round(peasant.position.x), event.relative.x)
		if round(peasant.position.x) == event.relative.x and round(peasant.position.y) == event.relative.y:
			print('GOOOOOOOAL')
		#print(get_viewport().get_mouse_position())

func _ready():
	set_process_input(true)
	peasant = peasant_scene.instantiate()
	peasant.set_global_position(Vector3(-1, 1, 0.5))
	add_child(peasant)
	#print(peasant.global_position)
	#print(peasant.position)
	

func _process(delta):
	if tablet_moves_in:
		var z = $PlayerTablet.position.z
		print(z)
		if z <= -2:
			$PlayerTablet.set_linear_velocity( Vector3(0, 0, 0))
			tablet_moves_in = false
			tablet_is_in = true
	if tablet_moves_out:
		var z = $PlayerTablet.position.z
		print(z)
		if z >= -0.2:
			$PlayerTablet.set_linear_velocity(Vector3(0, 0, 0))
			tablet_moves_out = false
			tablet_is_in = false
	$CoinsLabel.text = str(coins)
