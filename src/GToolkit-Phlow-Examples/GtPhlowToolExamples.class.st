Class {
	#name : #GtPhlowToolExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #'examples - tools' }
GtPhlowToolExamples >> basicCompositeTool [
	<gtExample>
	| aTool anElement |
	aTool := GtPhlowCompositeTool new.
	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name isString.
	^ aTool
]

{ #category : #'examples - tools' }
GtPhlowToolExamples >> basicExplicitTool [
	<gtExample>
	| aTool anElement |
	aTool := GtPhlowExplicitTool new.
	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name isString.
	^ aTool
]

{ #category : #'examples - spaces' }
GtPhlowToolExamples >> closeSpace: aSpace with: anElement [
	<gtExample>
	"Remove an element from the space and close the space"
	anElement removeFromParent.
	aSpace close.
]

{ #category : #'examples - support' }
GtPhlowToolExamples >> defaultBackgroundColor [
	<gtExample>
	^ Color yellow alpha: 0.3
]

{ #category : #'examples - elements' }
GtPhlowToolExamples >> labelWithText: aString [
	<gtExample>
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		fitContent;
		alignCenter;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		text: aString asString
]

{ #category : #'examples - spaces' }
GtPhlowToolExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Phlow Tool Volume Examples'.
	aSpace extent: 600@400.
	aSpace withCommonSettings.
	^ aSpace
]

{ #category : #'examples - spaces' }
GtPhlowToolExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace root addChild: aBlElement.
	^ aSpace
]
