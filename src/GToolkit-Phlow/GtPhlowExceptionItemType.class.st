"
I am used by ${class:GtPhlowListView}$ in case there is an error during item type creation.
"
Class {
	#name : #GtPhlowExceptionItemType,
	#superclass : #BlInfiniteItemType,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - instance creation' }
GtPhlowExceptionItemType class >> exception: anException [
	^ self new exception: anException
]

{ #category : #'api - accessing' }
GtPhlowExceptionItemType >> exception [
	^ exception
]

{ #category : #'api - accessing' }
GtPhlowExceptionItemType >> exception: anObject [
	exception := anObject
]
