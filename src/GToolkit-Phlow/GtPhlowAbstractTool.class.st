Class {
	#name : #GtPhlowAbstractTool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Tool - Core'
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

{ #category : #'api - converting' }
GtPhlowAbstractTool >> asTabDo: aBlock [
	| aTab |
	aTab := BrTab new
		look: self tabLook;
		label: self name;
		icon: self icon;
		stencil: [ self asTabElement ].
	aBlock cull: aTab cull: self.
]

{ #category : #'private - converting' }
GtPhlowAbstractTool >> asTabElement [
	"Return a tool element that is going to be used as a part of ${class:GtPhlowCompositeTool}$"
	<return: #BlElement>
	^ self asElementDo: [ :anElement | anElement ]
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
				matchParent;
				padding: (BlInsets all: 20).
			self asElementDo: [ :anElement | 
				aContainer addChild: anElement ].
			aContainer ]
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> icon [
	"Return a tool icon"
	<return: #BlElement>
	^ BrGlamorousVectorIcons inspect 
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> name [
	"Return a tool name"
	<return: #String or: #BlText>
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

{ #category : #'private - accessing' }
GtPhlowAbstractTool >> tabLook [
	"Return a look to display tab tool"
	^ BrGlamorousTabSwitcherWithLabelLook
]
