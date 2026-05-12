Class {
	#name : #GtPhlowDetailsRow,
	#superclass : #Object,
	#instVars : [
		'name',
		'valueComputation',
		'textComputation'
	],
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #initialization }
GtPhlowDetailsRow >> initialize [
	super initialize.
	
	name := 'Row'.
	valueComputation := [ nil ].
	textComputation := [ :aValue | aValue gtDisplayText ]
]

{ #category : #accessing }
GtPhlowDetailsRow >> name [
	^name
]

{ #category : #accessing }
GtPhlowDetailsRow >> name: aString [
	name := aString
]

{ #category : #accessing }
GtPhlowDetailsRow >> textComputation [
	^textComputation
]

{ #category : #accessing }
GtPhlowDetailsRow >> textComputation: aTextComputation [
	textComputation := aTextComputation
]

{ #category : #accessing }
GtPhlowDetailsRow >> valueComputation [
	^valueComputation
]

{ #category : #accessing }
GtPhlowDetailsRow >> valueComputation: aBlockClosure [
	valueComputation := aBlockClosure
]
