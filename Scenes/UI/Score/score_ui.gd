class_name ScoreUI extends CanvasLayer

@export var player1: Player
@export var player2: Player

@export var on_screen_score_time: float = 0.8

@onready var screen_score_timer: Timer = %ScreenScoreTimer
@onready var score_animation: AnimationPlayer = %ScoreAnimation
@onready var left_player_score: Label = %LeftPlayerScore
@onready var right_player_score: Label = %RightPlayerScore

var player1_points: int = 0:
	set(value):
		player1_points = value
		left_player_score.text = str(player1_points)

var player2_points: int = 0:
	set(value):
		player2_points = value
		right_player_score.text = str(player2_points)

func _ready() -> void:
	player1.scored.connect(_on_player_one_scored)
	player2.scored.connect(_on_player_two_scored)
	screen_score_timer.wait_time = on_screen_score_time
	left_player_score.text = str(0)
	right_player_score.text = str(0)

func _on_player_one_scored() -> void:
	await _show_score()
	player1_points += 1
	
func _on_player_two_scored() -> void:
	await _show_score()
	player2_points += 1
	
func _show_score() -> void:
	if score_animation.is_playing() and score_animation.current_animation == "hide_scoreboard":
		await score_animation.animation_finished
		
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
