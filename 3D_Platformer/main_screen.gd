extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.game_message == "":
		$TextureRect/Panel/message_label.text = "Let's play!"
		$TextureRect/action_button.text = "Start"
	else:
		# This will be set dynamically based on the game result
		$TextureRect/Panel/message_label.text = Global.game_message
		$TextureRect/action_button.text = "Restart" 
	$TextureRect/action_button.connect("pressed", Callable(self, "_on_action_button_pressed"))

# Function to handle button press
func _on_action_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
	Global.game_message = ""
