extends Node

export (PackedScene) var Jet
export (PackedScene) var Item
export (PackedScene) var Starplosion

const PlayerController = preload("res://scripts/Character/PlayerController.gd") # Relative path
onready var player_controller = PlayerController.new()

const AIController = preload("res://scripts/Character/AIController.gd") # Relative path
onready var ai_controller = AIController.new()

var start_timer;
var game_started;
var item_timer;
var starplosion_emitter;
var font;
var target;
var target_shape;
var target_color;
var target_char;
var score = 0;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var screensize = get_viewport().get_visible_rect().size

    # Initialize random generators
    randomize()

    # Load font for font items
    font = DynamicFont.new()
    var font_data = DynamicFontData.new()
    font_data.font_path = "res://assets/font/Roboto-Medium.ttf"
    font.font_data = font_data
    font.size = 40

    # Target
    target = spawn_item(screensize / 2.0)
    target.gravity_scale = 0.0
    target.item_size = 60.0
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
    $back_arrow.visible = false

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

    $bgm.play()
    game_started = true

func similar_to_target(item):
    match global.mode:
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

        score += 1
        $score_lbl.text = str(score)

func _on_item_spawn_timer():
    var screen_rect = get_viewport().get_visible_rect()
    var pos = Vector2(randf() * screen_rect.size.x, $camera.position.y - screen_rect.size.y/2)
    var item = spawn_item(pos)

func spawn_item(pos):
    # Pick random spawn position from top of the screen
    var item = Item.instance()
    add_child(item)
    if global.mode == 0:
        item.random_color()
    elif global.mode == 1:
        item.random_shape(Color(1.0, 0.0, 0.0))
    elif global.mode == 2:
        item.random_char()
    item.position = pos
    item.font = font
    return item

func _process(delta):
    var screen_rect = get_viewport().get_visible_rect()

    if game_started:
        $camera.position.y = $camera.position.y - 0.7

        var pos = Vector2(screen_rect.size.x - 80, $camera.position.y - screen_rect.size.y/2 + 100)
        $back_arrow.visible = true
        $back_arrow.rect_position = pos

    # hardcoded offsets ftw
    var pos = Vector2(10.0, $camera.position.y - screen_rect.size.y/2 + 120)
    $score_lbl.rect_position = pos

    player_controller.move(get_viewport().get_mouse_position(), $camera.position)
    #ai_controller.move($camera.position)
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

    if Input.is_action_pressed("ui_back"):
        _on_back_arrow_pressed()

func _on_back_arrow_pressed():
    get_tree().change_scene("res://scenes/main_menu.tscn")
