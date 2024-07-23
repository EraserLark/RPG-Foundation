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
	target.statusEffects.erase(self)
	statusRoster.erase(self)
	battleManager.battleState.battlePM.actionPhase.unresolvedStatuses.erase(self)
	battleManager.battleState.battlePM.actionPhase.actionEQ.queue.erase(statusAction)
	queue_free()
