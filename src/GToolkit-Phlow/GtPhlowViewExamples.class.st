Class {
	#name : #GtPhlowViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #testing }
GtPhlowViewExamples class >> isAbstract [
	^ self name = #GtPhlowViewExamples
]

{ #category : #asserting }
GtPhlowViewExamples >> assertCommonDefaultView: aView [
	self assert: aView title isNotNil.
	self assert: aView priority isNumber.
	self assert: aView definingMethod isNotNil.
	self assert: aView autoUpdates isNotNil.
	self assert: aView actions isCollection.
	self assert: aView buildContext isNotNil.
	self assert: aView isAsyncEnabled.
]

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

{ #category : #'examples - element' }
GtPhlowViewExamples >> container [
	<gtExample>
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 5) ]
]

{ #category : #'examples - element' }
GtPhlowViewExamples >> element [
	<gtExample>
	| aView anElement |
	self class isAbstract ifTrue: [ ^ self ].

	aView := self phlowView.
	anElement := aView asElementDo: [ :theElement | theElement ].

	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.

	^ anElement
]

{ #category : #'examples - element' }
GtPhlowViewExamples >> expectedElementClass [
	^ BlElement
]

{ #category : #'examples - element' }
GtPhlowViewExamples >> modifiedElement [
	<gtExample>
	| aView anElement |
	self class isAbstract ifTrue: [ ^ self ].

	aView := self modifiedPhlowView.
	aView asElementDo: [ :theElement | anElement := theElement ].

	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.

	^ anElement
]

{ #category : #'examples - view' }
GtPhlowViewExamples >> modifiedPhlowView [
	<gtExample>
	| aView |
	self class isAbstract ifTrue: [ ^ self ].
	aView := self phlowView.
	aView title: 'an incorrect title'.
	aView priority: 10000.
	aView tooltip: 'an incorrect tooltip'.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowViewExamples >> phlowView [
	<return: #GtPhlowView>
	^ self subclassResponsibility
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> phlowViews [
	<gtExample>
	| theExampleClasses thePhlowViews |
	theExampleClasses := GtPhlowViewExamples allSubclasses reject: #isAbstract.
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
	self class isAbstract ifTrue: [ ^ self ].
	aPhlowView := self phlowView.
	thePhlowViews := self phlowViews.
	thePhlowViews do: [ :eachPhlowView | 
		self updatePhlowView: aPhlowView to: eachPhlowView ].
	^ aPhlowView
]

{ #category : #'examples - updating' }
GtPhlowViewExamples >> updateAllAgainstAllViews [
	<gtExample>
	| theCurrentPhlowViews theNewPhlowViews |
	self class = GtPhlowViewExamples ifFalse: [ ^ self ].
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
	aCurrentElement phlow replaceEntity: aNewPhlowView.
	BlUseAsyncFeatures disableDuring: [
		aCurrentElement phlow syncUpdate ].
	
	aCurrentPhlowView class = aNewPhlowView class ifTrue: [ ^ aContainer ].
	
	self assert: (aContainer childAt: 1) ~= aCurrentElement.
	^ aContainer
]
