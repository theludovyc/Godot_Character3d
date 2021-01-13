extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const moveSpeed=0.05
const maxSpeed=5.0

var speed:Vector2

var dir:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getAxis(inputA, inputB):
	return int(Input.is_action_pressed(inputA))-int(Input.is_action_pressed(inputB))

func getSpeed(dir, speed):
	if dir != 0:
		return clamp(speed+dir*moveSpeed, -1, 1)
	return sign(speed)*clamp(abs(speed)-moveSpeed, 0, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir.x = getAxis("ui_right", "ui_left")
	dir.y = getAxis("ui_down", "ui_up")
	
	dir = dir.normalized()
	
	speed.x = getSpeed(dir.x, speed.x)

	speed.y = getSpeed(dir.y, speed.y)
	
	if speed.length() > 1:
		speed = speed.normalized()
#	pass

func _physics_process(delta):
	move_and_slide(Vector3(speed.x, 0, speed.y)*maxSpeed, Vector3.UP)
