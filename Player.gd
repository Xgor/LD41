extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var armMinLimit = -0.5
export var armMaxLimit = 1.5


var walkSpeedSlider
var rotateSpeedSlider
var armRightSlider
var armLeftSlider
var armRightToggle = false
var armLeftToggle = false

var bullet




func _ready():
	var path = "../UI/Panel/"
	walkSpeedSlider   = get_node(path+"walkSpeed")
	rotateSpeedSlider = get_node(path+"rotateSpeed")
	armRightSlider = get_node(path+"armRight")
	armLeftSlider  = get_node(path+"armLeft")
#	armRightToggle = get_node(path+"armRight/Fire")
#	armLeftToggle  = get_node(path+"armLeft/Fire")
	
	bullet = $Bullet
	get_tree().paused = true
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	#*-walkSpeedSlider.value*delta
	
	# Rotate speed
	rotation += rotateSpeedSlider.value*delta
	
	# Walk Speed
	var local_right = Vector2( -sin(rotation), cos(rotation))
	move_and_collide(-walkSpeedSlider.value*delta*local_right)
	
	$ArmRightPivot.rotation += armRightSlider.value*delta
	$ArmRightPivot.rotation=clamp($ArmRightPivot.rotation,armMinLimit,armMaxLimit)
	
	$ArmLeftPivot.rotation += armLeftSlider.value*delta
	$ArmLeftPivot.rotation=clamp($ArmLeftPivot.rotation,-armMaxLimit,-armMinLimit)
	
	
	pass

func run():
	get_tree().paused = false
	$RunTimer.start()
	if armRightToggle:
		fireRight()
	if armLeftToggle:
		fireLeft()
	pass

func fireLeft():
	var b = bullet.duplicate()
	b.visible = true
	b.position = $ArmLeftPivot.global_position
	b.global_rotation = $ArmLeftPivot.global_rotation
	b.speed = 300
	get_tree().get_root().add_child(b)
	pass

# var node = ClassType.new()
# node.set_name("node")
# add_child(node)

func fireRight():
	var b = bullet.duplicate()
	b.visible = true
	b.position = $ArmRightPivot.global_position
	b.global_rotation = $ArmRightPivot.global_rotation
	b.speed = 300
	get_tree().get_root().add_child(b)
	pass

func _on_RunTimer_timeout():
	get_tree().paused = true
	pass # replace with function body


func _on_Button_pressed():
	run()
	pass # replace with function body


func _on_Fire_Left_toggled( button_pressed ):
	armLeftToggle = button_pressed
	pass # replace with function body


func __on_Fire_Right_toggled( button_pressed ):
	armRightToggle = button_pressed
	pass # replace with function body
