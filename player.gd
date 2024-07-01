extends CharacterBody3D


@export var base_player_speed = 5.0
@export var sprint_multiplier = 1.6
@export var turn_speed = 0.1
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.03

var player_speed
var is_jumping = false
var is_extra_jumping = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Func _input(event): If event is InputEventMouseMotion: Var mouse_delta = event.relative

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_delta = event.relative
#		rotate_x(mouse_delta.y * mouse_sensitivity)
		rotate_y(mouse_delta.x * -mouse_sensitivity)
		$Camera_Pivot.rotation.x = clamp(
			$Camera_Pivot.rotation.x - mouse_delta.y * mouse_sensitivity,
			deg_to_rad(-90.0),
			deg_to_rad(90.0)
			)
		$Camera_Pivot/Camera3D.look_at($Camera_Pivot.global_position)


func _physics_process(delta):
	if Input.is_action_pressed("sprint"):
		player_speed = base_player_speed * sprint_multiplier
	else:
		player_speed = base_player_speed
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if is_on_floor():
		if is_extra_jumping:
			is_extra_jumping = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		else:
			if not is_extra_jumping:
				velocity.y = jump_velocity
				is_extra_jumping = true
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * player_speed
		velocity.z = direction.z * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)
	
	var y_rotation = Input.get_axis("turn_left","turn_right") * -turn_speed
	rotate_y(y_rotation)

	move_and_slide()


func _on_shleck_body_entered(body):
	print(body)
	pass # Replace with function body.
