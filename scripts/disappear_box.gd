extends Area2D
@onready var sprite_2d = $Sprite2D
@export_file var texture

func _ready():
	sprite_2d.texture=load(texture)
func _on_body_entered(_body):
	sprite_2d.visible= false
