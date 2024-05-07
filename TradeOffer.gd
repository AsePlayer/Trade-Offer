extends Control

@onready var tasks = $"../Tasks_Rewards/Tasks"
@onready var rewards = $"../Tasks_Rewards/Rewards"
@onready var tasks_rewards = $"../Tasks_Rewards"
@onready var error_msg = $"../ErrorMsg"

var current_task:String
var current_reward:String

var current_task_id:int
var current_reward_id:int

@onready var video_stream_player:VideoStreamPlayer = $VideoStreamPlayer
@onready var tasks_label = $TasksLabel
@onready var rewards_label = $RewardsLabel

func _ready():
	visible = false

func _process(delta):
	pass


func _on_trade_done_button_pressed():
	tasks.remove_item(current_task_id)
	rewards.remove_item(current_reward_id)
	
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
