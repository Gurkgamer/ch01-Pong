extends Node

var screensize: Vector2:
	set(value):
		pass
	get:
		return get_viewport().get_visible_rect().size
