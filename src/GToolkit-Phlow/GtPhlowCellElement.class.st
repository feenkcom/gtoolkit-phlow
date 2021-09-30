"
I am a container for rows and cells in {{gtClass:GtPhlowListView}}.  
I can hold a domain {{gtClass:BlElement}} instance.
If there is an exception, I hide the domain element and display the one that represents the exception.
1. # Example with Domain Element

{{gtExample:GtPhlowCellElementExamples>>#cellElementWithLabel}}
1. # Example with Exception Element

{{gtExample:GtPhlowCellElementExamples>>#cellElementWithException}}
 


"
Class {
	#name : #GtPhlowCellElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #'api - accessing' }
GtPhlowCellElement >> content [
	<return: #BlElement or: nil>
	^ self 
		childNamed: self defaultContentChildName
		ifFound: [ :aCurrentElement | aCurrentElement ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
GtPhlowCellElement >> content: aNewContentElement [
	self 
		assert: [ aNewContentElement isKindOf: BlElement ] 
		description: [ 'Cell content must be an element' ].
	self removeException.
	self 
		childNamed: self defaultContentChildName
		ifFound: [ :aCurrentElement | self 
			replaceChild: aCurrentElement
			with: aNewContentElement
			as: self defaultContentChildName ]
		ifNone: [ self 
			addChild: aNewContentElement 
			at: 1 
			as: self defaultContentChildName ]
]

{ #category : #defaults }
GtPhlowCellElement >> defaultContentChildName [
	^ #content
]

{ #category : #defaults }
GtPhlowCellElement >> defaultExceptionChildName [
	^ #exception
]

{ #category : #accessing }
GtPhlowCellElement >> exception [
	<return: #BlElement or: nil>
	^ self 
		childNamed: self defaultExceptionChildName
		ifFound: [ :aCurrentElement | aCurrentElement ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
GtPhlowCellElement >> exception: aNewExceptionElement [
	self 
		assert: [ aNewExceptionElement isKindOf: BlElement ] 
		description: [ 'Cell exception must be an element' ].
	self hideContent.
	self 
		childNamed: self defaultExceptionChildName
		ifFound: [ :aCurrentElement | self 
			replaceChild: aCurrentElement
			with: aCurrentElement
			as: self defaultExceptionChildName ]
		ifNone: [ self 
			addChild: aNewExceptionElement
			as: self defaultExceptionChildName ]
]

{ #category : #'private - hooks' }
GtPhlowCellElement >> hideContent [
	self content ifNotNil: [ :anElement | anElement visibility: BlVisibility gone ]
]

{ #category : #accessing }
GtPhlowCellElement >> initialize [
	super initialize.

	self layout: BlLinearLayout horizontal alignCenterLeft.
	self hMatchParent.
	self vFitContent.
]

{ #category : #'api - visibility' }
GtPhlowCellElement >> removeException [
	self exception ifNotNil: [ :anElement | anElement removeFromParent ]
]

{ #category : #'api - visibility' }
GtPhlowCellElement >> showContent [
	self content ifNotNil: [ :anElement | anElement visibility: BlVisibility visible ]
]
