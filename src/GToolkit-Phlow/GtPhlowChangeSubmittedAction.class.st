Class {
	#name : #GtPhlowChangeSubmittedAction,
	#superclass : #Object,
	#instVars : [
		'changeAction',
		'changeContext',
		'elementFuture'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> changeAction [
	^ changeAction
]

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> changeAction: anObject [
	changeAction := anObject
]

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> changeContext [
	^ changeContext
]

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> changeContext: anObject [
	changeContext := anObject
]

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> elementFuture [
	<return: #BrAsyncElementFuture>
	^ elementFuture
]

{ #category : #accessing }
GtPhlowChangeSubmittedAction >> elementFuture: anElementFuture [
	elementFuture := anElementFuture
]
