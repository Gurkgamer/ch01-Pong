class_name Ball extends Area2D

@onready var laser_pointer: Line2D = %LaserPointer
@onready var bounce_sfx: AudioStreamPlayer = %BounceSFX

var ball_direction: Vector2 = Vector2(1,1)
var speed: float = 500.0
var choosing_shoot_angle: bool = false
var is_second_player: bool = false
var is_bot: bool = false
var player_starting: Player = null

func _ready() -> void:
	choosing_shoot_angle = true
	laser_pointer.show()
	
func set_player_starting(player: Player, is_second_player_starting: bool) -> void:
	player_starting = player
	is_second_player = is_second_player_starting
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and choosing_shoot_angle:
		choosing_shoot_angle = false
		laser_pointer.hide()
		
func _physics_process(delta: float) -> void:
	if not choosing_shoot_angle:
		position = position + ball_direction * (speed * delta)
	else:
		draw_line_to_mouse()
	
func draw_line_to_mouse():
	var start_point: Vector2 = global_position
	var mouse_pointer: Vector2 = get_viewport().get_mouse_position()
	var line_directon = (mouse_pointer - start_point).normalized()
	if player_starting:
		global_position = player_starting.get_ball_spawn_point()
	
	# No demasiado detras
	if is_second_player and mouse_pointer.x > position.x - 30:
		mouse_pointer.x = position.x - 30
	elif not is_second_player and mouse_pointer.x < position.x + 30:
		mouse_pointer.x = position.x + 30
		
	# No demasiado delante
	var screen_middle = Global.screen_size / 2
	if is_second_player and mouse_pointer.x < screen_middle.x:
		mouse_pointer.x = screen_middle.x
	elif not is_second_player and mouse_pointer.x > screen_middle.x:
		mouse_pointer.x = screen_middle.x
		
	laser_pointer.points = [start_point, mouse_pointer]
	ball_direction = Vector2(mouse_pointer - start_point).normalized()
	
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
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
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
