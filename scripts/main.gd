extends Node

export (PackedScene) var Jet
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var jet;
var started = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var screensize = get_viewport().get_visible_rect().size

	# Spawn jet
	jet = Jet.instance()
	jet.position = get_viewport().get_mouse_position()
	add_child(jet)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseMotion:
		jet.position = event.position