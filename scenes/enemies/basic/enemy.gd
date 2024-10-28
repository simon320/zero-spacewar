class_name BasicEnemy
extends Area2D

@export var Explosion: PackedScene

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group('player')
@onready var screensize = get_viewport_rect().size   # Tamaño de nuestra ventana
var move_right: bool = true
var speed


func _ready():
	$AnimatedSprite2D.play()
	speed = GLOBAL.random(150, 200)


func _physics_process(delta):
	position.y += (speed / 2) * delta
	move_x_direction(delta)


func move_x_direction(delta):
	if position.x <= (screensize.x - 10) and move_right:
		position.x += speed * delta
		if position.x >= (screensize.x - 10):
			move_right = false
	elif position.x >= 10:
		position.x -= speed * delta
		if position.x <= 10:
			move_right = true


func death_enemy():
	queue_free()
	explosion_ctrl()


func explosion_ctrl():
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionSpawn.global_position
	get_parent().add_child(explosion)


func _on_body_entered(body: CharacterBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	death_enemy()
	if GLOBAL.aura == true:
		GLOBAL.aura = false
	else:
		player.getDamage(5)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("shoot"):
		player.can_shoot = true
		death_enemy()
		area.queue_free()
		GLOBAL.score += 10


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
