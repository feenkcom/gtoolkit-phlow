Class {
	#name : #GtPhlowChangeUpdateLabelledElementLabelAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeUpdateLabelledElementLabelAction >> element [
	^ element
]

{ #category : #accessing }
GtPhlowChangeUpdateLabelledElementLabelAction >> element: anObject [
	element := anObject
]

{ #category : #'api - actions' }
GtPhlowChangeUpdateLabelledElementLabelAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	| aView aTitle |
	self element ifNil: [ ^ GtPhlowChangeEmptyUpdateAction default ].
	aView := self element phlow entity.
	aView ifNil: [ ^ GtPhlowChangeEmptyUpdateAction default ].
	(aView isKindOf: GtPhlowLabelledView) 
		ifFalse: [ ^ GtPhlowChangeEmptyUpdateAction default ].

	aTitle := aView newLabel.
	aTitle ifNil: [ ^ GtPhlowChangeEmptyUpdateAction default ].

	^ GtPhlowChangeUpdateAction new
		changeAction: self;
		changeContext: aChangeContext;
		preparationResult: aTitle
]

{ #category : #'api - actions' }
GtPhlowChangeUpdateLabelledElementLabelAction >> update: aTitle on: aChangeContext [
	"Must be called in a UI process."

	self element viewModel tabs ifNotEmpty: [ :theTabModels | 
		theTabModels anyOne widgetDo: [ :aTab | aTab label: aTitle ] ]
]
