extends Control

func _ready() -> void:
	Music.play_music("3")
	Transition.get_node("AnimationPlayer").play("RESET")
	Music.play_music = true
	
func _on_Nytt_spel_button_down():
	"""
	Om användaren trycker på nytt spel-knappen påbörjas en animation som på ett snyggt sätt övergår i spelets öppningscutscen
	Datan resettas, så att alla variabler återgår till grundvariablerna
	"""
	Autoloads.reset_data()
	$AnimationPlayer.play("on_nyttspel")

func _on_Fortstt_spel_button_down():
	"""
	Vid fortsatt-spel-knappen laddas scenen där spelaren var tidigare (Autoloads-funktionen load_game kallas)
	"""
	Autoloads.load_game()
	Autoloads.Position = Autoloads.data["init_pos"]
	Transition.load_scene(Autoloads.data["init_loc"])

func _on_AnimationPlayer_animation_finished(_anim_name):
	"""
	När transition-animationen är klar byts scenen till en cutscene
	"""
	get_tree().change_scene("res://Cutscenes/Waking_up_cutscene.tscn")


func _on_Avsluta_button_down() -> void:
	get_tree().quit()
