extends GameState_Cutscene
class_name BattleIntro

func _init(cm, sm):
	super(cm, sm)

func stackEnter(_msg := {}):
	var fadeIn = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FadeIn")
	cutsceneEQ.addEvent(fadeIn)
	
	var enemiesEntering = EnemyEnter.new(cutsceneEQ, stageManager.enemyEntities)
	cutsceneEQ.addEvent(enemiesEntering)
	
	#var introMessage = Textbox_State.TB_Event.new(cutsceneEQ, StateStack, battleManager.battleUI.textbox, "Snowbros are ready to tussle!")
	#Textbox_State.createEvent(cutsceneEQ, GameStateStack.stack, ["[b]Snowbros[/b] are ready to tussle!", "Line 2!"], battleManager.battleUI.tbContainer)
	
	cutsceneEQ.popQueue()

func stackExit():
	super()
