extends Event
class_name Action

var sender : Entity
var target : Entity

func _init(eManager, send, targ):
	super(eManager)
	sender = send
	target = targ
