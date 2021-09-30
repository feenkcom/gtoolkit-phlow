Class {
	#name : #GtPhlowTextView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'textBuilder'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #converting }
GtPhlowTextView >> asElementDo: aBlock [
	| aBrickEditor aText |

	aBrickEditor := self elementClass new beReadOnlyWithSelection.

	aText := self 
		textFor: aBrickEditor
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].

	aBrickEditor 
		aptitude: BrGlamorousEditorAptitude;
		enqueueTask: (BlTaskAction new action: [
			aBrickEditor text: aText ]).

	aBrickEditor
		matchParent;
		padding: (BlInsets all: 10).

	self beViewElement: aBrickEditor.

	^ aBlock value: aBrickEditor
]

{ #category : #converting }
GtPhlowTextView >> elementClass [
	^ BrEditor
]

{ #category : #initialization }
GtPhlowTextView >> initialize [
	super initialize.
]

{ #category : #testing }
GtPhlowTextView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #accessing }
GtPhlowTextView >> text: anObject [
	textBuilder := anObject
]

{ #category : #accessing }
GtPhlowTextView >> textBuilder [
	^ textBuilder
]

{ #category : #updating }
GtPhlowTextView >> textFor: aBrickEditor onExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ (self textBuilder glamourValueWithArgs: { aBrickEditor }) asRopedText ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #updating }
GtPhlowTextView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| aText |
		aText := self
			textFor: aCurrentElement
			onExceptionErrorElement: [ :anErrorElement | 
				^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self enqueueAction: [ aCurrentElement text: aText ] in: aCurrentElement ]
]
