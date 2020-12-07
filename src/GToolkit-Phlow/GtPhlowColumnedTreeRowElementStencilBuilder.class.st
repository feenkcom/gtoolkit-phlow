Class {
	#name : #GtPhlowColumnedTreeRowElementStencilBuilder,
	#superclass : #BrColumnedTreeRowElementStencilBuilder,
	#instVars : [
		'padding',
		'cellSpacing'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'api - instantiation' }
GtPhlowColumnedTreeRowElementStencilBuilder >> buildDefault [
	^ super buildDefault
		addLook: BrGlamorousListItemLook;
		layoutDo: [ :aLayout | aLayout cellSpacing: self cellSpacing ];
		padding: self padding
]

{ #category : #accessing }
GtPhlowColumnedTreeRowElementStencilBuilder >> cellSpacing [
	^ cellSpacing
]

{ #category : #accessing }
GtPhlowColumnedTreeRowElementStencilBuilder >> cellSpacing: anObject [
	cellSpacing := anObject
]

{ #category : #initialization }
GtPhlowColumnedTreeRowElementStencilBuilder >> initialize [
	super initialize.
	
	cellSpacing := 0.
	padding := BlInsets empty
]

{ #category : #accessing }
GtPhlowColumnedTreeRowElementStencilBuilder >> padding [
	^ padding
]

{ #category : #accessing }
GtPhlowColumnedTreeRowElementStencilBuilder >> padding: anObject [
	padding := anObject
]
