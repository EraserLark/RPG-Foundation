extends PhaseManager
class_name PM_Battle

func _init():
	pass

func determineNextPhase():
	pass

func runCurrentPhase():
	if(currentPhase != null):
		currentPhase.runPhase()
	else:
		determineNextPhase()

func resumeCurrentPhase():
	currentPhase.resumePhase()

func phaseFinished(p: Phase):
	#Run clean function in phase
	StateStack.resumeCurrentState()

func finishManager():
	managerFinished = true

#func popQueue():
	#if(!queue.is_empty()):
		#currentPhase = queue.pop_front()
		#currentPhase.runPhase()
	#else:
		#currentPhase = null
		#StateStack.resumeCurrentState()
