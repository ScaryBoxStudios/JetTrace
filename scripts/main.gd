extends Node

export (PackedScene) var Jet
export (PackedScene) var Item

var item_timer;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var screensize = get_viewport().get_visible_rect().size

    # Spawn timer
    item_timer = Timer.new()
    add_child(item_timer)
    item_timer.connect("timeout", self, "_on_item_spawn_timer")
    item_timer.start()

func _on_item_spawn_timer():
    var item = spawn_item()
    item_timer.start()

func spawn_item():
    # Pick random spawn position from top of the screen
    var screen_rect = get_viewport().get_visible_rect()
    var pos = Vector2(randf() * screen_rect.size.x, $camera.position.y - 400)
    var item = Item.instance()
    item.position = pos
    add_child(item)
    return item

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