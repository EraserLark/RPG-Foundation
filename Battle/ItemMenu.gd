extends PanelContainer

@onready var itemList := $ItemList

signal closeItemMenu

func _on_item_list_item_activated(index):
	#Whatever comes next for starting the attack. Selecting target.
	emit_signal("closeItemMenu")
