Class {
	#name : 'GtPhlowListErrorHandlingItemTypeStencilBuilder',
	#superclass : 'BrListItemTypeStencilBuilder',
	#instVars : [
		'itemTypeStencilBuilder'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListErrorHandlingItemTypeStencilBuilder >> buildDefault [
	^ [ 
		itemTypeStencilBuilder
			itemObject: itemObject;
			itemPosition: itemPosition;
			build
	]
		on: Error
		do: [ :anError | GtPhlowExceptionItemType exception: anError freezeOrWithoutContext ]
]

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemTypeStencilBuilder >> itemTypeStencilBuilder [

	^ itemTypeStencilBuilder
]

{ #category : 'accessing' }
GtPhlowListErrorHandlingItemTypeStencilBuilder >> itemTypeStencilBuilder: anObject [

	itemTypeStencilBuilder := anObject
]
