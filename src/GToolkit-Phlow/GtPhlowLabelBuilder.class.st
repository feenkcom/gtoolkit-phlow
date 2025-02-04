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
	^ aString first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]
]

{ #category : #'api - building' }
GtPhlowLabelBuilder >> build [
	<return: #BlRunRopedText or: #String>
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
	<return: #BlRunRopedText>
	^ [ anObject gtDisplayText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ]
]

{ #category : #'api - label' }
GtPhlowLabelBuilder >> titleOfObject: anObject [
	<return: #BlRunRopedText or: #String>
	| className classArticle headerWithoutSpace headerWithSpace displayText |
	className := anObject class name.
	classArticle := self articleFor: className.
	headerWithoutSpace := classArticle, className.
	headerWithSpace := classArticle, String space, className.
	displayText := self textOf: anObject.
	^ ((displayText asString beginsWith: headerWithoutSpace) or: [
		displayText asString beginsWith: headerWithSpace ])
			ifTrue: [ displayText ]
			ifFalse: [ 
				String streamContents: [ :stream |
					stream
						nextPutAll: headerWithSpace;
						nextPutAll: ' (';
						nextPutAll: displayText characters;
						nextPutAll: ')' ] ].
]

{ #category : #'api - building' }
GtPhlowLabelBuilder >> value [
	<return: #BlRunRopedText or: #String>
	^ self build
]
