extends Node
class_name OverworldManager

@onready var ui:= $CanvasLayer/OW_UI
@onready var world:= $World

func _ready():
	world.get_node("CastList").get_child(0).initialize(self)
