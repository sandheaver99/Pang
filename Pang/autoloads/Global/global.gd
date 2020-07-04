extends Node


var scores = [0, 0]
const CONTROLS = ["p1_up","p2_up","p1_down","p2_down"]
var project_resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
# Ball limits x values are automatically updated by the paddle nodes
var ball_limits_x =[0,0]
var ball_limits_y =[40,project_resolution.y -40]
var ai_level = 5
var using_ai = true
var ai_look_aheads = [0,0,0,1,2,2,2,3,3,4]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
