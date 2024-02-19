extends CanvasLayer

signal start_game


func _ready() -> void:
    $Timer.timeout.connect(_on_timer_timeout)
    $StartButton.pressed.connect(_on_start_button_pressed)


func update_score(value: int) -> void:
    $MarginContainer/ScoreLabel.text = str(value)


func update_timer(value: float) -> void:    
    $MarginContainer/TimeLabel.text = str(value)


func show_message(text: String) -> void:
    $MessageLabel.text = text
    $MessageLabel.show()
    $Timer.start()


func show_game_over() -> void:
    show_message("Game Over")
    await $Timer.timeout
    $StartButton.show()
    $MessageLabel.text = "Coin Dash!"
    $MessageLabel.show()


func _on_timer_timeout() -> void:
    $MessageLabel.hide()


func _on_start_button_pressed() -> void:
    $StartButton.hide()
    $MessageLabel.hide()
    start_game.emit()
