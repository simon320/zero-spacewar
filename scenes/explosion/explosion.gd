class_name Explosion

extends Node2D

func _ready():
	$AnimatedSprite2D.play()
	$SoundExplosion.play()

func _on_sound_explosion_finished() -> void:
	queue_free()
