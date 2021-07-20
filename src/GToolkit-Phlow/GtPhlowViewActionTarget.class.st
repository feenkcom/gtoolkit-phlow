Class {
	#name : 'GtPhlowViewActionTarget',
	#superclass : 'GtPhlowActionTarget',
	#instVars : [
		'definingMethodSelector'
	],
	#category : 'GToolkit-Phlow-Action Targets'
}

{ #category : 'accessing' }
GtPhlowViewActionTarget >> definingMethodSelector [
	<return: #Symbol>
	^ definingMethodSelector
]

{ #category : 'accessing' }
GtPhlowViewActionTarget >> definingMethodSelector: aSymbol [
	self 
		assert: [ aSymbol isSymbol ]
		description: [ 'View definition should be a Symbol' ].
	definingMethodSelector := aSymbol
]

{ #category : 'testing' }
GtPhlowViewActionTarget >> isForViewDefinedIn: aSymbol [
	self 
		assert: [ aSymbol isSymbol ]
		description: [ 'View definition should be a Symbol' ].
	^ self definingMethodSelector = aSymbol
]
