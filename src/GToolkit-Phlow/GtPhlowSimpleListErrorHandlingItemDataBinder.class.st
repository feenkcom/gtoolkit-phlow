Class {
	#name : #GtPhlowSimpleListErrorHandlingItemDataBinder,
	#superclass : #BrListItemDataBinder,
	#instVars : [
		'dataBinder'
	],
	#category : 'GToolkit-Phlow-Support - List simple'
}

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemDataBinder class >> stencilProperties [
	^ #(dataBinder)
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemDataBinder >> buildDefault [	
	[
		dataBinder
			itemElement: itemElement content;
			itemObject: itemObject;
			rowObject: rowObject;
			itemPosition: itemPosition;
			build.
		itemElement
			removeException;
			showContent ]
	on: Error
	do: [ :anError |
		| anErrorElement |
		anErrorElement := anError asDebuggableElement vFitContent; hMatchParent.
		itemElement exception: anErrorElement ].

	^ itemElement
]

{ #category : #accessing }
GtPhlowSimpleListErrorHandlingItemDataBinder >> dataBinder: aBrListItemDataBinder [
	dataBinder := aBrListItemDataBinder asStencilBuilder: BrListItemDataBinder
]
