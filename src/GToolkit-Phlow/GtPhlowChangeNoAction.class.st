Class {
	#name : #GtPhlowChangeNoAction,
	#superclass : #GtPhlowChangeAction,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - actions' }
GtPhlowChangeNoAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	^ GtPhlowChangeEmptyUpdateAction default
]
