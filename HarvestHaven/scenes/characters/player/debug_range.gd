extends Node2D

@export var radius: float = 48.0
@export var color: Color = Color(0, 1, 0, 0.3)  # light green with transparency

func _draw():
	draw_circle(Vector2.ZERO, radius, color)

func _process(_delta):
	queue_redraw()  # Redraw every frame in case player moves
