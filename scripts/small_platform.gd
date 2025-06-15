extends AnimatableBody2D

@onready var sprite_2d = $Sprite2D

var starting_position

@export var axis = 1
@export var path_length=64
@export var speed=15.0
@export var direction=1
@export_file var texture
# Called when the node enters the scene tree for the first time.
func _ready():
	starting_position=position
	sprite_2d.texture=load(texture)
	
func _physics_process(delta):
	var move_distance=speed/10*direction
	#Vízszintes
	if(axis==1):
		position.x+=move_distance
		if((position.x-starting_position.x)>=path_length):
			direction=-1
		if((starting_position.x-position.x)>=path_length):
			direction=1
	#Függőlegesen
	elif(axis==2):
		position.y+=move_distance
		if((position.y-starting_position.y)>=path_length):
			direction=-1
		if((starting_position.y-position.y)>=path_length):
			direction=1
	#Balfönt-jöbblent
	elif(axis==3):
		position += Vector2(move_distance,move_distance)
		if((position.y-starting_position.y)>=path_length):
			direction=-1
		if((starting_position.y-position.y)>=path_length):
			direction=1
	#Jobbfönt-ballent
	elif(axis==4):
		position += Vector2(move_distance,-move_distance)
		if((position.x-starting_position.x)>=path_length):
			direction=-1
		if((starting_position.x-position.x)>=path_length):
			direction=1	
#func _process(delta):
