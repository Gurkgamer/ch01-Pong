extends Area2D

enum goal_sides{
	RIGHT,
	LEFT
}

@export var goal_side: goal_sides

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is Ball:
		match body.get_ball_owner:
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
