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
