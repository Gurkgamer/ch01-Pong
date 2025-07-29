class_name CPU extends Node

var difficulty: int = 1
var difficulty_muliplyer: float = 1.2
var self_reference: Player
var speed: float = 70.0
var ball_node: Area2D

func _ready() -> void:
	EventBus.current_game_score.connect(
		func(current_score: Vector2) -> void:
			var score_difference: float = current_score.y - current_score.x
			if score_difference < 0:
				difficulty = 0.8
			elif score_difference == 0:
				difficulty = 1
			elif score_difference > 0:
				difficulty = 1.2
			)

func set_ball_reference(ball: Area2D) -> void:
	ball_node = ball
	
func remove_ball_referece() -> void:
	ball_node = null

func set_cpu_player(player2: Player) -> void:
	self_reference = player2

func cpu_direction() -> float:
	if not ball_node:
		return randf_range(-1, 1)
	
	if ball_node.global_position.y > self_reference.global_position.y:
		return 1
	elif ball_node.global_position.y < self_reference.global_position.y: 
		return -1
	else :
		return 0

func cpu_speed() -> float:
	return speed * difficulty * difficulty_muliplyer

func cpu_ball_spawn_angle() -> float:
	return 0.0
