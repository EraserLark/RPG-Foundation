extends PhaseManager
class_name PM_Battle

var battleManager: BattleManager
enum bPhases {START, PROMPT, ACTION, FINISH}
var currentEnumPhase

var startPhase
var promptPhase
var actionPhase
var finishPhase

func _init(bm):
	battleManager = bm
	startPhase = Start_Phase.new(self, bm)
	promptPhase = Prompt_Phase.new(self, bm)
	actionPhase = Action_Phase.new(self, bm)
	finishPhase = Finish_Phase.new(self, bm)
	
	battleManager.promptPhase = self.promptPhase
	battleManager.actionPhase = self.actionPhase

func determineNextPhase():
	match currentEnumPhase:
		bPhases.START:
			currentEnumPhase = bPhases.PROMPT
			
		bPhases.PROMPT:
			currentEnumPhase = bPhases.ACTION
			
		bPhases.ACTION:
			if(battleManager.playerEntities.size() <= 0 || battleManager.enemyEntities.size() <= 0):
				currentEnumPhase = bPhases.FINISH
			else:
				currentEnumPhase = bPhases.PROMPT
				
		bPhases.FINISH:
			finishManager()
		_:
			currentEnumPhase = bPhases.START
	
	setNextPhase()

func setNextPhase():
	var nextPhase
	match currentEnumPhase:
		bPhases.START:
			nextPhase = startPhase
		bPhases.PROMPT:
			nextPhase = promptPhase
		bPhases.ACTION:
			nextPhase = actionPhase
		bPhases.FINISH:
			nextPhase = finishPhase
	currentPhase = nextPhase
	
	runCurrentPhase()

func runCurrentPhase():
	super()

func resumeCurrentPhase():
	super()

func phaseFinished():
	super()

func finishManager():
	super()
