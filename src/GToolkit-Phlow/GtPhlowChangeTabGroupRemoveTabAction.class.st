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
	| aCompositeView |
	self tabGroup ifNil: [ ^ self ].
	aCompositeView := self compositeView ifNil: [ ^ self ].

	BlTaskAction
		enqueueElement: self tabGroup
		action: [ self basicRemoveOn: aChangeContext ]
]

{ #category : #private }
GtPhlowChangeTabGroupRemoveTabAction >> basicRemoveOn: aChangeContext [
	| aMethodDefinition |
	aMethodDefinition := aChangeContext affectedMethodDefinition.
	self tabGroup viewModel tabs
		detect: [ :eachTabModel | 
			eachTabModel widget
				ifNotNil: [ :aWidget | 
					aWidget phlow definingMethod = aMethodDefinition ]
				ifNil: [ false ] ]
		ifFound: [ :aTabModel | self tabGroup viewModel removeTab: aTabModel ]
		ifNone: [  "do nothing" ].
	self compositeView views
		detect: [ :eachView | eachView definingMethod = aMethodDefinition ]
		ifFound: [ :aView | self compositeView views remove: aView ifAbsent: [  "ignore" ] ]
		ifNone: [  "do nothing" ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> compositeView [
	^ self tabGroup phlow entity
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup: anObject [
	tabGroup := anObject
]
