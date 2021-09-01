Class {
	#name : 'GtPhlowListErrorHandlingItemElementStencilBuilder',
	#superclass : 'BrListItemElementStencilBuilder',
	#instVars : [
		'stencilBuilder',
		'cellSpacing'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> buildDefault [
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

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> cellSpacing [

	^ cellSpacing
]

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> cellSpacing: anObject [

	cellSpacing := anObject
]

{ #category : 'instance creation' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> newCellContainer [
	^ GtPhlowCellElement new
		hMatchParent;
		vFitContent;
		padding: self cellSpacing
]

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemElementStencilBuilder >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
