extends Area2D

var screen_size: Vector2 = Vector2.ZERO


func pickup() -> void:
    queue_free()