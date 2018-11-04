extends Node2D

var wnd_height = null

# p: Vector2
func move(var pos, var cam_pos):
    if wnd_height == null:
        wnd_height = OS.get_window_size().y
    self.position = Vector2(pos.x, (pos.y - wnd_height/2) + cam_pos.y)
