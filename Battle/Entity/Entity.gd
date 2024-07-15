extends Node
class_name Entity

var battleManager : BattleManager
var actor
var statusEffects : Array[StatusEffect]

func initialize(bm : BattleManager):
	battleManager = bm

func getClassInstance():
	return self

func applyStatus(statusEffect, statusRoster):
	var newStatus = statusEffect.new(battleManager, self, statusRoster)
	statusEffects.append(newStatus)
	statusRoster.append(newStatus)
	
	battleManager.battleState.battleEQ.currentEvent.unresolvedStatuses.append(newStatus)
	#print("Stall")
