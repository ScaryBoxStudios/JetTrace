extends Node2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _draw():
	# Your draw commands here
	draw_circle(Vector2(0.0, 0.0), 20, Color(1.0, 0.0, 0.0))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass