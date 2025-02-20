extends Node2D

func _ready() -> void:
	for sprinkler in get_children():
		sprinkler.emitting = false

func start_sprinklers():
	for sprinkler in get_children():
		sprinkler.emitting = true

func stop_sprinklers():
	for sprinkler in get_children():
		sprinkler.emitting = false
