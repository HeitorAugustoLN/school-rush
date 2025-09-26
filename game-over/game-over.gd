extends Control


func _on_yes_button_pressed() -> void:
	Score.score = 0
	Score.money = 0
	get_tree().change_scene_to_file("res://main.tscn")


func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu/main-menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
