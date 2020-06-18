"
I am an abstract class.
I provide a basic support ${class:GtPhlowView}$ updates.

"
Class {
	#name : #GtPhlowUpdateCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'elementContext'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowUpdateCommand class >> isAbstract [
	^ self name = #GtPhlowUpdateCommand 
]

{ #category : #comparing }
GtPhlowUpdateCommand >> = anObject [
	^ self class = anObject class and: [ 
		self elementContext = anObject elementContext ]
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> arguments [
	^ self buildContext arguments
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> buildContext [
	<return: #GtPhlowBuildContext>
	^ self elementContext buildContext
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> element [
	^ self elementContext element
]

{ #category : #accessing }
GtPhlowUpdateCommand >> elementContext [
	^ elementContext
]

{ #category : #accessing }
GtPhlowUpdateCommand >> elementContext: anObject [
	elementContext := anObject
]

{ #category : #accessing }
GtPhlowUpdateCommand >> entryIdentifier [
	^ self
]

{ #category : #testing }
GtPhlowUpdateCommand >> hasBuildContext [
	^ self elementContext hasBuildContext
]

{ #category : #comparing }
GtPhlowUpdateCommand >> hash [
	^ self class hash bitXor: self elementContext hash
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> methodSelector [
	^ self elementContext methodSelector
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> object [
	^ self buildContext object
]

{ #category : #'private - scheduling' }
GtPhlowUpdateCommand >> scheduleValuable: aBlock [
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			self element enqueueTask: (BlTaskAction new action: aBlock) ]
		otherwise: aBlock
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCommand >> view [
	^ self elementContext entity
]
