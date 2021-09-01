Class {
	#name : 'GtPhlowListItemElementWithErrorHandlingDecorator',
	#superclass : 'BrListItemElementStencilBuilder',
	#instVars : [
		'stencilBuilder'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListItemElementWithErrorHandlingDecorator >> buildDefault [
	| aContainer |

	aContainer := self newCellContainer.
	
	(self itemType class = GtPhlowExceptionItemType) 
		ifTrue: [ 
			| anElement |
			anElement := self itemType exception asDebuggableElement vFitContent; hMatchParent.
			aContainer exception: anElement ]
		ifFalse: [ 
			[
				| anElement |
				anElement := self stencilBuilder
					itemType: self itemType;
					build.

				aContainer content: anElement. ]
					on: Error
					do: [ :anException |
						| anElement |
					anElement := anException asDebuggableElement vFitContent; hMatchParent.
					aContainer exception: anElement ]  ].
	^ aContainer
]

{ #category : 'instance creation' }
GtPhlowListItemElementWithErrorHandlingDecorator >> newCellContainer [
	^ GtPhlowCellElement new
		hMatchParent;
		vFitContent
]

{ #category : 'accessing' }
GtPhlowListItemElementWithErrorHandlingDecorator >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : 'accessing' }
GtPhlowListItemElementWithErrorHandlingDecorator >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
