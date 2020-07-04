extends Node

#----------------------------------------------------------------------#
#                                                                      #
# ai.gd                                                                #
# - by Sandheaver (2020)                                               #
#                                                                      #
# Controls the AI paddle via a call to calc_intercept()  from ball.gd  #
#                                                                      #
#----------------------------------------------------------------------#

# signals
# enums (enum PascalCase)
# constants (const CONSTANT_CASE)
var RNG = RandomNumberGenerator.new()
# exported variables (export snake_case)
# public variables (var snake_case)
# private variables (var _snake_case)
var intercept = Global.project_resolution.y/2
var move_check_time = 0.1 # secs
var time_elapsed = 0
var look_ahead = Global.ai_look_aheads[Global.ai_level-1] # no of bounces to evaluate
# onready variables (onready var snake_case)


# optional built-in virtual _init method
func _init():
	pass


# built-in virtual _ready method
func _ready():
	RNG.randomize()

# remaining built-in virtual methods such as callbacks
func _process(delta):
	time_elapsed += delta
	if time_elapsed > move_check_time:
		time_elapsed = 0
		send_move_signal()

# public methods
func calc_intercept(ball_pos, vx, vy, idle):
	if idle:
		intercept = Global.project_resolution.y/2
	else:
		var pad = get_parent()
		var distance = (pad.position.x - pad.x_width/2) - ball_pos.x
		intercept = ball_pos.y + (vy * (distance/vx))
		#print(str("Intercept at: ", intercept))
		
		# check if intercept is just bouncing into a wall
		if intercept <= Global.ball_limits_y[0] or intercept >= Global.ball_limits_y[1]:
				if look_ahead > 0:
					look_ahead -= 1
					intercept = Global.ball_limits_y[int(intercept > 0)]
					var vector_x = ((abs((intercept - ball_pos.y)/vy)) * vx) + ball_pos.x
					var new_ball_pos = Vector2(vector_x, intercept)
					#print(str("vx is: ", vx))
					#print(str("ball_pos.x is: ", ball_pos.x))
					#print(str("Warning! OOB Intercept at: ", Vector2(vector_x,intercept)))
					#print(str("Using old intercept of ", new_ball_pos))
					#print("Recalculating intercept as ....")
					calc_intercept(new_ball_pos, vx, -vy, false)
		
		# add skillful offset to intercept
		var max_offset = (pad.y_height/2) - 4 # -2 as safety buffer
		var dir = RNG.randi_range(-1,1)
		var planned_offset = RNG.randf_range(0, max_offset)
		intercept += (planned_offset * dir * (Global.ai_level/10))
		
		var error_check = RNG.randi_range(1,10)
		var error = error_check > Global.ai_level
		
		# Use error only for bounces?
		if error: #and look_ahead < Global.ai_look_aheads[Global.ai_level-1]:
			print(error)
			var error_amount = ((error_check - Global.ai_level) * dir * (10-Global.ai_level))
			intercept += error_amount
			print(str("Adding offset of ", error_amount))
		
		look_ahead = Global.ai_look_aheads[Global.ai_level-1]
	
	

# private methods
func send_move_signal():
	var pad = get_parent()
	#print(str("Pad.y = ", pad.position.y))
	#print(str("Intercept.y = ", intercept))
	var gap = int(pad.position.y) - int(intercept)
	if gap < 0:
		# move down
		simulate_key("p2_down")
		#print("moving down")
	elif gap > 0:
		# move up
		simulate_key("p2_up")
		#print("moving up")
	else:
		#print("stop")
		Input.action_release("p2_up")
		Input.action_release("p2_down")
		
	if abs(gap) < pad.y_height/4:
		#close enough
		Input.action_release("p2_up")
		Input.action_release("p2_down")
#		move_check_time = 0.2
#	else:
#		move_check_time = 0.1


func simulate_key(key):
	if key == "p2_down" and Input.is_action_pressed("p2_up"):
		Input.action_release("p2_up")
	elif key == "p2_up" and Input.is_action_pressed("p2_down"):
		Input.action_release("p2_down")
	Input.action_press(key)
	
	
	
