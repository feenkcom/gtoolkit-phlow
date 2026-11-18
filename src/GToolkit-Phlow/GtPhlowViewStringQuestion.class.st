Class {
	#name : #GtPhlowViewStringQuestion,
	#superclass : #GtPhlowViewQuestion,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'instance creation' }
GtPhlowViewStringQuestion class >> string: aString [
	^ self new string: aString
]

{ #category : #accessing }
GtPhlowViewStringQuestion >> string [
	^ string
]

{ #category : #accessing }
GtPhlowViewStringQuestion >> string: aString [
	self assert: aString isString.
	string := aString
]
