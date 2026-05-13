Class {
	#name : #GtPhlowChangeBasicActionExecutor,
	#superclass : #GtPhlowChangeActionExecutor,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - execution' }
GtPhlowChangeBasicActionExecutor >> submit: aChangeAction context: aChangeContext [
	"This method must be called in a UI process"
	| anUpdateAction |
	anUpdateAction := aChangeAction prepareOn: aChangeContext.
	anUpdateAction execute
]
