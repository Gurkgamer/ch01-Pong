extends CanvasLayer

@export var on_screen_score_time: float = 0.8
@onready var screen_score_timer: Timer = %ScreenScoreTimer
@onready var score_animation: AnimationPlayer = %ScoreAnimation

var player1_points: int = 0:
	set(value):
		player1_points = value
		%LeftPlayerScore.text = str(player1_points)

var player2_points: int = 0:
	set(value):
		player2_points = value
		%RigthPlayerScore.text = str(player2_points)

func _ready() -> void:
	EventBus.player_one_scored.connect(_on_player_one_scored)
	EventBus.player_two_scored.connect(_on_player_two_scored)
	screen_score_timer.wait_time = on_screen_score_time

func _on_player_one_scored(goal_points: int) -> void:
	await _show_score()
	player1_points += goal_points
	
func _on_player_two_scored(goal_points:int) -> void:
	await _show_score()
	player2_points += goal_points
	
func _show_score() -> void:
	if screen_score_timer.is_stopped():
		score_animation.play("show_scoreboard")
		await score_animation.animation_finished
		screen_score_timer.start()
	else:
		screen_score_timer.start()
		await get_tree().create_timer(0.0).timeout
	
func _hide_score() -> void:
	score_animation.play("hide_scoreboard")

func _on_screen_score_timer_timeout() -> void:
	_hide_score()
