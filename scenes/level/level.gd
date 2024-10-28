class_name Level
extends Node2D

@export var Enemy: PackedScene
@export var Gundsmith: PackedScene
@export var Bonus: PackedScene

@onready var player: CharacterBody2D = $Player
@onready var screensize = get_viewport_rect().size # Tamaño de nuestra ventana

var speed = 50
var alternEnemy = true


func _ready():
	$BgMusic.play()
	$EnemyTimer.start()
	$BonusTimer.start()
	randomize()



func _physics_process(delta):
	if $Player == null:
		return
		
	if int(Input.is_action_pressed("move_right")) and $Player.position.x < 500:
		get_node("Background").scroll_base_offset += Vector2(-0.6, 1) * speed * delta
	elif int(Input.is_action_pressed("move_left")) and $Player.position.x > 0:
		get_node("Background").scroll_base_offset += Vector2(0.6, 1) * speed * delta
	else:
		get_node("Background").scroll_base_offset += Vector2(0, 1) * speed * delta
	
	get_node("Clouds01").scroll_base_offset += Vector2(0, 1) * (speed * 2) * delta
	get_node("Clouds02").scroll_base_offset += Vector2(0, 1) * (speed * 3) * delta



func _on_enemy_timer_timeout() -> void:
	if !player:
		$EnemyTimer.stop()
	
	if alternEnemy:
		var basicEnemy = Enemy.instantiate()
		add_child(basicEnemy)
		basicEnemy.position = Vector2(randi_range(0, 500), 0)
	else:
		var gunsmith = Gundsmith.instantiate()
		add_child(gunsmith)
		gunsmith.position = Vector2(randi_range(0, 500), 0)
	
	$EnemyTimer.set_wait_time(GLOBAL.random(3, 5))
	$EnemyTimer.start()
	alternEnemy = not alternEnemy



func _on_bonus_timer_timeout() -> void:
	var bonus = Bonus.instantiate()
	add_child(bonus)
	bonus.position = Vector2(randi_range(0, 500), 0)
	$BonusTimer.wait_time = GLOBAL.random(5, 8)
	$BonusTimer.start()



func _on_hud_game_over() -> void:
	$BgMusic.stop()
