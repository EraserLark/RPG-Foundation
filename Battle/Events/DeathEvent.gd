extends Event
class_name Death_Event

var deathEQ:= EventQueue.new()
var deadEntity: Entity
var battleManager

func _init(eManager, entity, bm):
	super(eManager)
	deadEntity = entity
	battleManager = bm
	deathEQ.queueEmpty.connect(resumeEvent)

func runEvent():
	var deathAnim = AnimationEvent.new(deathEQ, deadEntity.actor.animPlayer, "Death")
	deathEQ.queue.push_front(deathAnim)
	
	deathEQ.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	deathEQ.queueEmpty.disconnect(resumeEvent)
	deadEntity.entityDead()
	
	var someAlive = deadEntity.checkRoster()
	if(!someAlive):
		battleManager.battleState.battleEQ.currentEvent.battleOver()
	
	eventManager.popQueue()
