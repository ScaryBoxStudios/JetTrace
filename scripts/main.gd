extends Node

export (PackedScene) var Jet
export (PackedScene) var Item
export (PackedScene) var Starplosion

const PlayerController = preload("res://scripts/Character/PlayerController.gd") # Relative path
onready var player_controller = PlayerController.new()

const AIController = preload("res://scripts/Character/AIController.gd") # Relative path
onready var ai_controller = AIController.new()

var item_timer;
var starplosion_emitter;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var screensize = get_viewport().get_visible_rect().size

    # Spawn timer
    item_timer = Timer.new()
    add_child(item_timer)
    item_timer.connect("timeout", self, "_on_item_spawn_timer")
    item_timer.start()

    player_controller.camera = $camera
    $jet.controller = player_controller
    $jet.connect("hit", self, "_on_jet_hit")

    starplosion_emitter = Starplosion.instance()
    add_child(starplosion_emitter)

func _on_jet_hit(collision_info):
    starplosion_emitter.hide()
    starplosion_emitter.queue_free()
    starplosion_emitter = Starplosion.instance()
    add_child(starplosion_emitter)

    starplosion_emitter.position = collision_info.position
    starplosion_emitter.get_node("emitter").emitting = true

    $sound_player.play()

    collision_info.collider.die()

func _on_item_spawn_timer():
    var item = spawn_item()
    item_timer.start()

func spawn_item():
    # Pick random spawn position from top of the screen
    var screen_rect = get_viewport().get_visible_rect()
    var pos = Vector2(randf() * screen_rect.size.x, $camera.position.y - 400)
    var item = Item.instance()
    add_child(item)
    item.random_shape(Color(1.0, 0.0, 0.0))
    #item.random_color()
    #item.random_char()
    item.position = pos
    return item

func _process(delta):
    $camera.position.y = $camera.position.y - 0.5
    player_controller.move(get_viewport().get_mouse_position())
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _input(event):
    # Mouse in viewport coordinates
    #if event is InputEventMouseMotion:
        #jet.move(event.position.x, (event.position.y - 512) + $camera.position.y)