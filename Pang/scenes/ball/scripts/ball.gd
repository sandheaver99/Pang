extends Node2D

export var x_width = 4
export var y_height = 4
export var speed = 150

var upper_limit = y_height * 0.75
var lower_limit = Global.project_resolution.y - upper_limit
var vx = 1
var vy = 0

var MAXBALLSPEEDS = [100,200,300,400,500,600,700,800,900,1000]
var MAXBALLSPEED = 800
var ballspeed = MAXBALLSPEED/2
const MAXBOUNCEANGLE = deg2rad(75.0)
var ghost_delay = 0.05
var elapsed_delay = 0
var ghost = preload("res://scenes/ghost/Ghost.tscn")
var winning_score = 5

func _ready():
	set_process(false)
	
	$PaddleBlip.stream.loop_mode = 0
	$WallBlip.stream.loop_mode = 0
	
	$TextureRect.rect_size.x = x_width
	$TextureRect.rect_size.y = y_height
	
	reset_position()
	# move to start function

func start():
	$Timer.start()

func resize(_x, _y):
	$TextureRect.rect_size.x = _x
	$TextureRect.rect_size.y = _y
	reset_position()

func reset_position():
	$TextureRect.rect_position.x = -x_width/2
	$TextureRect.rect_position.y = -y_height/2

func reset(last_player):
	set_process(false)
	#set_ball_position(Vector2((Global.project_resolution.x)/2, (Global.project_resolution.y)/2))
	position.x = get_parent().get_node("Court/Midline").rect_position.x 
	position.y = get_parent().get_node("Court/Midline").rect_size.y/2
	
	
	ballspeed = MAXBALLSPEED/2
	if(Global.scores[(last_player+1)%2] == winning_score):
		game_over(last_player)
	else:
		vx = 1 if last_player == 0 else -1
		vy = 0
		$Timer.start()

func _process(delta):
	
	check_collision()
	
	position.x += vx * delta * ballspeed
	position.y += vy * delta * ballspeed
	
	elapsed_delay += delta
	if (elapsed_delay >= ghost_delay):
		elapsed_delay = 0
		create_ghost()
	
	
func check_collision():
	if(position.x <= Global.ball_limits_x[0] or position.x >= Global.ball_limits_x[1]):
			# check for collision with paddle
			var paddle
			
			if vx < 0:
				paddle = get_parent().get_node("PaddleLeft")
				
			else:
				paddle = get_parent().get_node("PaddleRight")
			
			if position.y > paddle.bounds.x:
					if position.y < paddle.bounds.y:
						$PaddleBlip.play()
						calc_vector(paddle)
						
			# ball is going out of bounds
			if(position.x <= Global.ball_limits_x[0]-20 or position.x >= Global.ball_limits_x[1]+20):
				Global.scores[(paddle.player + 1)%2] += 1
				$GoalGlip.play()
				reset(paddle.player)
	
	
	if(position.y <= Global.ball_limits_y[0] or position.y >= Global.ball_limits_y[1]):
		$WallBlip.play()
		vy = -vy
		send_signal_to_ai()

func calc_vector(paddle):
	
	var relative_intersect_y = (paddle.position.y - position.y)
	var normalized_relative_intersection_y = (relative_intersect_y/(paddle.y_height/2))
	var bounce_angle = normalized_relative_intersection_y * MAXBOUNCEANGLE
	vx = cos(bounce_angle) * (1 - (2*paddle.player))
	vy = -sin(bounce_angle)
	ballspeed = MAXBALLSPEED * (abs(normalized_relative_intersection_y) + 0.25)
	send_signal_to_ai()
	
func send_signal_to_ai():
	if Global.using_ai:
		var idle = vx < 0
		var ai = get_parent().get_node("PaddleRight/AI")
		ai.calc_intercept(position, vx, vy, idle)
		
	
func _on_Timer_timeout():
	set_process(true)

func game_over(losing_player):
	set_process(false)
	get_parent().get_node("Manager").game_running = false
	for powerup in get_tree().get_nodes_in_group("powerups"):
		powerup.fade()
	yield(get_tree().create_timer(1.0),"timeout")
	if(losing_player == 0):
		$YouLose.play()
	else:
		$YouWin.play()
	$TimerGameOver.start()
	

func _on_TimerGameOver_timeout():
	Global.scores = [0,0]
	#reset(0)
	#get_parent().get_node("Manager/Labels").visible = true
	get_parent().get_node("PangLogo/AnimationPlayer").play("Fade_In") 
	get_parent().get_node("Manager/Labels/F1Start/AnimationPlayer2").play("Fade_In") 
	get_parent().get_node("Manager/Labels/F2Options/AnimationPlayer3").play("Fade_In") 
	
func create_ghost():
# warning-ignore:unused_variable
	var new_ghost = ghost.instance()
	new_ghost.position = position
	get_parent().add_child(new_ghost)






