Class {
	#name : #GtPhlowAction,
	#superclass : #Object,
	#instVars : [
		'category',
		'definingMethod'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowAction class >> explicit [
	^ GtPhlowExplicitAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowAction class >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #converting }
GtPhlowAction >> asElementDo: aBlock withElement: aTargetElement [
	"Return an element that represents the action in Bloc space, e.g., a button"
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #converting }
GtPhlowAction >> attachShowDefinitionEventHandler: element [
	self definingMethod
		ifNotNil: [ element
				when: BlMouseDownEvent
				do: [ :event | 
					event modifiers isAlt
						ifTrue: [ event consumed: true.
							element
								fireEvent:
									(GtPhlowObjectToSpawn new
										object: self definingMethod;
										sourceElement: element) ] ] ]
]

{ #category : #decorating }
GtPhlowAction >> button [
	^ GtPhlowButtonAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowAction >> category [
	^ category
]

{ #category : #accessing }
GtPhlowAction >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GtPhlowAction >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowAction >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #decorating }
GtPhlowAction >> explicit [
	^ GtPhlowExplicitAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #initialization }
GtPhlowAction >> initialize [
	super initialize.
	category := #general.
]

{ #category : #decorating }
GtPhlowAction >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowAction >> toggle [
	^ GtPhlowToggleAction new
		definingMethod: thisContext stack second method asRingDefinition
]
