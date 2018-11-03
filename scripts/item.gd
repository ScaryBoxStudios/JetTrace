extends Node2D

enum ItemShape {CIRCLE, RECT, TRIANGLE, CHAR}
const item_size = 20.0

var item_shape;
var item_color;
var item_char;

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    $collision.shape.radius = item_size
    $visibility.connect("screen_exited", self, "_on_visibility_screen_exited")
    item_shape = CIRCLE
    item_color = Color(1.0, 0.0, 0.0)
    item_char = 'a'

func random_color():
    item_shape = CIRCLE
    item_color = Color(randf(), randf(), randf())

func random_shape(color):
    var rshapes = [CIRCLE, RECT, TRIANGLE]
    item_shape = rshapes[randi() % len(rshapes)]
    item_color = color

func random_char():
    item_shape = CHAR
    item_char = 'a'

func _draw():
    var label = Label.new()
    var font = label.get_font("")
    # Your draw commands here
    match item_shape:
        CIRCLE:
            draw_circle(Vector2(0.0, 0.0), item_size, item_color)
        RECT:
            draw_rect(Rect2(0.0, 0.0, item_size * 1.5, item_size * 1.5), item_color)
        TRIANGLE:
            var pts = PoolVector2Array([])
            pts.append(Vector2(cos(0.0),    sin(0.0)) * item_size)
            pts.append(Vector2(cos(2*PI/3), sin(2*PI/3)) * item_size)
            pts.append(Vector2(cos(4*PI/3), sin(4*PI/3)) * item_size)
            draw_colored_polygon(pts, item_color)
        CHAR:
            draw_char(font, Vector2(0.0, 0.0), item_char, "", item_color)
    label.free()

func die():
    $collision.disabled = true
    hide()
    queue_free()

func _on_visibility_screen_exited():
    die()