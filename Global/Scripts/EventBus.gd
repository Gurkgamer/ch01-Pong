extends Node

## System signals
@warning_ignore("unused_signal") signal toggle_second_player(toggled_player2_on: bool)

## Game signals
@warning_ignore("unused_signal") signal current_game_score(game_score: Vector2)
@warning_ignore("unused_signal") signal ball_detected(ball_global_position: Vector2)
