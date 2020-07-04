extends Label

export var player = 0

func _ready():
	pass # Replace with function body.

func _process(_delta):
	text = str(Global.scores[player])
