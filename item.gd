extends Node3D

#
# Can pick up
#

func pick_up():
	var player = get_node("/root/main/Player")

	get_parent().remove_child.call_deferred(self)
	
	reparent(player)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("interact"):
		pick_up()
