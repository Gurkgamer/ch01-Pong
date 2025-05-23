class_name Ball extends Area2D

@onready var bounce_sfx: AudioStreamPlayer = %BounceSFX

var ball_direction: Vector2 = Vector2(1,1)
var speed: float = 500.0
var choosing_shoot_angle: bool = false

func _ready() -> void:
	choosing_shoot_angle = true

func _physics_process(delta: float) -> void:
	if not choosing_shoot_angle:
		position = position + ball_direction * (speed * delta)
	
func set_ball_direction(ball_direction_selected: Vector2) -> void:
	ball_direction = ball_direction_selected
	choosing_shoot_angle = false

# Paredes
func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		ball_direction.y = ball_direction.y * -1
		bounce_sfx.play()

# Porteria
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Goal"):
		queue_free()

# Jugador
func _on_body_shape_entered(_body_rid: RID, body: Node2D, body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		bounce_sfx.play()
		ball_direction.x = ball_direction.x * -1
		match body_shape_index: # Que hacer dependiendo de la zona del palo
			0:
				pass
				#ball_direction.x = ball_direction.x * -1
			1:
				pass
				#ball_direction.x = ball_direction.x * -1
			2:
				pass
				#ball_direction.x = ball_direction.x * -1
