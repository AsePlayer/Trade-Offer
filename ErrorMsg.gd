extends Label
class_name Error

@onready var timer = $Timer
var og_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	text = ""
	og_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if text != "":
		if position.y > og_pos.y - 50:
			position.y = lerp(position.y, position.y - 10 * delta, 2)
	else:
		position.y = og_pos.y

func set_msg(msg:String):
	position = og_pos
	text = msg
	visible = true
	timer.start()


func _on_timer_timeout():
	visible = false
	text = ""
