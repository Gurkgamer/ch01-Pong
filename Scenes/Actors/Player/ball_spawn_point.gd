class_name BallSpawnPoint
extends Marker2D

const BALL = preload("res://Scenes/Actors/Ball/ball.tscn")

var _spawning: bool = false

func spawn_new_ball(is_bot: bool) -> void:
	if _spawning:
		return
		
	_spawning = true
	
	var new_ball = BALL.instantiate()
	add_child(new_ball)	
	new_ball.set_player_starting(get_parent(), is_bot)
	new_ball.global_position = global_position
	
	_spawning = false
