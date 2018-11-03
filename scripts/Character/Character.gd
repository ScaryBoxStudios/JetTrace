extends Node2D
signal hit

var controller

func _ready():
    pass

func _physics_process(delta):
    var move_target = controller.position
    var velocity = move_target - self.position
    var collision_info = move_and_collide(velocity * delta)
    self.position = move_target # No bounce back for us!
    if collision_info:
        emit_signal("hit", collision_info)