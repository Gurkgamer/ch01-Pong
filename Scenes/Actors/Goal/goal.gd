extends Area2D

enum goal_sides{
	RIGHT,
	LEFT
}

@export var goal_side: goal_sides

# Viejo
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		_add_goal(body.get_ball_owner())

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		_add_goal(area.get_ball_owner())

func _add_goal(goal_owner: int) -> void:
	match goal_owner:
		0:
			if goal_side == goal_sides.RIGHT:
				EventBus.player_one_scored.emit(1)
			elif goal_side == goal_sides.LEFT:
				EventBus.player_two_scored.emit(1)
		1: # My owner is the player 1
			if goal_side == goal_sides.RIGHT:
				EventBus.player_one_scored.emit(1)
		2: # My owner is PLayer 2
			if goal_side == goal_sides.LEFT:
				EventBus.player_two_scored.emit(1)
	
