"
I add error handling for user inputs.
I am used by ${class:GtPhlowListView}$ and ${class:GtPhlowColumn}$.

"
Trait {
	#name : #TGtPhlowErrorTolerantCell,
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #'private - errors' }
TGtPhlowErrorTolerantCell >> errorTreatedCellDataBinderFor: aBlockOrSymbol [
	 ^ [ :aContainer :anItemObject :anItemIndex |
			self 
				performBlock: [ 
					aBlockOrSymbol glamourValueWithArgs: { aContainer content. anItemObject. anItemIndex. self }.
					aContainer removeException; showContent. ]
				onException: [ :anException | 
					| anElement |
					anElement := anException asDebuggableElement vFitContent; hMatchParent.
					aContainer exception: anElement. ].
			aContainer ]
]

{ #category : #'private - errors' }
TGtPhlowErrorTolerantCell >> errorTreatedCellStencilFor: aBrListItemElementStencilBuilder [
	 ^ [ :anItemType |
			| aContainer |
			aContainer := self newCellContainer.
			(anItemType class = GtPhlowExceptionItemType) 
				ifTrue: [ 
					| anElement |
					anElement := anItemType exception asDebuggableElement vFitContent; hMatchParent.
					aContainer exception: anElement ]
				ifFalse: [ 
					self 
						performBlock: [ 
							| anElement |
							anElement := aBrListItemElementStencilBuilder
								itemType: anItemType;
								build.
							aContainer content: anElement. ]
						onException: [ :anException | 
							| anElement |
							anElement := anException asDebuggableElement vFitContent; hMatchParent.
							aContainer exception: anElement. ] ].
			aContainer ]
]

{ #category : #'private - errors' }
TGtPhlowErrorTolerantCell >> errorTreatedCellTypeFor: aBlockOrSymbol [
	 ^ [ :anItemTypeFactory :anItemObject :anItemIndex |
			self 
				performBlock: [ 
					aBlockOrSymbol glamourValueWithArgs: { anItemTypeFactory. anItemObject. anItemIndex. self } ]
				onException: [ :anException |
					GtPhlowExceptionItemType exception: anException freezeOrWithoutContext ] ]
]

{ #category : #'private - building' }
TGtPhlowErrorTolerantCell >> newCellContainer [
	^ GtPhlowCellElement new
		hMatchParent;
		vFitContent;
		padding: self newCellPaddingInsets
]

{ #category : #'private - building' }
TGtPhlowErrorTolerantCell >> newCellPaddingInsets [
	^ BlInsets
		top: 0
		left: 10
		bottom: 0
		right: 0
]

{ #category : #'private - errors' }
TGtPhlowErrorTolerantCell >> performBlock: aBlock onException: anExceptionBlock [
	^ aBlock on: Error do: anExceptionBlock.
]
