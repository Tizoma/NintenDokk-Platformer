extends Sprite2D
@export var speed= 5.0
@export var direction = -1
var movingSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
	movingSpeed=speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x+=speed/35*direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	if(direction==-1):
		position.x=2000
	else:
		position.x=200
	movingSpeed=60

func _on_visible_on_screen_notifier_2d_screen_entered():
	movingSpeed=speed
