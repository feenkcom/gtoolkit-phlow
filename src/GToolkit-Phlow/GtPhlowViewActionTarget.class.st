"
I define where a {{gtClass:GtPhlowAction}} should be displayed.
I determine that actions are supposed to be displayed in a specific {{gtClass:GtPhlowView}} tab: {{gtExample: GtPhlowWithViewActionTarget >> #itself | noCode=true}}

To be displayed in the `My Demo` tab, I must have {{gtMethod: GtPhlowViewActionTarget >> #definingMethodSelector}} of the same value, as is the method selector of the defined view {{gtMethod: GtPhlowWithViewActionTarget>>#gtMyDemoFor:}}. See, my definition in {{gtMethod: GtPhlowWithViewActionTarget >> #gtDemoActionWithTargetFor: | expanded=true}} 
"
Class {
	#name : #GtPhlowViewActionTarget,
	#superclass : #GtPhlowActionTarget,
	#instVars : [
		'definingMethodSelector'
	],
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #accessing }
GtPhlowViewActionTarget >> definingMethodSelector [
	<return: #Symbol>
	^ definingMethodSelector
]

{ #category : #accessing }
GtPhlowViewActionTarget >> definingMethodSelector: aSymbol [
	self 
		assert: [ aSymbol isSymbol ]
		description: [ 'View definition should be a Symbol' ].
	definingMethodSelector := aSymbol
]

{ #category : #testing }
GtPhlowViewActionTarget >> isForViewDefinedIn: aSymbol [
	self 
		assert: [ aSymbol isSymbol ]
		description: [ 'View definition should be a Symbol' ].
	^ self definingMethodSelector = aSymbol
]

{ #category : #printing }
GtPhlowViewActionTarget >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self definingMethodSelector;
		nextPut: $)
]
