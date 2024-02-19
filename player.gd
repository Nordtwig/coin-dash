extends Area2D

signal pickup(type: String)
signal hurt

@export var speed: float = 250.0

var velocity: Vector2 = Vector2.ZERO
var screen_size: Vector2 = Vector2(480, 720)
var player_sprite_size: Vector2 = Vector2(20, 30)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
    area_entered.connect(_on_area_entered)


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

    if velocity.length() > 0:
        animated_sprite.animation = "run"
    else: 
        animated_sprite.animation = "idle"
    if velocity.x != 0:
        animated_sprite.flip_h = velocity.x < 0


func start() -> void:
    set_process(true)
    position = screen_size / 2
    animated_sprite.animation = "idle"


func die() -> void:
    animated_sprite.animation = "hurt"
    set_process(false)


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("coins"):
        area.pickup()
        pickup.emit("coin")
    if area.is_in_group("powerups"):
        area.pickup()
        pickup.emit("powerup")
    if area.is_in_group("obstacles"):
        hurt.emit()
        die()
