extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color('00ff00')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AI_CheckButton_toggled(_button_pressed):
	if (pressed):
		modulate = Color('00ff00')
		$HSlider.editable = true
	else:
		modulate = Color('ff0000')
		$HSlider.editable = false

