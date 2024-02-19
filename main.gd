extends Node2D

@export var coin_scene: PackedScene
@export var powerup_scene: PackedScene
@export var play_time: float = 30.0

var level: int = 1
var score: int = 0
var time_left: float = 0.0
var screen_size = Vector2.ZERO
var is_playing: bool = false


func _ready() -> void:
    $Player.pickup.connect(_on_player_pickup)
    $Player.hurt.connect(_on_player_hurt)
    $GameTimer.timeout.connect(_on_game_timer_timeout)
    $PowerupTimer.timeout.connect(_on_powerup_timer_timeout)
    $HUD.start_game.connect(_on_hud_start_game)
    screen_size = get_viewport_rect().size
    $Player.screen_size = screen_size
    $Player.hide()


func _process(_delta) -> void:
    if is_playing && get_tree().get_nodes_in_group("coins").size() == 0:
        level += 1
        time_left += 5
        _spawn_coins()


func _new_game() -> void:
    is_playing = true
    level = 1
    score = 0
    time_left = play_time
    $Player.start()
    $Player.show()
    $GameTimer.start()
    $HUD.update_score(score)
    $HUD.update_timer(time_left)
    _spawn_coins()


func _spawn_coins() -> void:
    $PowerupTimer.start()
    $LevelSoundAudioStreamPlayer.play()
    for i in level + 4:
        var coin_instance = coin_scene.instantiate()
        add_child(coin_instance)
        coin_instance.screen_size = screen_size
        coin_instance.position = Vector2(
                randi_range(0, screen_size.x),
                randi_range(0, screen_size.y))


func _game_over() -> void:
    $EndSoundAudioStreamPlayer.play()
    is_playing = false
    $GameTimer.stop()
    get_tree().call_group("coins", "queue_free")
    $HUD.show_game_over()
    $Player.die()


func _on_player_pickup(type: String) -> void:
    match type:
        "coin":
            score += 1
            $HUD.update_score(score)
            $CoinSoundAudioStreamPlayer.play()
        "powerup":
            $PowerupSoundAudioStreamPlayer.play()
            time_left += 5
            $HUD.update_timer(time_left)


func _on_player_hurt() -> void:
    _game_over()


func _on_game_timer_timeout() -> void:
    time_left -= 1
    $HUD.update_timer(time_left)
    if time_left <= 0:
        _game_over()


func _on_powerup_timer_timeout() -> void:
    var powerup_instance = powerup_scene.instantiate()
    add_child(powerup_instance)
    powerup_instance.screen_size = screen_size
    powerup_instance.position = Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y))


func _on_hud_start_game() -> void:
    _new_game()
