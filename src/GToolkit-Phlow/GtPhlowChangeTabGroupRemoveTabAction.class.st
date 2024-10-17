Class {
	#name : #GtPhlowChangeTabGroupRemoveTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'api - actions' }
GtPhlowChangeTabGroupRemoveTabAction >> actOn: aChangeContext [
	self tabGroup ifNil: [ ^ self ].
	self compositeView ifNil: [ ^ self ].

	BlTaskAction
		enqueueElement: self tabGroup
		action: [ self removeOn: aChangeContext ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> compositeView [
	^ self tabGroup phlow entity
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupRemoveTabAction >> removeOn: aChangeContext [
	"Must be called from a UI process"
	
	| aMethodDefinition |
	aMethodDefinition := aChangeContext affectedMethodDefinition.
	self tabGroup viewModel tabs
		detect: [ :eachTabModel | 
			| isDetected |
			isDetected := false.
			eachTabModel widgetDo: [ :aWidget | 
					isDetected := aWidget phlow definingMethod = aMethodDefinition ].
			isDetected ]
		ifFound: [ :aTabModel | self tabGroup viewModel removeTab: aTabModel ]
		ifNone: [  "do nothing" ].
	self compositeView views
		detect: [ :eachView | eachView definingMethod = aMethodDefinition ]
		ifFound: [ :aView | self compositeView views remove: aView ifAbsent: [  "ignore" ] ]
		ifNone: [  "do nothing" ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup: anObject [
	tabGroup := anObject
]
