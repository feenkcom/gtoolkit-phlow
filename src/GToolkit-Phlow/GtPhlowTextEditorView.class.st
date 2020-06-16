Class {
	#name : #GtPhlowTextEditorView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'textBuilder',
		'look',
		'styler',
		'attributesBuilder'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #converting }
GtPhlowTextEditorView >> asElementDo: aBlock [
	| aBrickEditor aText aNewLook |

	aBrickEditor := self elementClass new.

	aText := self 
		textFor: aBrickEditor 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].
	
	aNewLook := self 
		performBlock: [ self newLook ] 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].

	aBrickEditor 
		look: aNewLook;
		styler: styler;
		text: aText.

	aBrickEditor constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.
		c padding: (BlInsets all: 10) ].

	self beViewElement: aBrickEditor.
	
	^ aBlock value: aBrickEditor
]

{ #category : #accessing }
GtPhlowTextEditorView >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ attributesBuilder
]

{ #category : #converting }
GtPhlowTextEditorView >> elementClass [
	^ BrEditor
]

{ #category : #initialization }
GtPhlowTextEditorView >> initialize [
	super initialize.
	attributesBuilder := BlTextDelegatedAttributesBuilder new.
	look := BrGlamorousRegularEditorLook.
	styler := BlTextNullStyler new.
]

{ #category : #testing }
GtPhlowTextEditorView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #accessing }
GtPhlowTextEditorView >> look [
	^ look
]

{ #category : #accessing }
GtPhlowTextEditorView >> look: aLook [
	look := aLook
]

{ #category : #'instance creation' }
GtPhlowTextEditorView >> newLook [
	| aNewLook |
	aNewLook := look value asLook.
	aNewLook attributesBuilder: self attributesBuilder.
	^ aNewLook
]

{ #category : #accessing }
GtPhlowTextEditorView >> styler: aStyler [
	styler := aStyler
]

{ #category : #accessing }
GtPhlowTextEditorView >> text: anObject [
	textBuilder := anObject
]

{ #category : #accessing }
GtPhlowTextEditorView >> textBuilder [
	^ textBuilder
]

{ #category : #updating }
GtPhlowTextEditorView >> textFor: aBrickEditor onExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ (self textBuilder glamourValueWithArgs: { aBrickEditor }) asRopedText ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #updating }
GtPhlowTextEditorView >> updateContent: aCurrentElement [
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

{ #category : #accessing }
GtPhlowTextEditorView >> withoutLook [
	look := BrGlamorousEditorLook
]
