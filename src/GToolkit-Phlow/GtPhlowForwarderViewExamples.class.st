Class {
	#name : #GtPhlowForwarderViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedIntegerView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:.

	self assert: aView viewObject equals: 2.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedTransformedIntegerView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:;
		transformed: #asScrollableElement.

	self assert: aView viewObject equals: 2.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlScrollableElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ GtPhlowExplicitViewExamples new ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject class equals: GtPhlowExplicitViewExamples.
	self assert: aView actions size equals: 0.

	"Assertions after the forwarded view initialization"
	self assert: aView phlowView isNotNil.
	self assert: aView phlowView equals: aView phlowView.
	
	aView title: 'Forwarded view'.
	self assert: aView title equals: 'Forwarded view'.

	self assert: aView actions size equals: 0.
	self assert: aView allActions size equals: 1.
	self assert: aView actions size equals: 1.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedViewWithObjectCreationError [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ Error signal. self ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject class equals: Error.
	self assert: aView actions size equals: 0.

	"Assertions after the forwarded view initialization"
	self assert: aView phlowView isNotNil.
	self assert: aView phlowView class equals: GtPhlowViewWithError.
	self assert: aView phlowView error signalerContext method selector equals: #forwardedViewWithObjectCreationError.
	
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedWithTransformationError [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:;
		transformed: [ :anElement | Error signal. anElement asScrollableElement ].

	self assert: aView viewObject equals: 2.
	self assert: (aView asElementDo: [ :anElement | anElement ]) class equals: BrFrame.
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowForwarderViewExamples >> forwardedWithUndefinedViewMessage [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ self ];
		view: #gtUndefinedViewMessageFor:.

	self assert: aView viewObject equals: self.
	self assert: aView phlowView class equals: GtPhlowViewWithError.
	self assert: (aView asElementDo: [ :anElement | anElement ]) class equals: BrFrame.
	^ aView
]

{ #category : #'gt-extension' }
GtPhlowForwarderViewExamples >> gtAutoUpdatingExplicitFor: aView [
	<gtView>
	| anAnnouncer |
	anAnnouncer := Announcer new.
	^ aView forward 
		title: 'Auto-Updated Explicit View';
		object: [ GtPhlowExplicitViewExamples new ];
		view: #gtBasicFor:;
		updateWhen: Announcement in: [ anAnnouncer ];
		actionButtonIcon: BrGlamorousIcons refresh
			action: [ anAnnouncer announce: Announcement new ]
]

{ #category : #'gt-extension' }
GtPhlowForwarderViewExamples >> gtBasicFor: aView [
	<gtView>
	^ aView forward 
		title: 'Forwarded Explicit View';
		object: [ GtPhlowExplicitViewExamples new ];
		view: #gtBasicFor:
]

{ #category : #'gt-extension' }
GtPhlowForwarderViewExamples >> myself [
	<gtExample>
	^ self
]
