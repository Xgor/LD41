extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 0
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var local_right = Vector2( -sin(rotation), cos(rotation))
	global_translate(local_right*-speed*delta)
	pass
