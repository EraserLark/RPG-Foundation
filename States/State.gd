#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends Node
class_name State

var stateStack = null

var interrupted := false
var interruptorClass

var localRosterNum: int
var localDeviceNum: int

func _init(sStack: StateStack):
	stateStack = sStack
	localRosterNum = stateStack.playerEntity.rosterNumber
	localDeviceNum = stateStack.playerEntity.deviceNumber

func handleInput(_event: InputEvent):
	pass

func enter(_msg:= {}):
	pass

func update(_delta: float):
	pass

func physicsUpdate(_delta: float):
	pass

func interruptState(interruptor):
	interrupted = true
	interruptorClass = interruptor

func resumeState():
	pass

func exit():
	stateStack.removeState()

func changeRosterNum(newNum: int):
	localRosterNum = newNum

func changeDeviceNum(newNum: int):
	localDeviceNum = newNum

class EventClass:
	pass
