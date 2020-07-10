"
I add error handling for user inputs.
I am used by ${class:GtPhlowListView}$ and ${class:GtPhlowColumn}$.

"
Trait {
	#name : #TGtPhlowErrorTolerantCell,
	#category : #'GToolkit-Phlow-Support'
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
TGtPhlowErrorTolerantCell >> errorTreatedCellStencilFor: aBlockOrSymbol [
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
							anElement := aBlockOrSymbol glamourValueWithArgs: { anItemType. self }.
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
		padding: (BlInsets top: 3 left: 10 bottom: 3 right: 10)
]

{ #category : #'private - errors' }
TGtPhlowErrorTolerantCell >> performBlock: aBlock onException: anExceptionBlock [
	^ aBlock on: Error do: anExceptionBlock.
]
