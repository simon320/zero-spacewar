class_name GunsmithShoot
extends Area2D

const PLAYER = preload("res://scenes/player/player.tscn")
const SPEED = 380


func _ready():
	$AnimatedSprite2D.play('Laser')
	$SoundShoot.play()


func _physics_process(delta):
	position.y += SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: CharacterBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	if GLOBAL.aura == true:
		GLOBAL.aura = false
	else:
		player.getDamage(5)
	queue_free()
