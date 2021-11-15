Class {
	#name : #GtPhlowForwarderViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #accessing }
GtPhlowForwarderViewExamples >> expectedElementClass [
	^ BrFromPromise
]

{ #category : #'examples - composite' }
GtPhlowForwarderViewExamples >> forwardedCompositeView [
	<gtExample>
	| aView aPhlowView |

	aView := self gtCompositeFor: GtPhlowView empty.	
	aPhlowView := aView phlowView wait.
	
	self assert: aView class equals: GtPhlowForwarderView.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size.
	self assert: aPhlowView class equals: GtPhlowCompositeView.
	self assert: aPhlowView autoUpdates size equals: aPhlowView defaultUpdateDefinitions size.
	^ aView
]

{ #category : #'examples - forwarded view' }
GtPhlowForwarderViewExamples >> forwardedIntegerView [
	<gtExample>
	| aView anElement |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:.

	self assert: aView viewObject wait equals: 2.
	
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement phlow entity equals: aView.
	^ aView
]

{ #category : #'examples - forwarded view' }
GtPhlowForwarderViewExamples >> forwardedView [
	<gtExample>
	| aView aPhlowView |
	aView := GtPhlowForwarderView new
		object: [ GtPhlowExplicitViewExamples new ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject wait class equals: GtPhlowExplicitViewExamples.
	self assert: aView actions size equals: 0.

	aPhlowView := aView phlowView wait.

	"Assertions after the forwarded view initialization"
	self assert: aPhlowView notNil.
	self assert: aView phlowView equals: aView phlowView.
	
	aView title: 'Forwarded view'.
	self assert: aView title equals: 'Forwarded view'.

	self assert: aView actions size equals: 0.
	self assert: aView allActions size equals: 1.
	self assert: aView actions size equals: 0.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BrFromPromise).
	^ aView
]

{ #category : #'examples - forwarded view' }
GtPhlowForwarderViewExamples >> forwardedViewWithObjectCreationError [
	<gtExample>
	| aView aPhlowView |
	aView := GtPhlowForwarderView new
		object: [ Error signal. self ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject class equals: AsyncRejectedPromise.
	self assert: aView actions size equals: 0.

	aPhlowView := aView phlowView wait.

	"Assertions after the forwarded view initialization"
	self assert: aPhlowView notNil.
	self assert: aPhlowView class equals: GtPhlowViewWithError.
	self assert: aPhlowView error signalerContext method selector equals: #forwardedViewWithObjectCreationError.
	
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'examples - forwarded view' }
GtPhlowForwarderViewExamples >> forwardedWithUndefinedViewMessage [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ self ];
		view: #gtUndefinedViewMessageFor:.

	self assert: aView viewObject wait equals: self.
	self assert: aView phlowView wait class equals: GtPhlowViewWithError.
	self assert: (aView asElementDo: [ :anElement | anElement ]) class equals: BrFromPromise.
	^ aView
]

{ #category : #'examples - update actions' }
GtPhlowForwarderViewExamples >> forwardedWithUpdateAction [
	<gtExample>
	| aView |
	aView := self gtAutoUpdatingExplicitFor: GtPhlowView empty.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size + 1.
	^ aView
]

{ #category : #'examples - update actions' }
GtPhlowForwarderViewExamples >> forwardedWithUpdateActionElement [
	<gtExample>
	| aView anElement aContainer aNewElement |
	aView := self forwardedWithUpdateAction.
	aContainer := self container.
	anElement := aView asElementDo: [ :theElement | theElement ].
	aContainer addChild: anElement.
	self assert: anElement phlow entity equals: aView.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size + 1.

	BlUseAsyncFeatures disableDuring: [ anElement phlow syncUpdate ].
	self assert: anElement phlow entity equals: aView.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size + 1.
	
	aNewElement := aContainer childAt: 1.
	self assert: aNewElement phlow entity equals: aView phlowView wait.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size + 1.

	^ anElement
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
			action: [ BlUseAsyncFeatures disableDuring: [ anAnnouncer announce: Announcement new ] ]
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
GtPhlowForwarderViewExamples >> gtCompositeFor: aView [
	<gtView>
	^ aView forward 
		title: 'Composite';
		object: [ GtPhlowCompositeViewExamples new ];
		view: #gtPhlowViewWithCollectorFor:;
		actionUpdateButton
]

{ #category : #'gt-extension' }
GtPhlowForwarderViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
GtPhlowForwarderViewExamples >> phlowView [
	<gtExample>
	^ self forwardedView
]
