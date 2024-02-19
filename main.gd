extends Node2D

@export var coin_scene: PackedScene
@export var play_time: float = 30.0

var level: int = 1
var score: int = 0
var time_left: float = 0.0
var screen_size = Vector2.ZERO
var is_playing: bool = false


func _ready() -> void:
    screen_size = get_viewport_rect().size
    $Player.screen_size = screen_size
    $Player.hide()


func _new_game() -> void:
    is_playing = true
    level = 1
    score = 0
    time_left = play_time
    $Player.start()
    $Player.show()
    $GameTimer.start()
    _spawn_coins()


func _spawn_coins() -> void:
    for i in level + 4:
        var coin_instance = coin_scene.instantiate()
        add_child(coin_instance)
        coin_instance.screen_size = screen_size
        coin_instance.position = Vector2(
                randi_range(0, screen_size.x),
                randi_range(0, screen_size.y))
