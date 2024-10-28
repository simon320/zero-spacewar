extends Node

@onready var score: int = 0
@onready var health: int = 25
@onready var aura: bool = false
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var axis: Vector2

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()


func random(min_number, max_number) -> int:
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)
	return random


func resetVariables() -> void:
	score = 0
	health = 25
	aura = false
