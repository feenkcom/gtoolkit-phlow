Class {
	#name : #GtPhlowTextEditorView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'textBuilder',
		'look',
		'styler'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowTextEditorView >> asElementDo: aBlock [
	| aBrickEditor aText aContainer |
	aBrickEditor := BrEditor new.
	aText := self 
		textFor: aBrickEditor 
		onExceptionErrorElement: [ :anErrorElement | 
			^ aBlock value: anErrorElement ].
	aBrickEditor 
		look: look;
		styler: styler;
		text: aText.
	aBrickEditor constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.
		c padding: (BlInsets all: 10) ].
	aContainer := self newSceneInformingElement.
	aContainer addChild: aBrickEditor.
	^ aBlock value: aContainer
]

{ #category : #accessing }
GtPhlowTextEditorView >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ look attributesBuilder
]

{ #category : #initialization }
GtPhlowTextEditorView >> initialize [
	super initialize.
	look := BrGlamorousRegularEditorLook new.
	styler := BlTextNullStyler new.
]

{ #category : #accessing }
GtPhlowTextEditorView >> look [
	^ look
]

{ #category : #accessing }
GtPhlowTextEditorView >> look: aLook [
	look := aLook
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
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| aText anEditor |
		anEditor := aCurrentElement children first.
		aText := self
			textFor: anEditor
			onExceptionErrorElement: [ :anErrorElement | 
				^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self enqueueAction: [ anEditor text: aText ] in: anEditor ].
]

{ #category : #accessing }
GtPhlowTextEditorView >> withoutLook [
	look := BrGlamorousEditorLook new
]
