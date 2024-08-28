extends Event
class_name Death_Event

var deathEQ: EventQueue
var deadEntity: Entity
var battleManager

func _init(sStack: StateStack, eManager: EventQueue, entity, bm):
	super(eManager)
	deathEQ = EventQueue.new(sStack)
	deadEntity = entity
	battleManager = bm

func runEvent():
	var deathAnim = AnimationEvent.new(deathEQ, deadEntity.actor.animPlayer, "Death")
	deathEQ.queue.push_front(deathAnim)
	
	deathEQ.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	deadEntity.entityDead()
	
	var someAlive = deadEntity.checkRoster()
	if(!someAlive):
		battleManager.battleState.battlePM.actionPhase.battleOver()
	
	eventManager.popQueue()
