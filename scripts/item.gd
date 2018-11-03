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
    var c = (randi() % 26) + 'a'.to_ascii()[0]
    item_char = PoolByteArray([c]).get_string_from_utf8()

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
            var scale = 2 * item_size
            pts.append(Vector2(cos(PI/2), sin(0)) * scale)
            pts.append(Vector2(cos(PI/3), sin(PI/2)) * scale)
            pts.append(Vector2(cos(2*PI/3), sin(PI/2)) * scale)
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