extends Node

export (PackedScene) var Jet

var started = false;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var screensize = get_viewport().get_visible_rect().size

func _process(delta):
    $camera.position.y = $camera.position.y - 0.5
    #jet.position.y = $camera.position.y
    var mouse_pos = get_viewport().get_mouse_position()
    $jet.move(mouse_pos.x, (mouse_pos.y - 512) + $camera.position.y)
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _input(event):
    # Mouse in viewport coordinates
    #if event is InputEventMouseMotion:
        #jet.move(event.position.x, (event.position.y - 512) + $camera.position.y)