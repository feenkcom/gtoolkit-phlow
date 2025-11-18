Class {
	#name : #GtPhlowListItemElementWithSelectionDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-Support - List utilities'
}

{ #category : #accessing }
GtPhlowListItemElementWithSelectionDecorator class >> stencilProperties [
	^ #(stencilBuilder)
]

{ #category : #'api - instantiation' }
GtPhlowListItemElementWithSelectionDecorator >> buildDefault [
	| anElement |

	anElement := stencilBuilder
		itemType: self itemType;
		build.

	anElement addAptitude: BrGlamorousListItemAptitude.
	
	^ anElement
]

{ #category : #accessing }
GtPhlowListItemElementWithSelectionDecorator >> stencilBuilder [

	^ stencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithSelectionDecorator >> stencilBuilder: anObject [

	stencilBuilder := anObject
]
