extends Area3D
var player

var taxi_music


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/main/Player")
	taxi_music = get_node("/root/main/music/taxi")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == player:
		player.get_node("DirectionalLight3D").light_energy = 0.2
		taxi_music.volume_db = -18
		print("body == player!!")



func _on_body_exited(body):
	if body == player:
		player.get_node("DirectionalLight3D").light_energy = 1
		taxi_music.volume_db = 0
		print("body == player!!")

