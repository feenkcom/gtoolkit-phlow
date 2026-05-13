Class {
	#name : #GtPhlowChangeSingleElementActionExecutor,
	#superclass : #GtPhlowChangeActionExecutor,
	#instVars : [
		'mutex',
		'element',
		'elementFuture'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeSingleElementActionExecutor >> configuration: aFutureExecutionConfiguration [
	elementFuture executionConfiguration: aFutureExecutionConfiguration
]

{ #category : #initialization }
GtPhlowChangeSingleElementActionExecutor >> defaultConfiguration [
	^ GtPhlowUtility defaultFutureExecutionConfiguration
]

{ #category : #accessing }
GtPhlowChangeSingleElementActionExecutor >> element [
	^ element
]

{ #category : #accessing }
GtPhlowChangeSingleElementActionExecutor >> element: anElement [
	self
		assert: [ element isNil ]
		description: [ 'Element is already initialized' ].

	element := anElement.
	elementFuture element: anElement
]

{ #category : #initialization }
GtPhlowChangeSingleElementActionExecutor >> initialize [
	super initialize.

	mutex := Mutex new.
	elementFuture := BrAsyncElementFuture new
			cancelSoft;
			executionConfiguration: self defaultConfiguration;
			whenSuccess: [ :anElement :anAction | anAction ifNotNil: #execute ]
]

{ #category : #'api - execution' }
GtPhlowChangeSingleElementActionExecutor >> submit: aChangeAction context: aChangeContext [
	self element ifNil: [ ^ self ].
	
	mutex critical: [ 
		| anActionFuture |
		anActionFuture := [ aChangeAction prepareOn: aChangeContext ] asAsyncFuture.
		elementFuture future: anActionFuture ]
]
