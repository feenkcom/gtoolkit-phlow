Class {
	#name : #GtPhlowTextEditorView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'textBuilder',
		'look'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowTextEditorView >> asElementDo: aBlock [
	| brickEditor text |
	brickEditor := BrEditor new.
	text := (self textBuilder glamourValueWithArgs: { brickEditor }) asRopedText.
	brickEditor 
		look: look;
		text: text.
	brickEditor constraintsDo: [ :c | 
		c vertical matchParent. 
		c horizontal matchParent.
		c padding: (BlInsets all: 10) ].
	brickEditor phlow beView; entity: self.
	^ aBlock value: brickEditor
]

{ #category : #accessing }
GtPhlowTextEditorView >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ look attributesBuilder
]

{ #category : #initialization }
GtPhlowTextEditorView >> initialize [
	super initialize.
	look := BrGlamorousRegularEditorLook new
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
GtPhlowTextEditorView >> text: anObject [
	textBuilder := anObject
]

{ #category : #accessing }
GtPhlowTextEditorView >> textBuilder [
	^ textBuilder
]
