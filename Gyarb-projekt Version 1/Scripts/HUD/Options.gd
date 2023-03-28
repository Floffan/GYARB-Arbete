extends CanvasLayer


func _process(delta: float) -> void:
	if Music.play_music:
		get_node("Control/Ljud av").text = "Ljud av"
	if !Music.play_music:
		get_node("Control/Ljud av").text = "Ljud på"
		
func _on_Fortstt_button_down() -> void:
	self.queue_free()

func _on_Huvudmeny_button_down() -> void:
	Transition.load_scene("res://Scenes/UI/Main_menu.tscn")

func _on_Ljud_av_button_down() -> void:
	Music.play_music = false
