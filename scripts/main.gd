extends Node

export (PackedScene) var Jet
export (PackedScene) var Item
export (PackedScene) var Starplosion

const PlayerController = preload("res://scripts/Character/PlayerController.gd") # Relative path
onready var player_controller = PlayerController.new()

const AIController = preload("res://scripts/Character/AIController.gd") # Relative path
onready var ai_controller = AIController.new()

const mode = 0;
var start_timer;
var game_started;
var item_timer;
var starplosion_emitter;
var font;
var target;
var target_shape;
var target_color;
var target_char;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var screensize = get_viewport().get_visible_rect().size

    # Load font for font items
    font = DynamicFont.new()
    var font_data = DynamicFontData.new()
    font_data.font_path = "res://assets/font/Roboto-Medium.ttf"
    font.font_data = font_data
    font.size = 40

    # Target
    target = spawn_item(screensize / 2.0)
    target.gravity_scale = 0.0
    target_shape = target.item_shape
    target_color = target.item_color
    target_char = target.item_char

    # Show target for some secs and then start game
    start_timer = Timer.new()
    start_timer.wait_time = 3.0
    add_child(start_timer)
    start_timer.connect("timeout", self, "_on_start_game")
    start_timer.start()
    game_started = false

func _on_start_game():
    print("Starting game!")
    target.die()
    start_timer.stop()
    start_game()

func start_game():
    # Add Jet
    var jet = Jet.instance()
    add_child(jet)

    # Spawn timer
    item_timer = Timer.new()
    add_child(item_timer)
    item_timer.connect("timeout", self, "_on_item_spawn_timer")
    item_timer.start()

    jet.controller = player_controller
    #jet.controller = ai_controller
    jet.connect("hit", self, "_on_jet_hit")

    starplosion_emitter = Starplosion.instance()
    add_child(starplosion_emitter)

    game_started = true

func similar_to_target(item):
    match mode:
        0:
            return item.item_color == target_color
        1:
            return item.item_shape == target_shape
        2:
            return item.item_char == target_char
    return false

func _on_jet_hit(collision_info):
    if similar_to_target(collision_info.collider):
        starplosion_emitter.hide()
        starplosion_emitter.queue_free()
        starplosion_emitter = Starplosion.instance()
        add_child(starplosion_emitter)

        starplosion_emitter.position = collision_info.position
        starplosion_emitter.get_node("emitter").emitting = true

        $sound_player.play()

        collision_info.collider.die()

func _on_item_spawn_timer():
    var screen_rect = get_viewport().get_visible_rect()
    var pos = Vector2(randf() * screen_rect.size.x, $camera.position.y - 400)
    var item = spawn_item(pos)

func spawn_item(pos):
    # Pick random spawn position from top of the screen
    var item = Item.instance()
    add_child(item)
    if mode == 0:
        item.random_color()
    elif mode == 1:
        item.random_shape(Color(1.0, 0.0, 0.0))
    elif mode == 2:
        item.random_char()
    item.position = pos
    item.font = font
    return item

func _process(delta):
    if game_started:
        $camera.position.y = $camera.position.y - 0.7

    player_controller.move(get_viewport().get_mouse_position(), $camera.position)
    #ai_controller.move($camera.position)
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _input(event):
    # Mouse in viewport coordinates
    #if event is InputEventMouseMotion:
        #jet.move(event.position.x, (event.position.y - 512) + $camera.position.y)