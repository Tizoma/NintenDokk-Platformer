extends StaticBody2D
@onready var timer = $Timer

func _on_area_2d_body_entered(body):
	body.die()
