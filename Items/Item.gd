extends Node
class_name Item

var battleManager
var itemAction: Action
var itemName: String

func _init(bm: BattleManager, n: String):
	battleManager = bm
	itemName = n

func setBattleManager(bm: BattleManager):
	battleManager = bm
