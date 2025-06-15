extends Node
@onready var logo = $Logo
@onready var start = $Start
@onready var toplista = $Toplista
@onready var vissza = $Vissza
@onready var leaderboard = $Leaderboard
@onready var loading_text = $Loading

const COLLECTION_ID = "highscores"
var results : Array
var show_toplista = false
var sortedArray : Array = Array()

func sort_time(a : Array, b : Array):
	if(a[1]==b[1]):
		return a[2]<b[2]
	return false

func _ready():
	var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
	var query : FirestoreQuery = FirestoreQuery.new().from("highscores").order_by("deaths",FirestoreQuery.DIRECTION.ASCENDING).limit(10)
	results = await Firebase.Firestore.query(query)
	for result in results:
		sortedArray.append([result.document.name["stringValue"],result.document.deaths["integerValue"],result.document.time["integerValue"]])
	sortedArray.sort_custom(sort_time)
	
func _on_level_1_pressed():
	Global.in_game=true
	Global.deaths=0
	Global.time=0
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func _process(delta):
	if show_toplista:
		if(!results.is_empty()):
			logo.visible=false
			start.visible=false
			toplista.visible=false
			loading_text.visible=false
			vissza.visible=true
			leaderboard.visible=true
			var i =0
			for label in leaderboard.get_children():
				if(label.name != "Nev" and label.name != "Halalok" and label.name != "Ido"):
					if i % 3 == 0:
						label.text=sortedArray[i/3][0]
					elif i % 3 == 1:
						label.text=sortedArray[i/3][1]
					else:
						label.text=sortedArray[i/3][2]
					i=i+1
		else:
			logo.visible=false
			start.visible=false
			toplista.visible=false
			loading_text.visible=true
			vissza.visible=true
	else:
		logo.visible=true
		start.visible=true
		toplista.visible=true
		loading_text.visible=false
		vissza.visible=false
		leaderboard.visible=false
		
func _on_toplista_pressed():
	show_toplista=true

func _on_vissza_pressed():
	show_toplista=false
