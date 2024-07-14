extends Node
class_name Entity

var battleManager : BattleManager
var actor

func initialize(bm : BattleManager):
	battleManager = bm

func getClassInstance():
	return self
