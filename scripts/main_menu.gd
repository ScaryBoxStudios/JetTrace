extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func _on_triangle__btn_pressed():
    global.mode = 0
    get_tree().change_scene("res://scenes/main.tscn")

func _on_rectangle_btn_pressed():
    global.mode = 1
    get_tree().change_scene("res://scenes/main.tscn")


func _on_char_btn_pressed():
    global.mode = 2
    get_tree().change_scene("res://scenes/main.tscn")

