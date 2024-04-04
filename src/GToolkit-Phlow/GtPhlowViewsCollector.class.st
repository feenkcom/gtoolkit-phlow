Class {
	#name : #GtPhlowViewsCollector,
	#superclass : #GtPhlowCollector,
	#traits : 'TGtPhlowContextAccessor',
	#classTraits : 'TGtPhlowContextAccessor classTrait',
	#category : #'GToolkit-Phlow-Collectors'
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
			aView := GtPhlowView empty 
				on: self object 
				perform: eachPragma methodSelector
				withContext: self context.
			self object gtActions do: [ :eachAction | 
				(eachAction target 
					isForViewDefinedIn: eachPragma methodSelector) ifTrue: [ 
						aView addPhlowAction: eachAction ] ].
			aView ].
	self sortByPriority: theViews.
	^ theViews
]

{ #category : #initialization }
GtPhlowViewsCollector >> defaultPragmaNames [
	^ self class defaultViewPragmaNames
]

{ #category : #initialization }
GtPhlowViewsCollector >> initialize [
	super initialize.
	self initializePhlowContext.
]
