Class {
	#name : #GtPhlowExplicitCompositeTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'compositeToolStencil',
		'lastCompositeTool',
		'toolName',
		'toolIcon'
	],
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - converting' }
GtPhlowExplicitCompositeTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."

	| anElement |
	anElement := [ lastCompositeTool := compositeToolStencil create.
		self
			assert: [ lastCompositeTool isKindOf: GtPhlowCompositeTool ]
			description: [ 'Composite tool must be kind of {1}, but is: {2}' 
				format: { GtPhlowCompositeTool. lastCompositeTool } ].
		lastCompositeTool asElement ]
			onErrorDo: [ :anError | anError asDebuggableElement ].
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Explicit composite tool must create an element on #asElementDo: call' ].

	^ aOneArgBlock cull: anElement cull: self
]

{ #category : #selection }
GtPhlowExplicitCompositeTool >> basicExtractSelectionStateFromElement: aTabGroupElement [
	self lastCompositeToolDo: [ :aCompositeTool | 
		^ aCompositeTool basicExtractSelectionStateFromElement: aTabGroupElement ].

	^ GtPhlowToolNullSelectionState uniqueInstance 
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> compositeToolStencil [
	^ compositeToolStencil
]

{ #category : #views }
GtPhlowExplicitCompositeTool >> gtToolsFor: aView [
	<gtView>
	self tools ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Tools';
		priority: 2;
		items: [ self tools ]
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> icon [
	^ toolIcon ifNil: [ super icon ]
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> icon: anIconStencil [
	toolIcon := anIconStencil asStencil
]

{ #category : #'private - converting' }
GtPhlowExplicitCompositeTool >> initialize [
	super initialize.
	compositeToolStencil := [ GtPhlowCompositeTool new ] asStencil.
	toolName := 'composite'.
	toolIcon := nil
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> lastCompositeTool [
	<return: #GtPhlowCompositeTool or: nil>
	^ lastCompositeTool
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> lastCompositeToolDo: aBlock [
	lastCompositeTool ifNotNil: aBlock
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> name [
	^ toolName ifNil: [ 
		lastCompositeTool
			ifNil: [ 'composite' ]
			ifNotNil: [ :aCompositeTool | aCompositeTool name ifNil: [ 'composite' ] ] ]
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> object [
	self lastCompositeToolDo: [ :aTool |
		^ aTool object ].
		
	^ super object
]

{ #category : #copying }
GtPhlowExplicitCompositeTool >> postSimilarToolCopy [
	lastCompositeTool := nil.
	super postSimilarToolCopy
]

{ #category : #action }
GtPhlowExplicitCompositeTool >> prepareForReusedNavigation [
	self lastCompositeToolDo: [ :aTool |
		aTool prepareForReusedNavigation ]
]

{ #category : #testing }
GtPhlowExplicitCompositeTool >> supportsSelectionHandling [
	"Indicates whether or not this tool can extract and restore its selection"

	self lastCompositeToolDo: [ :aTool | ^ aTool supportsSelectionHandling ].

	^ false
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> toolStencil: aStencil [
	"Stencil must return a `GtPhlowCompositeTool` on #create calls."

	compositeToolStencil := aStencil asStencil
]

{ #category : #accessing }
GtPhlowExplicitCompositeTool >> tools [
	<return: #Array of: #GtPhlowTool>
	self lastCompositeToolDo: [ :aCompositeTool | ^ aCompositeTool tools ].

	^ Array empty
]
