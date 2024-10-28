class_name HUD
extends CanvasLayer

signal game_over


func _physics_process(_delta):
	$InfoContainer/ScoreContainer/Score.text = str(GLOBAL.score)
	setAnimatedHealth()


func setAnimatedHealth() -> void:
	var animated = str(GLOBAL.health)
	$HBoxContainer/ColorRect/AnimatedSprite2D.play(animated)


func set_game_over() -> void:
	emit_signal("game_over")
	$GameOverContainer.visible = true
	$BgMusic.play()


func _on_menu_pressed() -> void:
	# get_tree().call_deferred("reload_current_scene")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/menu/menu.tscn")


func _on_restart_pressed() -> void:
	GLOBAL.resetVariables()
	get_tree().call_deferred("reload_current_scene")


func _on_player_tree_exiting() -> void:
	set_game_over()
