extends CharacterBody3D


const SPEED = 13.0
const JUMP_VELOCITY = 10

var xform : Transform3D
var sensitivity = 0.005
var camera

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func _input(event):
	 #and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
	if event is InputEventMouseMotion:
		$Camera_Controller.rotate_y(-event.relative.x * sensitivity)
		$Camera_Controller/Camera_Target.rotate_x(-event.relative.y * sensitivity)
		$Camera_Controller/Camera_Target.rotation_degrees.x = clamp($Camera_Controller/Camera_Target.rotation_degrees.x, -30, 30)
		
	# Rotate character
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
		
func _physics_process(delta: float) -> void:	
	
	#camera = get_node("Camera_Controller/Camera_Target/Camera3D").get_global_transform()
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")
	
	## Rotate the camera left / right
	#if Input.is_action_just_pressed("cam_left"):
		#$Camera_Controller.rotate_y(deg_to_rad(-30))
	#if Input.is_action_just_pressed("cam_right"):
		#$Camera_Controller.rotate_y(deg_to_rad(30))
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	
	# New Vector3 direction, taking into account the user arrow inputs and the camera rotation
	#var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var direction = ($Camera_Controller.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	
	# Rotate the character mesh so oriented towards the direction moving in relation to the camera
	if input_dir != Vector2.ZERO:
		#$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y
		
	# Rotate the character to align with the floor
	#$RayCast3D.position = position
	if (is_on_floor() and input_dir != Vector2(0,0)):
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
		#rotation.y = 0
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
		#rotation.y = 0
	
	# Update the velocity and move the character
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Make Camera Controller Match the position of myself
	#rotation.y = $Camera_Controller.rotation.y 
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.15)
	
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	

func _on_fall_zone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
