extends Node2D

var controller

func _ready():
    pass

func move(var x, var y):
    self.position = Vector2(x, y)
    pass

func _process(delta):
    self.position = controller.position
    pass