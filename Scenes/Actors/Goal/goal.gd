extends Area2D

@export var rival_player: Player

@onready var scored_sfx: AudioStreamPlayer = %ScoredSFX

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		scored_sfx.play()
		_score_goal()

func _score_goal() -> void:
	rival_player.scored.emit()
