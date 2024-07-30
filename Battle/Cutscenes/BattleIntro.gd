extends Cutscene_State
class_name BattleIntro

func _init(sStack, cm, bm):
	super(sStack, cm, bm)

func enter(_msg := {}):
	var fadeIn = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FadeIn")
	cutsceneEQ.addEvent(fadeIn)
	
	var enemiesEntering = EnemyEnter.new(cutsceneEQ, battleManager.enemyEntities)
	cutsceneEQ.addEvent(enemiesEntering)
	
	#var introMessage = Textbox_State.TB_Event.new(cutsceneEQ, StateStack, battleManager.battleUI.textbox, "Snowbros are ready to tussle!")
	Textbox_State.createEvent(cutsceneEQ, StateStack, ["[b]Snowbros[/b] are ready to tussle!", "Line 2!"], battleManager.battleUI.tbContainer)
	
	cutsceneEQ.popQueue()

func exit():
	super()
