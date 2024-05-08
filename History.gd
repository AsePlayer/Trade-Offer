extends Control

# Pulls JSON data and puts it in an ItemList
@onready var items = $Items

@onready var add_more_items = $"../Tasks_Rewards/AddMoreItems"
@onready var delete_item = $"../Tasks_Rewards/DeleteItem"
@onready var trade_offer_button = $"../Tasks_Rewards/TradeOfferButton"
@onready var history_button = $"../Tasks_Rewards/HistoryButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_history_button_pressed():
	if visible: 
		visible = false
		history_button.text = "  See Your History "
	else:
		visible = true
		history_button.text = "  Back to Menu "
		
	add_more_items.visible = !visible
	delete_item.visible = !visible
	trade_offer_button.visible = !visible
		
	reset_list()
	
	pass # Replace with function body.


func _on_reset_history_button_pressed():
	SaveLoad.reset_data()
	SaveLoad.save_game()
	reset_list()
	pass # Replace with function body.

func reset_list():
	items.clear()
	var history:Array = SaveLoad.get_data("completed_tasks")
	for item in history:
		items.add_item(item)
