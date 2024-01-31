Class {
	#name : #GtPhlowTool,
	#superclass : #GtPhlowAbstractTool,
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #accessing }
GtPhlowTool class >> default [
	"Default tools must handle #object: messages"
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

{ #category : #converting }
GtPhlowTool >> asElement [
	<return: #BlElement>
	^ self asElementDo: [ :anElement | anElement ]
]

{ #category : #converting }
GtPhlowTool >> asToolElementDo: aOneArgBlock [
	^ self asElementDo: [ :anElement |
		anElement phlow 
			beTool;
			entity: self.
		aOneArgBlock cull: anElement ]
]
