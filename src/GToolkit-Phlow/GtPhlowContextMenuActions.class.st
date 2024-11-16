Class {
	#name : #GtPhlowContextMenuActions,
	#superclass : #GtPhlowContextMenuAction,
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #converting }
GtPhlowContextMenuActions >> toActionOn: anItem [
	^ self action cull: anItem
]
