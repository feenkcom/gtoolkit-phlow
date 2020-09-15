Class {
	#name : #GtPhlowListHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'private - asserting' }
GtPhlowListHandler >> assertTransformation: aGtPhlowSendTransformation [
	self 
		assert: [ aGtPhlowSendTransformation isKindOf: GtPhlowSendTransformation ] 
		description: [ self className, '''s transformation must be a ', GtPhlowSendTransformation name, ' object' ]
]

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
	self assertTransformation: aGtPhlowSendTransformation.
	transformation := aGtPhlowSendTransformation
]
