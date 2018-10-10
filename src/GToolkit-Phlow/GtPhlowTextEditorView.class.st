Class {
	#name : #GtPhlowTextEditorView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'textBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowTextEditorView >> asElementDo: aBlock [
	| editor element text |
	text := self textBuilder value asRopedText.
	editor := BrTextEditor new.
	editor text: text.
	element := BrEditorElement new.
	element editor: editor.
	element constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
	element phlow beView; entity: self.
	^ aBlock value: element
]

{ #category : #accessing }
GtPhlowTextEditorView >> text: anObject [
	textBuilder := anObject
]

{ #category : #accessing }
GtPhlowTextEditorView >> textBuilder [
	^ textBuilder
]
