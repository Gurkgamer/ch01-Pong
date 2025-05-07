class_name Ball extends Area2D

enum possible_ball_owners{
	NONE,
	PLAYER1,
	PLAYER2
}

@export var _ball_owner: possible_ball_owners = possible_ball_owners.NONE

var ball_direction: Vector2 = Vector2(1,1)
var speed: float = 300.0

func _physics_process(delta: float) -> void:
	position = position + ball_direction * (speed * delta)
	
# Paredes
func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		ball_direction.y = ball_direction.y * -1
	else:
		print("why though")

func get_ball_owner() -> int:
	return _ball_owner

# Porteria
func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if not area.is_in_group("Player"):
		ball_direction.x = ball_direction.x * -1

# Jugador
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
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
