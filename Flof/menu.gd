extends Node2D



func _ready():
	get_node("animacao/Sprite3/AnimationPlayer").play("default")
	get_node("animacao/Sprite2/AnimationPlayer").play("default")
	get_node("AudioStreamPlayer").play()

func _on_Jogar_pressed():
	get_tree().change_scene("res://main_scene.tscn")
