Class {
	#name : #GtPhlowTreeRowElementStencilBuilder,
	#superclass : #BrSimpleTreeRowElementStencilBuilder,
	#instVars : [
		'cellSpacing',
		'padding'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'api - instantiation' }
GtPhlowTreeRowElementStencilBuilder >> buildDefault [
	^ super buildDefault
		addLook: BrGlamorousListItemLook;
		layoutDo: [ :aLayout | aLayout cellSpacing: self cellSpacing ];
		padding: self padding
]

{ #category : #accessing }
GtPhlowTreeRowElementStencilBuilder >> cellSpacing [
	^ cellSpacing
]

{ #category : #accessing }
GtPhlowTreeRowElementStencilBuilder >> cellSpacing: anObject [
	cellSpacing := anObject
]

{ #category : #accessing }
GtPhlowTreeRowElementStencilBuilder >> initialize [
	super initialize.
	
	cellSpacing := 0.
	padding := BlInsets empty
]

{ #category : #accessing }
GtPhlowTreeRowElementStencilBuilder >> padding [
	^ padding
]

{ #category : #accessing }
GtPhlowTreeRowElementStencilBuilder >> padding: anObject [
	padding := anObject
]
