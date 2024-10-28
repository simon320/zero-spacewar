class_name Bonus
extends Area2D

var speed


func _ready():
	$AnimatedSprite2D.play()
	speed = GLOBAL.random(150, 200)


func _physics_process(delta):
	position.y += speed * delta


func get_bonus():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_bonus()
		GLOBAL.score += 30
		GLOBAL.aura = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
