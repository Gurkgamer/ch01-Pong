extends CanvasLayer

@export var game_scene: Node2D

@onready var reset_button: Button = %ResetButton

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
