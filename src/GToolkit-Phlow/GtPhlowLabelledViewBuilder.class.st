Class {
	#name : #GtPhlowLabelledViewBuilder,
	#superclass : #GtPhlowCompositeViewBuilder,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #'api - label' }
GtPhlowLabelledViewBuilder class >> articleFor: aString [
	<return: #String>
	^ aString first isVowel ifTrue: [ 'an ' ] ifFalse: [ 'a ' ]
]

{ #category : #'api - label' }
GtPhlowLabelledViewBuilder class >> textOf: anObject [
	<return: #BlRopedText>
	^ [ anObject gtDisplayString asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ]
]

{ #category : #'api - label' }
GtPhlowLabelledViewBuilder class >> titleOfObject: anObject [
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

{ #category : #building }
GtPhlowLabelledViewBuilder >> buildView [
	<return: #GtPhlowLabelledView>
	| aView |
	aView := super buildView labelled: self title.
	aView originalView buildContext arguments: { aView. self context }.
	self addBuildContext: aView.
	^ aView
]

{ #category : #label }
GtPhlowLabelledViewBuilder >> title [
	<return: #BlRopedText or: #String>
	^ self class titleOfObject: self object
]
