extends Control

@onready var line_edit = $LineEdit
@onready var tasks_rewards = $"../Tasks_Rewards"
@onready var tasks:ItemList = $"../Tasks_Rewards/Tasks"
@onready var rewards:ItemList = $"../Tasks_Rewards/Rewards"
@onready var title_label = $TitleLabel
@onready var panel = $Panel
@onready var panel_2 = $Panel2
@onready var error_msg = $"../ErrorMsg"

@onready var items:ItemList = $Items

const BLUE_PANEL = preload("res://Assets/UI Base Pack/PNG/blue_panel.png")
const RED_PANEL = preload("res://Assets/UI Base Pack/PNG/red_panel.png")

enum states {
	ADD_TASK,
	ADD_REWARD
}

var current_state:states = states.ADD_TASK

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_items()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state == states.ADD_TASK:
		panel.texture = RED_PANEL
		panel_2.texture = RED_PANEL
		title_label.text = "Add Task!"
		line_edit.placeholder_text = "Task to do"
	if current_state == states.ADD_REWARD: 
		panel.texture = BLUE_PANEL
		panel_2.texture = BLUE_PANEL
		title_label.text = "Add Reward!"
		line_edit.placeholder_text = "Reward to recieve"


func _on_add_button_pressed():
	var item_name = line_edit.text
	if item_name == "":
		error_msg.set_msg("Can't submit empty value!")
		return
	line_edit.text = ""
	print("adding item: " + item_name)
	
	if current_state == states.ADD_TASK:
		print("type: task")
		tasks.add_item(item_name)
		
	else:
		rewards.add_item(item_name)
		print("type: reward")
	
	items.add_item(item_name)


func _on_swap_button_pressed():
	if current_state == states.ADD_TASK: current_state = states.ADD_REWARD
	else: current_state = states.ADD_TASK
	line_edit.text = ""
	
	refresh_items()
			

			
func refresh_items():
	items.clear()
	
	if current_state == states.ADD_TASK:
		for i in range(tasks.item_count):
			items.add_item(tasks.get_item_text(i))
			
	if current_state == states.ADD_REWARD:
		for i in range(rewards.item_count):
			items.add_item(rewards.get_item_text(i))

func _on_done_button_pressed():
	visible = false
	tasks_rewards.visible = true
	pass # Replace with function body.


func _on_add_more_items_pressed():
	visible = true
	tasks_rewards.visible = false
	pass # Replace with function body.


func _on_delete_item_pressed():
	var check1 = false
	var check2 = false
	
	if tasks.get_selected_items().size() > 0: 
		tasks.remove_item(tasks.get_selected_items()[0])
		check1 = true
	if rewards.get_selected_items().size() > 0: 
		rewards.remove_item(rewards.get_selected_items()[0])
		check2 = true
	
	if check1 or check2: pass
	else: error_msg.set_msg("Select at least 1 item to delete!")
	refresh_items()
	
	pass # Replace with function body.
