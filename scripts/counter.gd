extends CanvasLayer
@onready var halalok = $Halalok
@onready var ido = $Ido

func _process(_delta):
	halalok.text = "Halálok: "+str(Global.deaths)
	ido.text = "Eltelt idő: "+str(Global.time)
