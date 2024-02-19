extends Area2D

var screen_size: Vector2 = Vector2.ZERO


func pickup() -> void:
    $CollisionShape2D.set_deferred("disabled", true)
    var tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
    tween.tween_property(self, "scale", scale * 2, 0.2)
    tween.tween_property(self, "modulate:a", 0.0, 0.2)
    await tween.finished
    queue_free()

