extends CharacterBody3D


@export var base_player_speed = 5.0
@export var sprint_multiplier = 1.6
@export var turn_speed = 0.1
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.03
@export var look_speed = 0.4

@export var min_angle = -90.0
@export var max_angle = 90.0

@export var prefab : Node3D

var player_speed
var is_jumping = false
var jump_count = 0
@export var max_jumps = 4

@export var camera_environment : WorldEnvironment

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Func _input(event): If event is InputEventMouseMotion: Var mouse_delta = event.relative

func can_jump():
	return jump_count < max_jumps

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
#		$Camera_Pivot/Camera3D.look_at($Camera_Pivot.global_position)


func _process(_delta):
#	pass
	if position.y < -200:
#		print(position)
		get_tree().reload_current_scene()



func _physics_process(delta):
	if Input.is_action_pressed("sprint"):
		player_speed = base_player_speed * sprint_multiplier
	else:
		player_speed = base_player_speed
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if is_on_floor():
		if jump_count > 0:
			jump_count = 0
		# if is_extra_jumping:
			# is_extra_jumping = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if can_jump():
			jump_count += 1
			velocity.y = jump_velocity


	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * player_speed
		velocity.z = direction.z * player_speed
		#$plaidgirl/AnimationPlayer.play("run_cycle")
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)
		#$plaidgirl/AnimationPlayer.stop()
	$AnimationTree.set("parameters/TimeScale/scale",velocity.z)
		
	var y_rotation = Input.get_axis("turn_left","turn_right") * -turn_speed
	rotate_y(y_rotation)
	var x_rotation = Input.get_axis("look_down","look_up") * -turn_speed
	$Camera_Pivot.rotation.x = clamp(
		$Camera_Pivot.rotation.x - x_rotation * look_speed,
		deg_to_rad(min_angle),
		deg_to_rad(max_angle)
	)

	move_and_slide()

