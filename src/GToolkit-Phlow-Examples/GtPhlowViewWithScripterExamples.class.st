Class {
	#name : #GtPhlowViewWithScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #examples }
GtPhlowViewWithScripterExamples >> labelledView [
	<gtExample>
	| anObject aView anElement aScripter |
	anObject := self object.

	aView := anObject gtViewsFor: GtPhlowView empty.
	anElement := aView asElement.
	aScripter := BlScripter new.
	aScripter
		model: aView;
		element: anElement.

	^ aScripter
]

{ #category : #examples }
GtPhlowViewWithScripterExamples >> labelledViewElement [
	<gtExample>
	^ self labelledView model asElement
]

{ #category : #examples }
GtPhlowViewWithScripterExamples >> labelledView_headerContextMenu [
	<gtExample>
	| aScripter |
	aScripter := self labelledView.

	aScripter menuStep
		/ #header;
		openContextMenu;
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #examples }
GtPhlowViewWithScripterExamples >> labelledView_headerContextMenu_browseClass [
	<gtExample>
	| aScripter spawnEvents |
	aScripter := self labelledView_headerContextMenu.

	aScripter menuStep
		onPopover;
		clickMenuItemWithId: GtInspectorBrowseButtonId;
		assertClosedMenuContainer;
		play.

	spawnEvents := aScripter events
			select: [ :each | each class = GtPhlowObjectToSpawn ].
	self assert: spawnEvents size equals: 2.

	^ aScripter
]

{ #category : #examples }
GtPhlowViewWithScripterExamples >> object [
	^ GtPhlowButtonAction >> #asElement:withHostElement:
]
