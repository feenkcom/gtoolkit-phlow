Class {
	#name : #GtPhlowDiffView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'as yet unclassified' }
GtPhlowDiffView >> asElementDo: aBlock [
	| anElement |
	self
		assert: [ from notNil ]
		description: [ 'from string needs to be initialize' ].

	self assert: [ to notNil ] description: [ 'to string needs to be initialize' ].

	anElement := self
			performBlock: [ (TextDiffBuilder from: from value to: to value) asElement ]
			onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].

	self beViewElement: anElement.

	^ aBlock value: anElement
]

{ #category : #accessing }
GtPhlowDiffView >> from [
	^ from
]

{ #category : #accessing }
GtPhlowDiffView >> from: anObject [
	from := anObject
]

{ #category : #accessing }
GtPhlowDiffView >> to [
	^ to
]

{ #category : #accessing }
GtPhlowDiffView >> to: anObject [
	to := anObject
]
