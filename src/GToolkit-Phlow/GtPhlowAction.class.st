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
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
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
GtPhlowAction >> dropdown [
	^ GtPhlowDropdownAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowAction >> explicit [
	^ GtPhlowExplicitAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #'gt-extension' }
GtPhlowAction >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElementDo: [ :x | x ] withElement: nil ]
]

{ #category : #accessing }
GtPhlowAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
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
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]
