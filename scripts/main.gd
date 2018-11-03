extends Node

export (PackedScene) var Jet
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var jet = Jet.instance()
	add_child(jet)
	var screensize = get_viewport().get_visible_rect().size
	jet.position = screensize / 2.0

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
