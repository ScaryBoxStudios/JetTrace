extends "res://scripts/Character/CharacterController.gd"

var camera

func move(var p):
    var new_p = Vector2(p.x, (p.y - 512) + camera.position.y)
    .move(new_p)