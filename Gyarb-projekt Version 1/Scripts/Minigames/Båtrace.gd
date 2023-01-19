extends Node2D
"""
Ska man göra spelet svårare kanske? hur? en bränsletank kanske? lägga till Hajar?
"""

"""
Vilen båt det är : [Laps, Om båten har passerat checkpointen]
"""

onready var Boats = {
	"Boat_blue": [0, false],
	"Boat_green": [0, false],
	"Player": [0, false],
}

onready var laps_p = $Control/Panel/VBoxContainer/Player/Laps_P
onready var laps_g = $Control/Panel/VBoxContainer/Green/Laps_G
onready var laps_b = $Control/Panel/VBoxContainer/Blue/Laps_B

signal ready_done

func _process(delta: float) -> void:
	$Havet/Lager1.motion_offset.x += -50*delta
	$Palmer/AnimationPlayer.play("Default")
#	print("blue:")
#	print(Boats["Boat_blue"][0])
#	print("green:")
#	print(Boats["Boat_green"][0])
#	print("player:")
#	print(Boats["Player"][0])

func _win_screen(Boat):
	pass
		
	
func _update_scoreboard(Boat):
	# Detta går nog att göra på ett lite snyggare sätt... Aja lol
	if Boat == "Player":
		laps_p.bbcode_text = "[b][shake rate=10 level=20]" + str(Boats[str(Boat)][0]) + "[/shake][/b]"
		yield(get_tree().create_timer(1.5), "timeout")
		laps_p.bbcode_text = "[b]" + str(Boats[str(Boat)][0]) + "[/b]"
		
	if Boat == "Boat_green":
		laps_g.bbcode_text = "[b][shake rate=5 level=10]" + str(Boats[str(Boat)][0]) + "[/shake][/b]"
		yield(get_tree().create_timer(1.5), "timeout")
		laps_g.bbcode_text = "[b]" + str(Boats[str(Boat)][0]) + "[/b]"
		
	if Boat == "Boat_blue":
		laps_b.bbcode_text = "[b][shake rate=5 level=10]" + str(Boats[str(Boat)][0]) + "[/shake][/b]"
		yield(get_tree().create_timer(1.5), "timeout")
		laps_b.bbcode_text = "[b]" + str(Boats[str(Boat)][0]) + "[/b]"

func _on_Goal_body_exited(body):
	var boat_just_passed = body.name
	
	for Boat in Boats.keys():
		if boat_just_passed == Boat and Boats[str(Boat)][1] == true:
			Boats[str(Boat)][0] += 1
			Boats[str(Boat)][1] == false
			_update_scoreboard(Boat)
			
			if Boats[str(Boat)][0] == 5: # Kollar om båten har åkt tre varv än, om den har det initieras vinn-scenen
				_win_screen(Boat)

func _on_Checkpoint_body_exited(body):
	var boat_just_passed = body.name
	
	for Boat in Boats.keys():
		if boat_just_passed == Boat:
			Boats[str(Boat)][1] = true

func _on_Ready_screen_ready_done():
	$Ready_screen.rect_position.x += 20
	emit_signal("ready_done")
	yield(get_tree().create_timer(2), "timeout")
	remove_child($Ready_screen) # varför tar detta inte bort den från scenträdet:(
	
	
