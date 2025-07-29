class_name Player
extends CharacterBody2D

signal scored()

@export var is_bot: bool = false
var is_player2_enabled: bool = false
var cpu_behaviour : CPU

@onready var ball_spawn_point: BallSpawnPoint = %BallSpawnPoint
var ball_reference: Area2D

const SPEED = 300.0

var movement
var up_key: String
var down_key: String

func _ready() -> void:
	if not is_bot:
		spawn_ball()
	else:
		EventBus.ball_detected.connect(
			func(ball: Area2D) -> void:
				ball_reference = ball
		)
		EventBus.toggle_second_player.connect(
			func(toggled_on: bool) -> void: 
				is_player2_enabled = toggled_on
				if cpu_behaviour and toggled_on:
					cpu_behaviour = null
				if not toggled_on:
					cpu_behaviour = CPU.new()
					cpu_behaviour.set_cpu_player(self)
				)

func _physics_process(delta: float) -> void:
	if not is_bot:
		var direction = Input.get_axis("player1_up", "player1_down")
		velocity.y = direction * SPEED
	elif is_player2_enabled:
		var direction = Input.get_axis("player2_up", "player2_down")
		velocity.y = direction * SPEED
	else:
		_ai_move()
	move_and_slide()
		
func get_ball_spawn_point() -> Vector2:
	return ball_spawn_point.global_position
		
func spawn_ball() -> void:
	ball_spawn_point.spawn_new_ball.call_deferred(is_bot, is_player2_enabled)
	
func _ai_move() -> void:
	if not cpu_behaviour:
		cpu_behaviour = CPU.new()
		cpu_behaviour.set_cpu_player(self)
	if ball_reference:
		cpu_behaviour.set_ball_reference(ball_reference)
		
	var cpu_direction = cpu_behaviour.cpu_direction()
	var cpu_speed = cpu_behaviour.cpu_speed()
	velocity.y = cpu_direction * cpu_speed
	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("algo")
	if area.is_in_group("Ball"):
		print("la bola")
		if ball_reference:
			ball_reference = null
		if is_bot and not is_player2_enabled:
			cpu_behaviour.remove_ball_referece()
