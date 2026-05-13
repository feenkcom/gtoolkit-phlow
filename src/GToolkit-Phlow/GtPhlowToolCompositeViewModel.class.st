Class {
	#name : #GtPhlowToolCompositeViewModel,
	#superclass : #Object,
	#traits : 'TGtPhlowToolViewModel',
	#classTraits : 'TGtPhlowToolViewModel classTrait',
	#instVars : [
		'tabGroup'
	],
	#category : #'GToolkit-Phlow-Tool - Navigation'
}

{ #category : #'api - accessing' }
GtPhlowToolCompositeViewModel >> element [
	^ tabGroup
		childWithId: #content
		ifFound: [ :anElement | anElement children at: 1 ifAbsent: [ nil ] ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
GtPhlowToolCompositeViewModel >> object [
	^ self element
		ifNotNil: [ :anElement | anElement phlow toolViewModel ifNotNil: #object ]
]

{ #category : #accessing }
GtPhlowToolCompositeViewModel >> tabGroup [
	<return: #BrTabGroup>
	^ tabGroup
]

{ #category : #accessing }
GtPhlowToolCompositeViewModel >> tabGroup: aBrTabGroup [
	tabGroup := aBrTabGroup
]

{ #category : #'api - accessing' }
GtPhlowToolCompositeViewModel >> type [
	^ self element
		ifNotNil: [ :anElement | anElement phlow toolViewModel ifNotNil: #type ]
]

{ #category : #'api - accessing' }
GtPhlowToolCompositeViewModel >> viewModel [
	^ self element
		ifNotNil: [ :anElement | anElement phlow toolViewModel ifNotNil: #viewModel ]
]
