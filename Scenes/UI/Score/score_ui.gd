extends CanvasLayer

var player1_points: int = 0:
	set(value):
		player1_points = value
		_refresh_ui_scores()
var player2_points: int = 0:
	set(value):
		player2_points = value
		_refresh_ui_scores()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.player_one_scored.connect(_on_player_one_scored)
	EventBus.player_two_scored.connect(_on_player_two_scored)

func _on_player_one_scored(goal_points: int) -> void:
	player1_points += goal_points
	
func _on_player_two_scored(goal_points:int) -> void:
	player2_points += goal_points
	
func _refresh_ui_scores() -> void:
	%LeftPlayerScore.text = str(player1_points)
	%RigthPlayerScore.text = str(player2_points)
	
