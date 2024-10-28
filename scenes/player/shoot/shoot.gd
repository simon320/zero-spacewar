class_name PlayerShoot
extends Area2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group('player')

const SPEED = 180

func _ready():
	player.can_shoot = false
	$AnimatedSprite2D.play('BasicShoot')
	$SoundShoot.play()


func _physics_process(delta):
	position.y -= SPEED * delta
