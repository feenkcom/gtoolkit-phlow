Class {
	#name : #GtPhlowViewBuilder,
	#superclass : #GtPhlowViewProtoBuilder,
	#traits : 'TGtPhlowViewAccessor + TGtPhlowContextAccessor',
	#classTraits : 'TGtPhlowViewAccessor classTrait + TGtPhlowContextAccessor classTrait',
	#instVars : [
		'object',
		'actionsSelector'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #testing }
GtPhlowViewBuilder class >> isAbstract [
	^ self name = #GtPhlowViewBuilder 
]

{ #category : #actions }
GtPhlowViewBuilder >> actions [ 
	<return: #Array of: #GtPhlowAction>
	
	^ thisContext
		object: self object 
		perform: self actionsSelector
		withArguments: {self context}
		inClass: self object  class
		
	"^ self object gtActions"
]

{ #category : #accessing }
GtPhlowViewBuilder >> actionsSelector [
	^ actionsSelector ifNil: [
		self defaultActionsSelector ]
]

{ #category : #accessing }
GtPhlowViewBuilder >> actionsSelector: aSelector [
	actionsSelector := aSelector
]

{ #category : #actions }
GtPhlowViewBuilder >> addActionsInto: aView [
	self actions
		do: [ :action | 
			action isDefaultTarget
				ifTrue: [ aView addPhlowAction: action ] ]
]

{ #category : #context }
GtPhlowViewBuilder >> addBuildContext: aView [
	aView buildContext: (GtPhlowBuildContext new
		object: self object;
		arguments: { self view. self context })
]

{ #category : #building }
GtPhlowViewBuilder >> build [
	<return: #GtPhlowView>
	| aView |
	aView := self buildView.
	self addActionsInto: aView.
	^ aView
]

{ #category : #building }
GtPhlowViewBuilder >> buildView [
	<return: #GtPhlowView>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowViewBuilder >> defaultActionsSelector [
	^ #gtActionsInContext:
]

{ #category : #initialization }
GtPhlowViewBuilder >> initialize [
	super initialize.
	self initializePhlowContext.
	self initializePhlowView.
]

{ #category : #factory }
GtPhlowViewBuilder >> labelled [
	^ GtPhlowLabelledViewBuilder new
		builder: self
]

{ #category : #accessing }
GtPhlowViewBuilder >> object [
	^ object
]

{ #category : #accessing }
GtPhlowViewBuilder >> object: anObject [
	"Set an object for which a view will be built"
	object := anObject
]
