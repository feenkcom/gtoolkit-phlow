Class {
	#name : #GtPhlowSimpleListErrorHandlingItemElementStencilBuilder,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'cellSpacing'
	],
	#category : #'GToolkit-Phlow-Support - List simple'
}

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder class >> stencilProperties [
	^ #(stencilBuilder cellSpacing)
]

{ #category : #'api - instantiation' }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> buildDefault [
	| cellContainer |

	cellContainer := self newCellContainer.
	
	(self itemType class = GtPhlowExceptionItemType) 
		ifTrue: [ 
			| anElement |
			anElement := self itemType exception asDebuggableElement 
				vFitContent; 
				hMatchParent.
			cellContainer exception: anElement.
			^ cellContainer ].
		
	[
		| anElement |
		anElement := self stencilBuilder
			itemType: self itemType;
			build.

		cellContainer content: anElement
	]
		on: Error
		do: [ :anException |
			| anElement |
			anElement := anException asDebuggableElement 
				vFitContent; 
				hMatchParent.
			cellContainer exception: anElement ].
	^ cellContainer
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> cellSpacing [

	^ cellSpacing
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> cellSpacing: anObject [

	cellSpacing := anObject
]

{ #category : #'instance creation' }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> newCellContainer [
	^ GtPhlowCellElement new
		hMatchParent;
		vFitContent;
		padding: self cellSpacing
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemElementStencilBuilder >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
