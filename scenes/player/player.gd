class_name Player
extends CharacterBody2D


@export var Shoot: PackedScene
@export var Explosion: PackedScene
@export var PartialExplosion: PackedScene
@onready var motion = Vector2.ZERO   # Es lo mismo que poner Vector2(0, 0)
@onready var can_shoot: bool = true
@onready var screensize = get_viewport_rect().size   # Tamaño de nuestra ventana
const SPEED = 280

func _ready():
	$Ship_AnimatedSprite2D.play()
	$Aura_AnimatedSprite2D.play()


func _physics_process(delta):
	motion_ctrl()
	animation_ctrl()
	aura_animation_ctrl()
	motion = move_and_collide(motion * delta)


func _input(event):
	if event.is_action_pressed("trigger_shoot") and can_shoot:
		shoot_ctrl()


func get_axis() -> Vector2:  # Obtener ejes
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis


func motion_ctrl() -> void:  # Controlar movimiento
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = get_axis().normalized() * SPEED  # normalize ayuda a que el desplazamiento en digonal no sea mas rapido
		
		# Limitar movimiento del personaje
		position.x = clamp(position.x, 0, screensize.x)
		position.y = clamp(position.y, 0, screensize.y)


func animation_ctrl() -> void:
	if get_axis().x == 1:
		$Ship_AnimatedSprite2D.animation = "Horizontal"
		$Ship_AnimatedSprite2D.flip_h = false
	elif get_axis().x == -1:
		$Ship_AnimatedSprite2D.animation = "Horizontal"
		$Ship_AnimatedSprite2D.flip_h = true
	else:
		$Ship_AnimatedSprite2D.animation = "Vertical2"


func aura_animation_ctrl() -> void:
	if GLOBAL.aura == true:
		$Aura_AnimatedSprite2D.set_visible(true)
	else:
		$Aura_AnimatedSprite2D.set_visible(false)


func shoot_ctrl() -> void:
	var shoot = Shoot.instantiate()
	shoot.global_position = $ShootSpawn.global_position
	get_parent().add_child(shoot)


func explosion_ctrl() -> void:
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionSpawn.global_position
	get_parent().add_child(explosion)


func partial_explosion_ctrl() -> void:
	var explosion = PartialExplosion.instantiate()
	explosion.global_position = $PartialExplosionSpawn1.global_position
	get_parent().add_child(explosion)


func be_damage() -> void:
	modulate = Color(1, 1, 1, 0.2)
	$BeDamagedTimer.start()


func _on_be_damaged_timer_timeout() -> void:
	modulate = Color(1, 1, 1, 1)



func _on_shoot_timer_timeout() -> void:
	can_shoot = true
#	$ShootTimer.wait_time = 1
	$ShootTimer.start()


func getDamage(damage: int) -> void:
	GLOBAL.health -= damage
	partial_explosion_ctrl()
	be_damage()
	
	if GLOBAL.health <= 0:
		explosion_ctrl()
		queue_free()
