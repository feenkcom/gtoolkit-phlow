Class {
	#name : #GtPhlowValuableTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'name',
		'valuable'
	],
	#category : 'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - converting' }
GtPhlowValuableTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| anElement |
	anElement := self valuable value asElement.
	self 
		assert: [ anElement isKindOf: BlElement ] 
		description: [ 'Valuable tool must create an element on #asElementDo: call' ].
	^ aOneArgBlock cull: anElement cull: self
]

{ #category : #initialization }
GtPhlowValuableTool >> initialize [
	super initialize.
	valuable := [ BrFrame new matchParent ].
	name := 'Valuable'.
]

{ #category : #accessing }
GtPhlowValuableTool >> name [
	^ name
]

{ #category : #accessing }
GtPhlowValuableTool >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtPhlowValuableTool >> valuable [
	^ valuable
]

{ #category : #accessing }
GtPhlowValuableTool >> valuable: anObject [
	valuable := anObject
]
