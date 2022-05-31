Class {
	#name : #GtPhlowListHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #defaults }
GtPhlowListHandler >> defaultTransformation [
	^ GtPhlowSendTransformation default
]

{ #category : #initialization }
GtPhlowListHandler >> initialize [
	super initialize.
	transformation := self defaultTransformation
]

{ #category : #accessing }
GtPhlowListHandler >> transformation [
	<return: #GtPhlowSendTransformation>
	^ transformation
]

{ #category : #accessing }
GtPhlowListHandler >> transformation: aGtPhlowSendTransformation [	
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation.
]
