"
I build a label that represents an object.
I use {{gtMethod:Object>>gtDisplayString}} to build a label representation of an object.
I am used by {{gtClass:GtPhlowLabelledViewBuilder}}.
For more details, see {{gtClass:GtPhlowUpdateLabelledViewTitle}}.


"
Class {
	#name : #GtPhlowLabelBuilder,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #'api - label' }
GtPhlowLabelBuilder >> articleFor: aString [
	<return: #String>
	^ aString first isVowel ifTrue: [ 'an ' ] ifFalse: [ 'a ' ]
]

{ #category : #'api - building' }
GtPhlowLabelBuilder >> build [
	<return: #BlRopedText or: #String>
	^ self titleOfObject: self object
]

{ #category : #accessing }
GtPhlowLabelBuilder >> object [
	^ object
]

{ #category : #accessing }
GtPhlowLabelBuilder >> object: anObject [
	object := anObject
]

{ #category : #'api - label' }
GtPhlowLabelBuilder >> textOf: anObject [
	<return: #BlRopedText>
	^ [ anObject gtDisplayString asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ]
]

{ #category : #'api - label' }
GtPhlowLabelBuilder >> titleOfObject: anObject [
	<return: #BlRopedText or: #String>
	| aClassName aHeader aDisplayText |
	aClassName := anObject class name.
	aHeader := (self articleFor: aClassName), aClassName.
	aDisplayText := self textOf: anObject.
	^ (aDisplayText asString beginsWith: aHeader)
		ifTrue: [ aDisplayText ]
		ifFalse: [ 
			String streamContents: [ :stream |
				stream
					nextPutAll: aHeader;
					nextPutAll: ' (';
					nextPutAll: aDisplayText characters;
					nextPutAll: ')' ] ].
]

{ #category : #'api - building' }
GtPhlowLabelBuilder >> value [
	<return: #BlRopedText or: #String>
	^ self build
]
