extends Node2D

var sprinklers_on:bool = false

func _ready() -> void:
	for sprinkler in get_children():
		sprinkler.emitting = false
	Global.SprinklerSystem = self

func start_sprinklers():
	sprinklers_on = true
	for sprinkler in get_children():
		sprinkler.emitting = true

func stop_sprinklers():
	sprinklers_on = false
	for sprinkler in get_children():
		sprinkler.emitting = false
