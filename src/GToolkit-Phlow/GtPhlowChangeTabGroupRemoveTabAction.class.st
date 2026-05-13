Class {
	#name : #GtPhlowChangeTabGroupRemoveTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> compositeView [
	^ self tabGroup phlow entity
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupRemoveTabAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	^ GtPhlowChangeUpdateAction new
		changeAction: self;
		changeContext: aChangeContext
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupRemoveTabAction >> tabGroup: anObject [
	tabGroup := anObject
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupRemoveTabAction >> update: aResult on: aChangeContext [
	"Must be called in a UI process."

	| aMethodDefinition |
	aMethodDefinition := aChangeContext affectedMethodDefinition.
	self tabGroup viewModel tabs
		detect: [ :eachTabModel | 
			| isDetected |
			isDetected := false.
			eachTabModel
				widgetDo: [ :aWidget | isDetected := aWidget phlow definingMethod = aMethodDefinition ].
			isDetected ]
		ifFound: [ :aTabModel | 
			aChangeContext isTabSelected: aTabModel isSelected.
			self tabGroup viewModel removeTab: aTabModel ]
		ifNone: [  "do nothing" ].
	self compositeView views
		detect: [ :eachView | eachView definingMethod = aMethodDefinition ]
		ifFound: [ :aView | self compositeView views remove: aView ifAbsent: [  "ignore" ] ]
		ifNone: [  "do nothing" ]
]
