extends CharacterBody2D

const MAX_SPEED = 260.0
const SPEED = 90.0
const JUMP_VELOCITY = -440.0
const JUMP_SLOW = -18.0
@onready var soma_sprite_2d = $SomaSprite2D
@onready var krisz_sprite_2d = $KriszSprite2D
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

@export var melyikSprite=true

var alive=true

func _ready():
	if(Global.lastCheckpoint==null):
		pass
	else:
		position=Global.lastCheckpoint
	alive=Global.in_game
	krisz_sprite_2d.visible=melyikSprite
	soma_sprite_2d.visible=!melyikSprite
		

func _physics_process(delta):
	if alive:
		#Gravitáció
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()
		
		if not Input.is_action_pressed("jump") and not is_on_floor() and velocity.y<0:
			velocity.y -=JUMP_SLOW

		
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = move_toward(velocity.x,direction*MAX_SPEED,SPEED)
		#Lelassítja a karaktert ha nincs nyomva gomb
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED*0.5)
	else:
		velocity.x=0
		velocity.y=0
	
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	animation_player.play("jump")
	
func die():
	alive=false
	Global.deaths+=1
	animation_player.play("death")
	timer.start()

func _on_timer_timeout():
		get_tree().reload_current_scene(); 
