Class {
	#name : #GtPhlowViewsCollector,
	#superclass : #GtPhlowCollector,
	#instVars : [
		'context'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #accessing }
GtPhlowViewsCollector class >> defaultViewPragmaNames [
	^ #( #gtView )
]

{ #category : #actions }
GtPhlowViewsCollector >> collect [
	<return: #Array of: #GtPhlowView>
	<gtCollector>
	| theViews |
	theViews := self collectPragmas
		collect: [ :eachPragma | 
			| aView |
			aView := GtPhlowView empty.
			eachPragma methodSelector numArgs = 1 ifTrue: [ 
				aView := aView on: self object perform: eachPragma methodSelector ].
			eachPragma methodSelector numArgs = 2 ifTrue: [ 
				aView := aView 
					on: self object 
					perform: eachPragma methodSelector
					withContext: self context ].
			aView ].
	theViews sort: [ :a :b | 
		[a priority < b priority]
			on: Error
			do: [ :error | true ] ].
	^ theViews
]

{ #category : #accessing }
GtPhlowViewsCollector >> context [
	^ context
]

{ #category : #accessing }
GtPhlowViewsCollector >> context: anObject [
	context := anObject
]

{ #category : #initialization }
GtPhlowViewsCollector >> initialize [
	super initialize.
	context := nil.
]

{ #category : #initialization }
GtPhlowViewsCollector >> initializePragmaNames [
	pragmaNames := self class defaultViewPragmaNames
]
