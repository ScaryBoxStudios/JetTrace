extends Node2D

const size = 20.0

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    $collision.shape.radius = size
    $visibility.connect("screen_exited", self, "_on_visibility_screen_exited")

func _draw():
    # Your draw commands here
    draw_circle(Vector2(0.0, 0.0), size, Color(1.0, 0.0, 0.0))

func _on_visibility_screen_exited():
    queue_free()

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass