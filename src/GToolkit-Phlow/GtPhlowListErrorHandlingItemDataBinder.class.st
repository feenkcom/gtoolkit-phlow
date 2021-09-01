Class {
	#name : 'GtPhlowListErrorHandlingItemDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'dataBinder'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemDataBinder >> buildDefault [	
	[
		dataBinder
			itemElement: itemElement content;
			itemObject: itemObject;
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

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemDataBinder >> dataBinder: aBrListItemDataBinder [
	dataBinder := aBrListItemDataBinder asStencilBuilder: BrListItemDataBinder
]
