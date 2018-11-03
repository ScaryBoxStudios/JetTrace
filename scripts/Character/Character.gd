extends Node2D

var controller

func _ready():
    pass

func _physics_process(delta):
    var move_target = controller.position
    var velocity = move_target - self.position
    var collision_info = $body.move_and_collide(velocity * delta)
    self.position = move_target
    if collision_info:
        pass