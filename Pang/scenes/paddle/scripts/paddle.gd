extends Node2D

export var x_width = 8
var y_height = 56
var speed = 200
export var player = 0
var upper_limit = y_height * 0.75
var lower_limit = Global.project_resolution.y - upper_limit
var bounds = Vector2(0,0)
var paddle_sizes = [12,23,34,45,56,67,78,89,100,112]
var paddle_speeds = [40,80,120,160,200,240,280,320,360,400]

func _ready():
	$TextureRect.rect_size.x = x_width
	$TextureRect.rect_size.y = y_height
	reset_position()
	update_bounds()
	Global.ball_limits_x[player] = position.x + (x_width * (1 - (2*player)))
	
	

func resize(_x, _y):
	$TextureRect.rect_size.x = _x
	$TextureRect.rect_size.y = _y
	reset_position()
	update_bounds()

func reset_position():
	$TextureRect.rect_position.x = -x_width/2
	$TextureRect.rect_position.y = -y_height/2

func set_paddle_position(_position):
	position = _position

func _process(delta):
	# Move up
	if Input.is_action_pressed(Global.CONTROLS[player]):
		# Move as long as the key/button is pressed.
		position.y -= speed * delta
		position.y = max(position.y, upper_limit)
	# Move down
	if Input.is_action_pressed(Global.CONTROLS[player+2]):
		# Move as long as the key/button is pressed.
		position.y += speed * delta
		position.y = min(position.y, lower_limit)
	update_bounds()

func update_bounds():
	bounds.x = position.y - (y_height/2)
	bounds.y = position.y + (y_height/2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
