Class {
	#name : #GtPhlowChangeAction,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - actions' }
GtPhlowChangeAction >> actOn: aChangeContext [
	self subclassResponsibility
]

{ #category : #'api - actions' }
GtPhlowChangeAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	^ self subclassResponsibility
]

{ #category : #'api - actions' }
GtPhlowChangeAction >> update: aResult on: aChangeContext [
	"Must be called in a UI process."

	self subclassResponsibility
]
