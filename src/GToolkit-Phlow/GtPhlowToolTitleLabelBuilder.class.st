Class {
	#name : #GtPhlowToolTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'toolName',
		'subjectName'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - building' }
GtPhlowToolTitleLabelBuilder >> build [
	<return: #BlText>
	| aTitle aSubject |
	aTitle := self toolName value.
	aTitle ifNil: [ ^ BlText empty ].
	aTitle := aTitle copy asRopedText.
	aSubject := self subjectShortName.
	aSubject ifEmpty: [ ^ aTitle ].
	aTitle appendString: ': '.
	aTitle append: aSubject.
	^ aTitle
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> subjectName [
	^ subjectName
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> subjectName: anObject [
	subjectName := anObject
]

{ #category : #'private - building' }
GtPhlowToolTitleLabelBuilder >> subjectShortName [
	<return: #BlRopedText>
	| aTitle aSubject |
	aSubject := self subjectName value.
	aSubject ifNil: [ ^ BlText empty ].
	aSubject := aSubject asRopedText.
	aSubject size < 42 ifTrue: [ ^ aSubject ].
	
	aTitle := '' asRopedText.
	aTitle append: (aSubject from: 1 to: 12) asRopedText.
	aTitle appendString: '...'.
	aTitle append: (aSubject from: aSubject size - 12 to: aSubject size) asRopedText.
	
	^ aTitle
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> toolName [
	^ toolName
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> toolName: anObject [
	toolName := anObject
]
