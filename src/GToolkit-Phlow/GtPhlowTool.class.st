Class {
	#name : #GtPhlowTool,
	#superclass : #GtPhlowProtoTool,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #accessing }
GtPhlowTool class >> default [
	| aClassOrNil |
	aClassOrNil := self allSubclasses detectMin: #priority.
	^ aClassOrNil ifNotNil: [ aClassOrNil new ] ifNil: [ self null ].
]

{ #category : #testing }
GtPhlowTool class >> isAbstract [
	^ self name = #GtPhlowTool 
]

{ #category : #accessing }
GtPhlowTool class >> null [
	^ GtPhlowNullTool default
]

{ #category : #accessing }
GtPhlowTool class >> priority [
	<return: #Number>
	^ 50
]
