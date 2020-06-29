Class {
	#name : #GtPhlowAbstractTool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Tools'
}

{ #category : #testing }
GtPhlowAbstractTool class >> isAbstract [
	^ self name = #GtPhlowAbstractTool 
]

{ #category : #'api - converting' }
GtPhlowAbstractTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	self subclassResponsibility
]

{ #category : #'gt-extension' }
GtPhlowAbstractTool >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			| aContainer |
			aContainer := BrFrame new
				matchParent.
			self asElementDo: [ :anElement | aContainer addChild: anElement ].
			aContainer ]
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> name [
	"Return a tool name"
	<return: #String or: #BlRope>
	^ self className
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> object [
	"compatibility method for ${GLMBlocObjectToSelect}$"
	^ self
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> object: anObject [
	"defaults tools must implement this message"
]
