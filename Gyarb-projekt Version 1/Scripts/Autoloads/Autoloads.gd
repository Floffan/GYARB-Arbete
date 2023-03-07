extends Node

var data_path = "user://Data.json"

var default_data = {
	"have_briefcase" : false,
	"flowers" : 0,
	"areas_visited" : [],
	"games_played" : [],
	"items" : [],
	"init_pos" : "",
	"init_loc" : ""
}

var data = { }



var Position = ""
var Current_loc = "res://Scenes/Main/World.tscn" # fixa så att current scene läggs till i alla scener

var Gate_collider = ""

var NPC_collider = ""

"""
var areas_visited = []
var games_played = []
#var games_played = ["Boatrace", "Bollplank", "Benchpress", "Skidshop"]

var Items = []
#var Items = ["Medal", "Key", "Plate", "Shirt"]

var flowers = 0

var have_briefcase : bool
#var have_briefcase = true

"""

func _ready():
	"""
	DEBUG-SYFTEN:
		v v v
	"""
	#load_game() # kommentera ut denna om du vill ha kvar samma progress i spelet varje gång det startas
	
	reset_data() # kommentera ut detta om  du vill resetta datan varje gång spelet startas

func _process(_delta):
	if Input.is_action_pressed("Escape"):
		save_pos()
		get_tree().quit()
		
	#print("datan:")
	#print(data)

func load_game():
	var file = File.new()

	if not file.file_exists(data_path):
		reset_data()
		return

	file.open(data_path, file.READ)

	var text = file.get_as_text()

	data = parse_json(text)


	file.close()


func save_game():
	var file

	file = File.new()

	file.open(data_path, File.WRITE)

	file.store_line(to_json(data))

	file.close()


func reset_data():
	# Reset to defaults
	data = default_data.duplicate(true)
	
	
func add_item(item):
	data["items"].append(item)
	save_game()
	
func add_area_visited(area):
	data["areas_visited"].append(area)
	save_game()
	
func add_game_played(game):
	data["games_played"].append(game)
	save_game()
	
func save_pos():
	data["init_pos"] = Position
	data["init_loc"] = Current_loc
	save_game()
	
func add_flower():
	data["flowers"] += 1
	save_game()
	
func update_briefcase(status):
	data["have_briefcase"] = status
	save_game()
	
		
	
	
	
	
	
	
