extends Action
class_name TB_Action

var message := ""
var battleUI

func _init(eManager, UI, tbMessage):
	super(eManager)
	battleUI = UI
	message = tbMessage

func runAction():
	battleUI.textbox.boxFin.connect(finishAction)
	battleUI.textboxNewMessage(message)
