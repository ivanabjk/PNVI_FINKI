extends Camera3D


@export var distance = 4.0
@export var height = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(true)
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var Camera_target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0,1,0)
	
	var offset = pos - Camera_target
	
	offset = offset.normalized() * distance
	offset.y = height
	
	pos = Camera_target + offset
	look_at_from_position(pos, Camera_target, up)
	
	
