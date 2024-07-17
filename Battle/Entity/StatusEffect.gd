extends Node #extends Entity
class_name StatusEffect

var battleManager
var statusRoster
var status_name : String
var turnCount : int
var currentCount := 0
var statusAction : Action
var target : Entity

func _init(bm, sn, tc, tg, sr):
	battleManager = bm
	status_name = sn
	turnCount = tc
	target = tg
	statusRoster = sr

func runStatus():
	return statusAction

func checkStatusCount():
	if(currentCount >= turnCount):
		endStatus()

func addToEventQueue(_eq):
	pass

func endStatus():
	#Recovery animation + sfx
	statusRoster.erase(self)
	battleManager.battleState.battleEQ.currentEvent.unresolvedStatuses.erase(self)
	queue_free()