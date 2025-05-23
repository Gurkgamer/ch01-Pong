class_name BallSpawnPoint
extends Marker2D

const BALL = preload("res://Scenes/Actors/Ball/ball.tscn")

@onready var laser_pointer: Line2D = %LaserPointer

var _spawning: bool = false
var is_player2_bot: bool
var is_player2_enabled: bool
var selected_ball_direction: Vector2
var spawning_ball: Node2D

func spawn_new_ball(is_bot: bool, player2_enabled: bool) -> void:
	is_player2_bot = is_bot
	is_player2_enabled = player2_enabled
	if _spawning:
		return
		
	_spawning = true
	laser_pointer.show()
	
	spawning_ball = BALL.instantiate()
	add_child(spawning_ball)
	spawning_ball.global_position = global_position

func _process(_delta: float) -> void:
	if _spawning:
		draw_line_to_mouse()

func draw_line_to_mouse():
	var start_point: Vector2 = global_position
	var mouse_pointer: Vector2 = get_viewport().get_mouse_position()
	var line_directon = (mouse_pointer - start_point).normalized()
	
	# No demasiado detras
	if is_player2_bot and mouse_pointer.x > position.x - 30:
		mouse_pointer.x = position.x - 30
	elif not is_player2_bot and mouse_pointer.x < position.x + 30:
		mouse_pointer.x = position.x + 30
		
	# No demasiado delante
	var screen_middle = Global.screen_size / 2
	if is_player2_bot and mouse_pointer.x < screen_middle.x:
		mouse_pointer.x = screen_middle.x
	elif not is_player2_bot and mouse_pointer.x > screen_middle.x:
		mouse_pointer.x = screen_middle.x
		
	laser_pointer.points = [start_point, mouse_pointer]
	selected_ball_direction = line_directon
	spawning_ball.global_position = global_position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and _spawning:
		_spawning = false
		laser_pointer.hide()
		spawning_ball.set_ball_direction(selected_ball_direction)
