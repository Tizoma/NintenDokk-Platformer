extends Node

const COLLECTION_ID = "highscores"
@onready var line_edit = $LineEdit
@onready var eredmeny = $Eredmeny
@onready var nem_jo = $NemJo
@onready var submit = $Submit

func _ready():
	Global.in_game=false
	eredmeny.text = "A játékot végigvitted "+str(Global.deaths)+" halállal "+str(Global.time)+" másodperc alatt"
	#print(Time.get_datetime_string_from_system())
	
func _on_submit_pressed():
	var name = line_edit.text
	if(name.length()<3 or name.length()>40):
		nem_jo.visible=true
		submit.position.y=625
	else:
		var id = name.replace(" ","")
		#Firebase collectionhöz kapcsolatot létesít
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var deaths = Global.deaths
		var time = Global.time
		var submitTime = Time.get_datetime_string_from_system()
		#Lekérdezi a halálokat és a beírt nevet
		#Eltárolja
		var data : Dictionary= {
			"name": name,
			"deaths": deaths,
			"time": time,
			"submitTime":submitTime
		}
		#Lekérdezi az adatbázisból az azonos nevű documentumot
		var fromdb = await collection.get_doc(id)
		#Ha már létezik ilyen
		if(fromdb != null):
			#Ha kevesebb halállal vitte végig, frissítjük a halálait és az idejét
			if(fromdb.deaths>deaths):
				fromdb.deaths = deaths
				fromdb.time = time
				var _new_document = await collection.update(fromdb) 
			else:
				print("no update")
		else:
			var document = await collection.add(id,data)
			#print(document)
			
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
