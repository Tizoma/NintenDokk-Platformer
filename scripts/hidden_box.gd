extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
# ez a multiplier minél nagyobb, annál kisebb szögből érzékeli csak azt hogy jön a player
#ha nagyobb -> egyszerűbb, 1 alá ne menjen probably
@export var forgivenessMultiplier = 1.35

@export_file var texture

func _ready():
	sprite_2d.texture=load(texture)

func _on_area_2d_body_entered(body):
	#print(body.position.y)
	#print("kocka pos:")
	#print(collision_shape_2d.global_position.y)
	#print("vektor: ",body.position.x-collision_shape_2d.global_position.x," ",body.position.y-collision_shape_2d.global_position.y)
	if(abs(body.position.x-collision_shape_2d.global_position.x)*forgivenessMultiplier<body.position.y-collision_shape_2d.global_position.y):
		collision_shape_2d.set_deferred("disabled",false)
		sprite_2d.visible= true
