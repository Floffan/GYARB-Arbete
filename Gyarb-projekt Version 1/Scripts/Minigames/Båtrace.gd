extends Node2D

"""
Vilken båt det är : [Laps, Om båten har passerat checkpointen]
"""

onready var w_screen = $Winscreen
onready var l_screen = $Loose_screen

onready var Boats = {
	"Boat_blue": [0, 0, 0, 0],
	"Boat_green": [0, 0, 0, 0],
	"Player": [0, 0, 0, 0],
}

onready var laps_p = $LAPS/Panel/VBoxContainer/Player/Laps_P # Laps Player
onready var laps_g = $LAPS/Panel/VBoxContainer/Green/Laps_G # Laps Gröna båten
onready var laps_b = $LAPS/Panel/VBoxContainer/Blue/Laps_B # Laps Blåa båten

var win_laps = 5

signal ready_done
signal game_over

func _ready():
	w_screen.game_path = "res://Scenes/Minigames/Boatrace.tscn"
	w_screen.world_path = "res://Scenes/Strand/racehouse_inside.tscn"
	
	l_screen.game_path = "res://Scenes/Minigames/Boatrace.tscn"
	l_screen.world_path = "res://Scenes/Strand/racehouse_inside.tscn"

func _process(delta: float) -> void:
	$Havet/Lager1.motion_offset.x += -50*delta
	$Palmer/AnimationPlayer.play("Default")

func _win_screen(Boat):
	emit_signal("game_over")
	w_screen.visible = true
	$Winscreen/AnimationPlayer.play("WIN")
	
func _loose_screen(Boat):
	emit_signal("game_over")
	if str(Boat) == "Boat_blue":
		$Loose_screen/vinnare.bbcode_text = "[b][wave amp=100 freq=2]    Den blåa båten vann![/wave][/b]"
	else:
		$Loose_screen/vinnare.bbcode_text = "[b][wave amp=100 freq=2]    Den gröna båten vann![/wave][/b]"
	$Loose_screen.visible = true
	$Loose_screen/AnimationPlayer.play("LOOSE")
		
func _update_scoreboard(Boat):
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

func _clear_checkpoints(Boat):
	for i in range(1, 4):
		Boats[str(Boat)][i] = 0
		
	if Boat == "Player":
		print(Boats[str(Boat)])
		
	
func _on_Goal_body_exited(body):
	var boat_just_passed = body.name
	
	for Boat in Boats.keys():
		var checkpoints = false
		if boat_just_passed == Boat:
			for i in range(1, 4):
				if int(Boats[str(Boat)][i]) == int(i):
					checkpoints = true
					#print("jippie")
				else:
					checkpoints = false
					#print("nej:(")
			if checkpoints == true:
				Boats[str(Boat)][0] += 1
				_update_scoreboard(Boat)
				_clear_checkpoints(Boat)
				checkpoints = false
				
				if Boat == "Player":
					pass
					#print(Boats[str(Boat)])
					#print(checkpoints)
				
					
				if Boats[str(Boat)][0] == win_laps: # Kollar om båten har åkt tre varv än, om den har det initieras vinn-scenen
					if str(Boat) == "Player":
						_win_screen(Boat)
					else:
						_loose_screen(Boat)
				
				
			#print(Boats[str(Boat)][1])
			#print(Boats[str(Boat)][2])
			#print(Boats[str(Boat)][3])
	#		if Boats[Boat][1] == "1":
	#			print("OK")
	#		for i in range(1, 4):
	#			if Boats[str(Boat)][i] == i:
	#				print("OK")
				
	
	"""
	for Boat in Boats.keys():
		
		if boat_just_passed == Boat and Boats[str(Boat)][1] == true:
			Boats[str(Boat)][0] += 1
			Boats[str(Boat)][1] == false
			_update_scoreboard(Boat)
			
			if Boats[str(Boat)][0] == win_laps: # Kollar om båten har åkt tre varv än, om den har det initieras vinn-scenen
				if str(Boat) == "Player":
					_win_screen(Boat)
				else:
					_loose_screen(Boat)
	"""

func _on_Ready_screen_ready_done():
	$Ready_screen.rect_position.x += 20
	emit_signal("ready_done")
	yield(get_tree().create_timer(2), "timeout")
	#get_child("Ready_screen").queue_free()
	#remove_child($Ready_screen) # varför tar detta inte bort den från scenträdet:(
	
	
func _checkpoint(body, nr):
	var boat_just_passed = body.name
	
	for Boat in Boats.keys():
		if boat_just_passed == Boat:
			Boats[str(Boat)][nr] = str(nr)
			

func _on_Checkpoint1_body_exited(body: Node) -> void:
	_checkpoint(body, 1)
	var Boat = body.name
	if Boat == "Player":
		pass
		#print(Boats[str(Boat)])


func _on_Checkpoint2_body_exited(body: Node) -> void:
	_checkpoint(body, 2)
	var Boat = body.name
	if Boat == "Player":
		pass
		#print(Boats[str(Boat)])


func _on_Checkpoint3_body_exited(body: Node) -> void:
	_checkpoint(body, 3)
	var Boat = body.name
	if Boat == "Player":
		pass
		#print(Boats[str(Boat)])
