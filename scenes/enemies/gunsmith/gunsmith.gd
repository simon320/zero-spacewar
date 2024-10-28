class_name Gunsmith
extends Area2D

@export var Explosion: PackedScene
@export var GunsmithShoot: PackedScene
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group('player')
@onready var can_shoot: bool = true

var speed
var positionClamp


func _ready():
	$AnimatedSprite2D.play()
	speed = GLOBAL.random(300, 350)
	positionClamp = GLOBAL.random(150, 250)


func _physics_process(delta):
	if position.y <= positionClamp:
		position.y += speed * delta


func death_enemy():
	queue_free()
	explosion_ctrl()


func explosion_ctrl():
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionSpawn.global_position
	get_parent().add_child(explosion)


func shoot_ctrl() -> void:
	var shoot = GunsmithShoot.instantiate()
	shoot.global_position = $ShootSpawn.global_position
	get_parent().add_child(shoot)


func _on_shoot_timer_timeout() -> void:
	shoot_ctrl()
#	$ShootTimer.wait_time = 1
	$ShootTimer.start()


func _on_body_entered(body: CharacterBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	death_enemy()
	if GLOBAL.aura == true:
		GLOBAL.aura = false
	else:
		player.getDamage(10)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("shoot"):
		death_enemy()
		area.queue_free()
		if not player:
			return
		player.can_shoot = true
		GLOBAL.score += 30
