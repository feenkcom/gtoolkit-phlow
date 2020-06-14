Class {
	#name : #GtPhlowCompositeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #accessing }
GtPhlowCompositeViewExamples >> element [
	<gtExample>
	| aView anElement |
	aView := self phlowView.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: anElement class equals: BrTabGroup.
	self assert: anElement viewModel tabs size equals: 2.
	^ anElement
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> phlowView [
	<gtExample>
	| aView theSubViews |
	aView := GtPhlowView empty composite.
	theSubViews := { self subViewOne. self subViewTwo }.
	aView views: theSubViews.
	self assert: aView views equals: theSubViews.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewOne [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowExplicitViewExamples new perform: #gtUpdatingFor:.
	aView title: 'View One'.
	aView priority: 1.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewThree [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowTextEditorViewExamples new perform: #gtAutoUpdatingFor:.
	aView title: 'View Three'.
	aView priority: 3.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewTwo [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowListViewExamples new perform: #gtTenLinesFor:.
	aView title: 'View Two'.
	aView priority: 2.
	^ aView
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> updateViewOneDefinition [
	<gtExample>
	| anElement aView aSubView aCommand aNewSubView aContainer aContent |
	aContainer := self container.
	anElement := self element.
	aContent := anElement content.
	aContainer addChild: anElement.
	aView := anElement phlow entity.
	aSubView := aView views first.
	aNewSubView := self subViewThree.
	aNewSubView definingMethod: aSubView definingMethod.
	aCommand := GtPhlowUpdateCompositeSubViewTitleAndPosition new
		elementContext: anElement phlow;
		subView: aSubView.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].
	self assert: anElement content equals: aContent.
	^ aContainer
]
