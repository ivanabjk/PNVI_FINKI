extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lCollected.text =  str(0)
	$lTotal.text = str(Global.NUM_COINS_TO_WIN)
	$lTimer.text = str(Global.game_timer)
	
	Global.connect("timer_updated", Callable(self, "_on_timer_updated"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_updated(time):
	$lTimer.text = str(time)
