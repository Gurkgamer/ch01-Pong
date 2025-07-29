extends Area2D

signal ball_position(ball_global_position: Vector2)

var ball_reference
var detected: bool

func _physics_process(delta: float) -> void:
	if ball_reference:
		#print(ball_reference.global_position)
		pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		#ball_reference = area
		if area.ball_direction.x > 0:
			EventBus.ball_detected.emit(area)
		
