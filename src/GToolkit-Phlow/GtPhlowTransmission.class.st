Class {
	#name : 'GtPhlowTransmission',
	#superclass : 'Object',
	#instVars : [
		'root',
		'from',
		'to',
		'announcementRegistration',
		'strategy'
	],
	#category : 'GToolkit-Phlow-Transmission'
}

{ #category : 'instance creation' }
GtPhlowTransmission class >> rootedIn: anElement [
	^ self new root: anElement
]

{ #category : 'scripting' }
GtPhlowTransmission >> andShow: aBlock [
	self strategy: GtPhlowTransmissionReplaceAndShowStrategy new.
	self fromElement when: self announcementRegistration do: [ :ann | 
		self toElement removeChildren.
		self toElement addChildren: (aBlock value: ann) asOrderedCollection ]
]

{ #category : 'accessing' }
GtPhlowTransmission >> announcementRegistration [
	^ announcementRegistration
]

{ #category : 'accessing' }
GtPhlowTransmission >> announcementRegistration: anObject [
	announcementRegistration := anObject
]

{ #category : 'accessing' }
GtPhlowTransmission >> from [
	^ from
]

{ #category : 'accessing' }
GtPhlowTransmission >> from: anObject [
	from := anObject
]

{ #category : 'accessing' }
GtPhlowTransmission >> fromElement [
	^ root childNamed: self from
]

{ #category : 'accessing' }
GtPhlowTransmission >> root [
	^ root
]

{ #category : 'accessing' }
GtPhlowTransmission >> root: anObject [
	root := anObject
]

{ #category : 'accessing' }
GtPhlowTransmission >> strategy [
	^ strategy
]

{ #category : 'accessing' }
GtPhlowTransmission >> strategy: anObject [
	strategy := anObject
]

{ #category : 'accessing' }
GtPhlowTransmission >> to [
	^ to
]

{ #category : 'scripting' }
GtPhlowTransmission >> to: aChildName [
	to := aChildName
]

{ #category : 'accessing' }
GtPhlowTransmission >> toElement [
	^ root childNamed: self to
]

{ #category : 'scripting' }
GtPhlowTransmission >> when: anAnnouncementRegistration from: aChildName [
	self from: aChildName.
	self announcementRegistration: anAnnouncementRegistration
]
