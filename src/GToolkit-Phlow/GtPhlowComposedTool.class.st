Class {
	#name : #GtPhlowComposedTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'tools'
	],
	#category : #'GToolkit-Phlow-Tools'
}

{ #category : #defaults }
GtPhlowComposedTool >> defaultTools [
	^ Array empty
]

{ #category : #initialization }
GtPhlowComposedTool >> initialize [
	super initialize.
	tools := self defaultTools.
]

{ #category : #accessing }
GtPhlowComposedTool >> tools [
	<return: #Array of: #GtPhlowTool>
	^ tools
]

{ #category : #accessing }
GtPhlowComposedTool >> tools: anObject [
	tools := anObject
]
