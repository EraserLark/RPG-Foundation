extends Node
class_name Action

var actionName : String
var sender : Entity
var target : Entity

var eventManager : EventQueue = null

signal actionFinished

func _init(eManager):
	eventManager = eManager

func runAction():
	pass

func finishAction():
	eventManager.popQueue()
