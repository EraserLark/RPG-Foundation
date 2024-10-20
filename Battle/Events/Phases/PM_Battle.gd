extends GameState_PhaseManager
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
	startPhase = GameState_StartPhase.new(self, bm)
	promptPhase = GameState_PromptPhase.new(self)
	actionPhase = GameState_ActionPhase.new(self, bm)
	finishPhase = GameState_FinishPhase.new(self, bm)
	
	battleManager.promptPhase = self.promptPhase
	battleManager.actionPhase = self.actionPhase
	
	currentPhase = startPhase
	currentEnumPhase = bPhases.START

func determineNextPhase():
	match currentEnumPhase:
		bPhases.START:
			currentEnumPhase = bPhases.PROMPT
			
		bPhases.PROMPT:
			currentEnumPhase = bPhases.ACTION
			
		bPhases.ACTION:
			#if(!battleManager.battleRoster.checkPlayersAlive() || battleManager.enemyEntities.size() <= 0):
			if(battleManager.battleIsOver):
				currentEnumPhase = bPhases.FINISH
			else:
				currentEnumPhase = bPhases.PROMPT
				
		bPhases.FINISH:
			finishManager()
			return
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
			var tween = create_tween()
			tween.tween_property(battleManager.battleStage.music, "volume_db", -20, 1)
			tween.finished.connect(checkWhenTweenFin)
			tween.play()
			#battleManager.battleStage.music.volume_db = -10
			#battleManager.battleStage.music.get_stream_playback().switch_to_clip_by_name("Battle Theme 1 Prompt")
		bPhases.ACTION:
			nextPhase = actionPhase
			var tween = create_tween()
			tween.tween_property(battleManager.battleStage.music, "volume_db", 0, 1)
			tween.finished.connect(checkWhenTweenFin)
			tween.play()
			#battleManager.battleStage.music.volume_db = 0
			#battleManager.battleStage.music.get_stream_playback().switch_to_clip_by_name("Battle Theme 1 Full")
		bPhases.FINISH:
			nextPhase = finishPhase
	currentPhase = nextPhase
	
	runCurrentPhase()

func checkWhenTweenFin():
	print_rich("[color=blue]Tween Fin[/color]")

func runCurrentPhase():
	super()

func resumeCurrentPhase():
	super()

func phaseFinished():
	super()

func finishManager():
	super()
