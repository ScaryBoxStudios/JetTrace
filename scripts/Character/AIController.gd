extends "res://scripts/Character/CharacterController.gd"

func _ready():
    pass

func move(var p):
    # TODO: Implement AI here
    .move(Vector2(self.position.x, self.position.y - 0.3))
