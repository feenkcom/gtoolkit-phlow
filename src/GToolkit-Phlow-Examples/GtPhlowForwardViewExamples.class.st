Class {
	#name : #GtPhlowForwardViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'examples - view' }
GtPhlowForwardViewExamples >> elemenWithParentError [
	<gtExample>
	<return: #GtPhlowView>
	| aForwardView aScripter anElement |
	aForwardView := GtPhlowView empty forward
			object: [ GtPhlowForwardViewExamples new ];
			view: #gtElementWithParentFor:.

	anElement := aForwardView asElementDo: [ :theElement | theElement ].
	
	aScripter := BlScripter new.
	aScripter model: aForwardView.
	aScripter element: anElement.
			
	^ aScripter
]

{ #category : #'examples - element' }
GtPhlowForwardViewExamples >> expectedElementClass [
	^ BrFromFuture
]

{ #category : #'gt - extensions' }
GtPhlowForwardViewExamples >> gtElementWithParentFor: aView [
	<gtView>
	^ aView explicit
		title: 'Element with parent';
		stencil: [ | child |
			child := BlElement new.
			BlElement new addChild: child.
			child ]
]

{ #category : #'examples - view' }
GtPhlowForwardViewExamples >> onAddedToSceneUpdatingView [
	"See https://github.com/feenkcom/gtoolkit/issues/4403"

	<gtExample>
	<return: #GtPhlowView>
	| aForwardView aScripter anElement |
	aForwardView := GtPhlowView empty forward
			object: [ GtPhlowListViewExamples new ];
			view: #gtTenLinesFor:;
			addAutoUpdate: GtPhlowUpdateViewOnAddedToScene.

	anElement := aForwardView asElementDo: [ :theElement | theElement ].
	
	aScripter := BlScripter new.
	aScripter maxPulseElapsedTime: 30 seconds.
	aScripter model: aForwardView.
	aScripter element: anElement.
			
	^ aScripter
]

{ #category : #'examples - view' }
GtPhlowForwardViewExamples >> phlowView [
	<gtExample>
	<return: #GtPhlowView>
	^ GtPhlowView empty forward
		object: [ GtPhlowColumnedListViewExamples new ];
		view: #gtTenItemsWithColumnItemsFor:
]
