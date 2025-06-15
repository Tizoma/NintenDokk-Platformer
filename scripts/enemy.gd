extends CharacterBody2D

@onready var timer = $Timer
@onready var ray_cast_2d = $RayCast2D

@export var direction=1
@export var speed = 60

func _on_area_2d_body_entered(body):
	#print(position.y-body.position.y)
	#Ha föntről jön meghal az ellenség
	if(position.y-body.position.y>28):
		body.jump()
		queue_free()
	#Ha nem akkor a player hal meg
	else:
		body.die()
		
func _physics_process(delta):
	#Ha nem player/null akkor megfordítja
	if(!(ray_cast_2d.get_collider() is CharacterBody2D) && ray_cast_2d.get_collider()!=null):
		direction=direction*-1
	
	#Irányba állítja a raycast2d-t
	ray_cast_2d.rotation=-90*direction
	#Gyorsoságát és gravitációt beállítja
	velocity.x=direction*speed
	velocity += get_gravity() * delta
	move_and_slide()
