Class {
	#name : #GtPhlowChangeCompositeUpdateAction,
	#superclass : #Object,
	#traits : 'TGtPhlowChangeUpdateAction',
	#classTraits : 'TGtPhlowChangeUpdateAction classTrait',
	#instVars : [
		'updateActions'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - execution' }
GtPhlowChangeCompositeUpdateAction >> execute [
	"do nothing"

	self updateActions do: #execute
]

{ #category : #accessing }
GtPhlowChangeCompositeUpdateAction >> updateActions [
	^ updateActions ifNil: [ Array empty ]
]

{ #category : #accessing }
GtPhlowChangeCompositeUpdateAction >> updateActions: anObject [
	updateActions := anObject
]
