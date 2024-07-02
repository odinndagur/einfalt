extends Label
var player
var player_camera_pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/main/Player")
	player_camera_pivot = player.get_node("Camera_Pivot")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text(str(player_camera_pivot.rotation.x))
	pass
