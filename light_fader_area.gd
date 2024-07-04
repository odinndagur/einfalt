extends Area3D

@export var sun_light : DirectionalLight3D
@export var indoor_light : OmniLight3D
@export var player : CharacterBody3D

var should_run = false
var indoor_light_energy
var sun_light_energy
var sun_light_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	indoor_light_energy = indoor_light.light_energy
	indoor_light.light_energy = 0.0
	sun_light_energy = sun_light.light_energy
	sun_light_rotation = sun_light.rotation
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not should_run:
		return
	var distance_to_center = (position - player.position).length()
	var distance_fraction = remap(distance_to_center, 0.0, $CollisionShape3D.shape.radius,0.0,1.0)
	sun_light.light_energy = sun_light_energy * distance_fraction
	sun_light.rotation.x = sun_light_rotation.x + (1.0 - distance_fraction) * 4
	sun_light.rotation.y = sun_light_rotation.y + (1.0 - distance_fraction) * 4
	indoor_light.light_energy = indoor_light_energy * (1.0 - distance_fraction)
#	else:
	print("running")


func _on_body_entered(body):
	if body == player:
		should_run = true
#		print("ENTERED")
#	pass # Replace with function body.


func _on_body_exited(body):
	if body == player:
		should_run = false
		sun_light.rotation = sun_light_rotation
#		print("EXITED")
#	pass # Replace with function body.
