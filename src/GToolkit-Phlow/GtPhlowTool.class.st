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
GtPhlowTool >> asPagerPageElementDo: aOneArgBlock [
	^ self asElementDo: [ :anElement |
		"This logic should be updated later on to wrap the content element 
		within a dedicated tool element. That element will be the tool, and
		anElement will become the tool content. Right now we can however mark
		the return element as both the tool and the tool content."
		anElement phlow 
			beTool;
			beToolContent;
			entity: self.
		aOneArgBlock cull: anElement ]
]
