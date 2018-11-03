extends Node2D

# p: Vector2
func move(var pos, var cam_pos):
    self.position = Vector2(pos.x, (pos.y - 512) + cam_pos.y)
