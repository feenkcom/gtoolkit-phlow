Class {
	#name : #GtPhlowAction,
	#superclass : #Object,
	#instVars : [
		'category',
		'stencilBuilder',
		'definingMethod'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowAction class >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowAction >> asElementDo: aBlock withElement: aTargetElement [
	| element |
	element := [ stencilBuilder targetElement: aTargetElement. stencilBuilder asElement ] 
		on: Error 
		do: [ :error | 
			error freeze.
			GtPhlowActionWithError new 
				error: error; 
				definingMethod: self definingMethod;
				asElementDo: [ :errorElement | errorElement ] withElement: aTargetElement ].
	self definingMethod ifNotNil: [ 
		element 
			when: BlMouseDownEvent 
			do: [ :event | 
				event modifiers isAlt ifTrue: [
					event consumed: true. 
					element fireEvent: (GtPhlowObjectToSpawn new 
						object: self definingMethod; 
						sourceElement: element) ] ] ].
	^ aBlock value: element.
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

{ #category : #accessing }
GtPhlowAction >> explicit [
	^ GtPhlowAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #initialization }
GtPhlowAction >> initialize [
	super initialize.
	category := #general.
	stencilBuilder := nil.
]

{ #category : #accessing }
GtPhlowAction >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowAction >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder  
]

{ #category : #accessing }
GtPhlowAction >> stencilBuilder [
	^ stencilBuilder
]
