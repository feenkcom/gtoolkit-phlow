Class {
	#name : #GtPhlowOverviewItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'value',
		'isValueException'
	],
	#category : #'GToolkit-Phlow-Convenience and Utilities'
}

{ #category : #initalization }
GtPhlowOverviewItem >> beComputedValue [
	isValueException := false
]

{ #category : #initalization }
GtPhlowOverviewItem >> beExceptionValue [
	isValueException := true
]

{ #category : #convenience }
GtPhlowOverviewItem >> boolean: aBoolean [
	self value: aBoolean.
	aBoolean isBoolean
		ifFalse: [ | aText |
			aText := 'Not a boolean value: ' asRopedText
					foreground: BrGlamorousColors errorBackgroundColor.
			aText append: aBoolean asRopedText.
			self description: aText.
			^ self ].

	aBoolean
		ifTrue: [ self description: 'yes' asRopedText ]
		ifFalse: [ self
				description: ('no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor) ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> description [
	^ description
		ifNil: [ description := self value gtDisplayText.
			self isValueException
				ifTrue: [ description foreground: BrGlamorousColors errorBackgroundColor ].
			description ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> description: anObject [
	description := anObject
]

{ #category : #printing }
GtPhlowOverviewItem >> gtDisplayOn: stream [
	name ifNil: [ ^ super gtDisplayOn: stream ].

	self name asString gtDisplayOn: stream.
	stream nextPutAll: ': '.
	self description asString gtDisplayOn: stream
]

{ #category : #convenience }
GtPhlowOverviewItem >> if: aBoolean description: aStringOrBlText [
	aBoolean isBoolean ifFalse: [ ^ self ].
	aBoolean ifFalse: [ ^ self ].
	self description: aStringOrBlText
]

{ #category : #convenience }
GtPhlowOverviewItem >> if: aBoolean subduedDescription: aStringOrBlText [
	| aText |
	aBoolean ifFalse: [ ^ self ].
	aText := aStringOrBlText asRopedText foreground: BrGlamorousColors disabledButtonTextColor.
	self description: aText 
]

{ #category : #convenience }
GtPhlowOverviewItem >> ifComputedValueDescription: aDescriptionBlock [
	self isValueException ifTrue: [ ^ self ].
	self description: (aDescriptionBlock value: self value)
]

{ #category : #convenience }
GtPhlowOverviewItem >> ifExceptionValueDescription: aDescriptionBlock [
	self isValueException ifFalse: [ ^ self ].
	self description: (aDescriptionBlock value: self value)
]

{ #category : #convenience }
GtPhlowOverviewItem >> ifNot: aBoolean description: aStringOrBlText [
	aBoolean isBoolean ifFalse: [ ^ self ].
	self if: aBoolean not description: aStringOrBlText
]

{ #category : #testing }
GtPhlowOverviewItem >> isValueException [
	^ isValueException ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> name [
	^ name ifNil: [ name := '' ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> name: anObject [
	name := anObject
]

{ #category : #printing }
GtPhlowOverviewItem >> printOn: aStream [
	super printOn: aStream.
	name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: self name asString;
		nextPutAll: ': ';
		print: self description asString
]

{ #category : #convenience }
GtPhlowOverviewItem >> secureValue: aValuable [
	[ self value: aValuable value.
	self beComputedValue ]
		on: Error
		do: [ :anException | 
			self value: (GtMagritteActionUtility freeze: anException).
			self beExceptionValue ]
]

{ #category : #convenience }
GtPhlowOverviewItem >> toCollection: aCollection [
	aCollection add: self
]

{ #category : #convenience }
GtPhlowOverviewItem >> toStream: aStream [
	aStream nextPut: self
]

{ #category : #accessing }
GtPhlowOverviewItem >> value [
	^ value
]

{ #category : #accessing }
GtPhlowOverviewItem >> value: anObject [
	value := anObject
]
