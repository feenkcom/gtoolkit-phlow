Class {
	#name : #GtPhlowExplicitViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : 'GToolkit-Phlow-Examples - Views'
}

{ #category : #updating }
GtPhlowExplicitViewExamples >> explicitViewUpdate [
	<gtExample>
	| aView anElement aColor aParent |

	aColor := Color red.
	aView := GtPhlowView empty explicit 
		title: 'Sample';
		stencil: [ BlElement new background: aColor ].
	aView asElementDo: [ :el | anElement := el ].

	self assertViewElement: anElement ofClass: BlElement inView: aView.

	self assert: anElement background paint color equals: Color red.

	aParent := BlElement new addChild: anElement.
	aColor := Color green.

	BlUseAsyncFeatures disableDuring: [ anElement phlow update ].

	self assert: aParent children first background paint color equals: Color green.
	self assert: aParent children first phlow isView.

	^ aParent
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtBasicFor: aView [ 
	^ aView explicit 
		title: 'Update on click';
		stencil: [ BlElement new 
				aptitude: BrShadowAptitude;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ] ]
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtCompositeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Composite';
		stencil: [ 
			(GtPhlowCompositeViewExamples new gtPhlowViewWithCollectorFor: GtPhlowView empty)
				asElementDo: [ :theElement | theElement ] ];
		actionUpdateButton
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtStencilWithPhlowFor: aView [ 
	<gtView>
	^ aView explicit 
		title: 'Stencil with Phlow';
		stencil: [ 
			(GtPhlowView empty on: GtPhlowCompositeViewExamples new perform: #gtPhlowViewFor:)
				asElementDo: [ :anElement | anElement ] ];
		actionUpdateButton
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtUpdatingDisabledOnSystemChangeFor: aView [ 
	^ aView explicit 
		title: 'Updating Disabled on System Change';
		stencil: [ BlElement new 
				aptitude: BrShadowAptitude;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ]  ]
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtUpdatingEnabledOnSystemChangeFor: aView [ 
	^ aView explicit 
		title: 'Updating Enabled on System Change';
		stencil: [ BlElement new 
				aptitude: BrShadowAptitude;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ]  ]
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtUpdatingFor: aView [ 
	<gtView>
	^ aView explicit 
		title: 'Update on click';
		stencil: [ BlElement new 
				aptitude: BrShadowAptitude;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ]  ];
		actionUpdateButton
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> myself [
	<gtExample>

	^ self
]

{ #category : #'examples - view' }
GtPhlowExplicitViewExamples >> phlowView [
	<gtExample>
	^ GtPhlowView empty explicit 
		title: 'Sample';
		object: self argument: GtPhlowView empty;
		stencil: [ BlElement new 
			background: Color random;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c margin: (BlInsets all: 10) ] ]
]

{ #category : #'examples - view' }
GtPhlowExplicitViewExamples >> stencilWithPhlow [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtStencilWithPhlowFor:.
	self assert: aView class equals: GtPhlowExplicitView.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: anElement class equals: BrTabGroup.
	^ aView
]
