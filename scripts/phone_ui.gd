extends Node2D
@onready var ball_gomb = $BallGomb
@onready var jobb_gomb = $JobbGomb
@onready var fel_gomb = $FelGomb
@onready var player = $"../Player"
var starting_y

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_y=self.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x = player.position.x
	if player.position.y<-95:
		self.position.y = starting_y+player.position.y+95
	else:
		self.position.y = starting_y
	#print(player.position.y)
	#pass
