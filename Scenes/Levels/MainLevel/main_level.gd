extends Node2D

@export var player1: Player
@export var player2: Player

func _ready() -> void:
	player1.scored.connect(player2.spawn_ball)
	player2.scored.connect(player1.spawn_ball)
