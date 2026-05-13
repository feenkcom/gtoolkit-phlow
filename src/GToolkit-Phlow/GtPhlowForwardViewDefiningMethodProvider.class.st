Class {
	#name : #GtPhlowForwardViewDefiningMethodProvider,
	#superclass : #GtPhlowDefiningMethodProvider,
	#instVars : [
		'definingMethod',
		'phlowForwardView'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #accessing }
GtPhlowForwardViewDefiningMethodProvider >> allDefiningMethods [
	^ GtPhlowDefiningMethods new 
		 methods: (Array streamContents: [ :aStream | 
			phlowForwardView originMethodsInto: aStream ])
]

{ #category : #accessing }
GtPhlowForwardViewDefiningMethodProvider >> definingMethod [
	^ definingMethod "GtPhlowDefiningMethods new 
		 methods: (Array streamContents: [ :aStream | 
			self originMethodsInto: aStream ])"
]

{ #category : #accessing }
GtPhlowForwardViewDefiningMethodProvider >> definingMethod: aDefiningMethod [
	definingMethod := aDefiningMethod
]

{ #category : #accessing }
GtPhlowForwardViewDefiningMethodProvider >> phlowForwardView: aPhlowView [
	phlowForwardView := aPhlowView
]
