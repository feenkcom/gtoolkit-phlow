Class {
	#name : #GtPhlowLabelledViewBuilder,
	#superclass : #GtPhlowCompositeViewBuilder,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #label }
GtPhlowLabelledViewBuilder >> articleFor: aString [
	<return: #String>
	^ aString first isVowel ifTrue: [ 'an ' ] ifFalse: [ 'a ' ]
]

{ #category : #building }
GtPhlowLabelledViewBuilder >> buildView [
	<return: #GtPhlowLabelledView>
	^ super buildView labelled: self title
]

{ #category : #label }
GtPhlowLabelledViewBuilder >> displayObjectText [
	<return: #BlRopedText>
	^ [ (String streamContents: [ :stream | self object gtDisplayOn: stream ]) asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ]
]

{ #category : #label }
GtPhlowLabelledViewBuilder >> title [
	<return: #BlRopedText or: #String>
	| aClassName aHeader aDisplayText |
	aClassName := self object class name.
	aHeader := (self articleFor: aClassName), aClassName.
	aDisplayText := self displayObjectText.
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
