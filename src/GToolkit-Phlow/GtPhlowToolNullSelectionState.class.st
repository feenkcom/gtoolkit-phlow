Class {
	#name : #GtPhlowToolNullSelectionState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowToolNullSelectionState >> appliesToTool: aPhlowTool [
	^ false
]
