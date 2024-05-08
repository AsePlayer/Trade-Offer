extends Control

@onready var tasks = $"../Tasks_Rewards/Tasks"
@onready var rewards = $"../Tasks_Rewards/Rewards"
@onready var tasks_rewards = $"../Tasks_Rewards"
@onready var error_msg = $"../ErrorMsg"

var current_task:String
var current_reward:String

var current_task_id:int
var current_reward_id:int
@onready var item_adder = $"../ItemAdder"

@onready var video_stream_player:VideoStreamPlayer = $VideoStreamPlayer
@onready var tasks_label = $TasksLabel
@onready var rewards_label = $RewardsLabel

func _ready():
	visible = false

func _process(delta):
	pass


func _on_trade_done_button_pressed():
	var task_name:String = tasks.get_item_text(current_task_id)
	var reward_name:String = rewards.get_item_text(current_reward_id)
	
	var completed_msg = ("Did " + task_name + " for " + reward_name)
	
	# Get current date and time
	var current_datetime = Time.get_datetime_dict_from_system()
	
	# Access individual components of the date and time
	var year = str(current_datetime.year)
	var month = str(current_datetime.month)
	var day = str(current_datetime.day)
	var hour = str(current_datetime.hour)
	var minute = str(current_datetime.minute)
	if int(minute) < 10:
		minute = "0" + minute
	var second = str(current_datetime.second)
	
	# Determine am or pm
	var am_or_pm = "am"
	if int(hour) >= 12:
		am_or_pm = "pm"
		if int(hour) > 12:
			hour = str(int(hour) - 12)
	
	var date_format = month + "/" + day + "/" + year + ", " + hour + ":" + minute + am_or_pm
	
	#print("Current Date and Time:")
	#print(date_format)
	
	SaveLoad.update_data("completed_tasks", completed_msg + " at " + date_format)
	tasks.remove_item(current_task_id)
	rewards.remove_item(current_reward_id)
	item_adder.refresh_items()
	
	current_task_id = 0
	current_reward_id = 0
	_on_back_button_pressed()


func _on_trade_offer_button_pressed():
	if tasks.item_count == 0 or rewards.item_count == 0: 
		error_msg.set_msg("Need at least 1 task and reward to trade!")
		return
	video_stream_player.paused = false
	
	current_task_id = randi() % tasks.item_count
	current_task = tasks.get_item_text(current_task_id)
	tasks_label.text = current_task
	
	
	current_reward_id = (randi() % rewards.item_count)
	current_reward = rewards.get_item_text(current_reward_id)
	rewards_label.text = current_reward
	visible = true
	tasks_rewards.visible = false
	print("TRADE OFFER:" + current_task + " -> " + current_reward)
	print()
	video_stream_player.play()
	


func _on_video_stream_player_finished():
	video_stream_player.play()
	video_stream_player.paused = true
	pass # Replace with function body.


func _on_reroll_button_pressed():
	_on_trade_offer_button_pressed()
	pass # Replace with function body.


func _on_back_button_pressed():
	visible = false
	tasks_rewards.visible = true
	pass # Replace with function body.
