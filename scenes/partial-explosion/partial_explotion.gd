class_name PartialExplosion
extends Node2D


func _ready():
	$AnimatedSprite2D.play()
	$SoundExplosion.play()

func _on_sound_explotion_finished() -> void:
	queue_free()
