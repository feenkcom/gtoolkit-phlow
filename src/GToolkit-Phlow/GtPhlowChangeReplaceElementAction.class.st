Class {
	#name : #GtPhlowChangeReplaceElementAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeReplaceElementAction >> element [
	^ element
]

{ #category : #accessing }
GtPhlowChangeReplaceElementAction >> element: anObject [
	element := anObject
]

{ #category : #'api - actions' }
GtPhlowChangeReplaceElementAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	| aNewView anAction anOldView aBuildContext |
	self element ifNil: [ ^ GtPhlowChangeEmptyUpdateAction default ].
	anOldView := self element phlow entity.
	anOldView ifNil: [ ^ GtPhlowChangeEmptyUpdateAction default ].
	aBuildContext := anOldView buildContext.
	aBuildContext isBuildContext ifFalse: [ ^ GtPhlowChangeEmptyUpdateAction default ].
	
	aNewView := GtPhlowView empty
			on: aBuildContext object
			perform: aChangeContext affectedMethodSelector
			withContext: aBuildContext context.
	GtPhlowUtility
		createSafelyElementFor: aNewView
		andDo: [ :aNewElement | 
			anAction := GtPhlowChangeUpdateAction new
					changeAction: self;
					changeContext: aChangeContext;
					preparationResult: (GtPhlowChangeViewAndElementPreparation new
							phlowView: aNewView;
							element: aNewElement) ].
	^ anAction ifNil: [ GtPhlowChangeEmptyUpdateAction default ]
]

{ #category : #'api - actions' }
GtPhlowChangeReplaceElementAction >> update: aResult on: aChangeContext [
	"Must be called in a UI process."

	| aNewView aNewElement aParent |
	aParent := self element parent.
	aParent ifNil: [ ^ self ].
	aNewView := aResult phlowView.
	aNewElement := aResult element.
	aParent replaceChild: self element with: aNewElement
]
