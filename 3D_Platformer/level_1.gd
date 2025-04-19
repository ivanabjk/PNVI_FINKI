extends Node3D

var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.coins = 0
	Global.game_timer = 60
	timer = $Timer
	
	# Set timer to tick every second
	timer.wait_time = 1.0
	# Ensure timer repeats
	timer.one_shot = false 
	# Connect with timeout signal
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	# Start timer
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	# Decrease the global timer variable and emit the signal
	Global.game_timer -= 1
	Global.emit_signal("timer_updated", Global.game_timer)
	
	# When the timer reaches 0
	if Global.game_timer <= 0:
		_end_game("Game over! Try again.")
		timer.stop()

func _end_game(message: String) -> void:
	Global.game_message = message
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_screen.tscn")
