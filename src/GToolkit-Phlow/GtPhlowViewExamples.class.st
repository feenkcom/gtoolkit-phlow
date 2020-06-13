Class {
	#name : #GtPhlowViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #asserting }
GtPhlowViewExamples >> assertErrorElement: anElement inView: aView [
	self assert: anElement class equals: BrFrame.
	self assert: anElement childrenCount equals: 1.
	self assert: anElement phlow isView.
	self assert: anElement phlow entity equals: aView.
]

{ #category : #asserting }
GtPhlowViewExamples >> assertViewElement: anElement ofClass: aClass inView: aView [
	self assert: anElement class equals: aClass.
	self assert: anElement phlow isView.
	self assert: anElement phlow entity equals: aView
]

{ #category : #'examples - basic elements' }
GtPhlowViewExamples >> container [
	<gtExample>
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 5) ]
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> phlowView [
	<return: #GtPhlowView>
	^ self subclassResponsibility
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> phlowViews [
	<gtExample>
	| theExampleClasses thePhlowViews |
	theExampleClasses := self class allSubclasses reject: #isAbstract.
	thePhlowViews := theExampleClasses collect: [ :eachClass | eachClass new phlowView ].
	self assert: thePhlowViews isNotEmpty.
	thePhlowViews do: [ :eachPhlowView | 
		self assert: (eachPhlowView isKindOf: GtPhlowProtoView) ].
	^ thePhlowViews
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> updateAgainstAllViews [
	<gtExample>
	| aPhlowView thePhlowViews |
	aPhlowView := self phlowView.
	thePhlowViews := self phlowViews.
	thePhlowViews do: [ :eachPhlowView | 
		self updatePhlowView: aPhlowView to: eachPhlowView ].
	^ aPhlowView
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> updateAllAgainstAllViews [
	<gtExample>
	<noTest>
	| theCurrentPhlowViews theNewPhlowViews |
	theCurrentPhlowViews := self phlowViews.
	theNewPhlowViews := self phlowViews.
	theCurrentPhlowViews do: [ :aCurrentView |
		theNewPhlowViews do: [ :aNewPhlowView | 
			self updatePhlowView: aCurrentView to: aNewPhlowView ] ].
	^ theCurrentPhlowViews
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> updatePhlowView: aCurrentPhlowView to: aNewPhlowView [
	<gtExample>
	| aCurrentElement aContainer |
	aCurrentElement := aCurrentPhlowView asElementDo: [ :theElement | theElement ].

	self assert: (aCurrentElement isKindOf: BlElement).	
	self assert: aCurrentElement phlow entity equals: aCurrentPhlowView.
	
	aContainer := self container.
	aContainer addChild: aCurrentElement.
	aCurrentElement phlow entity: aNewPhlowView.
	BlUseAsyncFeatures disableDuring: [
		aCurrentElement phlow syncUpdate ].
	
	aCurrentPhlowView class = aNewPhlowView class ifTrue: [ ^ aContainer ].
	
	self assert: (aContainer childAt: 1) ~= aCurrentElement.
	^ aContainer
]
