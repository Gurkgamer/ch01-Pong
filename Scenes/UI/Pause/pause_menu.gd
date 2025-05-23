extends CanvasLayer

@export var game_scene: Node2D
@export var player2_button_text: Dictionary[bool, String]

@onready var reset_button: Button = %ResetButton
@onready var toggle_player_2: Button = %TogglePlayer2


var paused: bool = false

func _ready() -> void:
	hide()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		_toggle_pause_menu()
	
func _on_reset_button_pressed() -> void:
	_toggle_pause_menu()
	get_tree().reload_current_scene()
	
func _toggle_pause_menu() -> void:
	paused = !paused
	get_tree().paused = paused
	
	if paused:
		show()
	else:
		hide()

func _on_toggle_player_2_toggled(toggled_on: bool) -> void:
	EventBus.toggle_second_player.emit(toggled_on)
	toggle_player_2.text = player2_button_text[toggled_on]
