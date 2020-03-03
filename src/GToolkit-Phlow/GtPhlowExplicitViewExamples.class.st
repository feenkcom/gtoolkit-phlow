Class {
	#name : #GtPhlowExplicitViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
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
				look: BrShadowLook;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ] ]
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> gtUpdatingFor: aView [ 
	<gtView>
	^ aView explicit 
		title: 'Update on click';
		stencil: [ BlElement new 
				look: BrShadowLook;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ]  ];
		actionStencil: [ :aTab | 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons refresh asElement;
				action: [ aTab viewContentElement phlow update ] ]
]

{ #category : #'gt-extension' }
GtPhlowExplicitViewExamples >> myself [
	<gtExample>

	^ self
]
