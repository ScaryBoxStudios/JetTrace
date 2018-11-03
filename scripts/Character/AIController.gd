extends "res://scripts/Character/CharacterController.gd"

func _ready():
    pass

func move(var pos, var camera_pos):
    # TODO: Implement AI here
    .move(Vector2(pos.x, pos.y))