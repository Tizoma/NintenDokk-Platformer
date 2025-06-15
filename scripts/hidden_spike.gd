extends StaticBody2D
@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D

func _on_area_2d_body_entered(body):
	body.die()
	sprite_2d.visible= true
