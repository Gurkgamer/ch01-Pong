extends Node

var screen_size: Vector2: # Facilita coger el tamaño de la ventana sin tener que escribir todo
	set(value):
		pass
	get:
		return get_viewport().get_visible_rect().size
