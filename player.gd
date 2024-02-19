extends Area2D

@export var speed: float = 250.0

var velocity: Vector2 = Vector2.ZERO
var screen_size: Vector2 = Vector2(480, 720)
var player_sprite_size: Vector2 = Vector2(20, 30)


func _process(delta) -> void:
    velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    position += velocity * speed * delta
    if position.x > screen_size.x + (player_sprite_size.x / 2):
        position.x = 0 - (player_sprite_size.x / 2)
    elif position.x < 0 - (player_sprite_size.x / 2):
        position.x = screen_size.x + (player_sprite_size.x / 2)
    if position.y > screen_size.y + (player_sprite_size.y / 2):
        position.y = 0 - (player_sprite_size.y / 2)
    elif position.y < 0 - (player_sprite_size.y / 2):
        position.y = screen_size.y + (player_sprite_size.y / 2)