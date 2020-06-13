Class {
	#name : #GtPhlowPannableViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #decorating }
GtPhlowPannableViewExamples >> pannable [
	<gtExample>
	| element pannableView |
	pannableView := GtPhlowPannableView new
		title: 'Pannable';
		stencil: [ BlTextElement new text: 'Pannable' asRopedText ].
	pannableView asElementDo: [ :e | element := e ].
	self assert: element notNil.
	self assert: (element isKindOf: BlPannableElement).
	self assert: pannableView actions size = 4.
	^ pannableView
]

{ #category : #'examples - updating' }
GtPhlowPannableViewExamples >> phlowView [
	<gtExample>
	^ self pannable
]
