extends Control


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_options_button_pressed() -> void:
	$Panel.visible = true


func _on_back_pressed() -> void:
	$Panel.visible = false
