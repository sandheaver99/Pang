extends CheckButton

#--------------------------------------------------------#
#                                                        #
# file_name.gd                                           #
# - by Sandheaver (2020)                                 #
# - License:                                             # 
#   https://creativecommons.org/licenses/by/4.0/         #
#                                                        #
# When checked, unhides the retro CRT shader via         #
# the Screen scene                                       #
#                                                        #
# For style guide, refer to:                               #
# https://tinyurl.com/ybacpsrf                           #
#                                                        #
#--------------------------------------------------------#

# signals
# enums (enum PascalCase, members are const CONSTANT_CASE)
# constants (const CONSTANT_CASE)
# exported variables (export snake_case)
# public variables (var snake_case)
# private variables (var _snake_case)
# onready variables (onready var snake_case)


# optional built-in virtual _init method
func _init():
	pass


# built-in virtual _ready method
func _ready():
	pass

# remaining built-in virtual methods such as callbacks
#func _process_input(delta):
#	pass

func _on_Retro_CheckButton_toggled(_button_pressed):
	var shader_node = get_tree().get_root().get_node("Screen/Shader")
	shader_node.visible = pressed

# public methods
#func foo():
#	pass

# private methods
#func _foo():
#	pass



