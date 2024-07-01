extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	last_window_mode = DisplayServer.window_get_mode()

var last_window_mode

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed('click'):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()
	if event.is_action_pressed("reset_game"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("toggle_fullscreen"):
		var current_window_mode = DisplayServer.window_get_mode()
		if current_window_mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(last_window_mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
