extends Node2D

#--------------------------------------------------------#
#                                                        #
# file_name.gd                                           #
# - by Sandheaver (2020)                                 #
# - License:                                             # 
#   https://creativecommons.org/licenses/by/4.0/         #
#                                                        #
# A node that does something...                          #
#                                                        #
# For style guide, refer to:                             #
# https://tinyurl.com/ybacpsrf                           #
#                                                        #
#--------------------------------------------------------#

# signals
# enums (enum PascalCase, members are const CONSTANT_CASE)
# constants (const CONSTANT_CASE)
# exported variables (export snake_case)
# public variables (var snake_case)
# private variables (var _snake_case)
var rotation_speed = 5
# onready variables (onready var snake_case)


# optional built-in virtual _init method
func _init():
	pass


# built-in virtual _ready method
func _ready():
	set_process(true)
	$Timer.start()

# remaining built-in virtual methods such as callbacks
func _process(_delta):
	rotation_degrees += rotation_speed

func _on_Timer_timeout():
	fade()

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

# public methods
func fade():
	$AnimationPlayer.play("fade_out")

func power_on():
	var ball = get_tree().get_root().get_node("Screen/Ball")
	ball.MAXBALLSPEED = 3000
	ball.ballspeed = ball.MAXBALLSPEED




# private methods
#func _foo():
#	pass






