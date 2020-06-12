Class {
	#name : #GtPhlowUpdateCommand,
	#superclass : #BlTktCommand,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowUpdateCommand class >> isAbstract [
	^ self name = #GtPhlowUpdateCommand 
]

{ #category : #accessing }
GtPhlowUpdateCommand >> entryIdentifier [
	^ self
]
