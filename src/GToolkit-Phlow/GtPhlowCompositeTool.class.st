Class {
	#name : #GtPhlowCompositeTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'tools'
	],
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> addTool: aGtPhlowTool [
	self 
		assert: [ aGtPhlowTool isNotNil ] 
		description: [ 'Phlow tool must be non-nil' ].
	self tools: (self tools copyWith: aGtPhlowTool)
]

{ #category : #'api - converting' }
GtPhlowCompositeTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| aTabGroup |
	aTabGroup := BrTabGroup new
		labeled: 'Composite Tool';
		look: BrGlamorousTabGroupSwitcherWithHiddenSelectedTabLook;
		addTabs: self toolTabs.
	^ aOneArgBlock cull: aTabGroup
]

{ #category : #defaults }
GtPhlowCompositeTool >> defaultTools [
	^ Array empty
]

{ #category : #accessing }
GtPhlowCompositeTool >> gtToolsFor: aView [
	<gtView>
	self tools ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Tools';
		priority: 2;
		items: [ self tools ]
]

{ #category : #initialization }
GtPhlowCompositeTool >> initialize [
	super initialize.
	tools := self defaultTools.
]

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> name [
	^ 'composite'
]

{ #category : #'private - instance creation' }
GtPhlowCompositeTool >> toolTab: aGtPhlowTool into: aStream [
	aGtPhlowTool asTabDo: [ :aTab | 
		aStream nextPut: aTab ]
]

{ #category : #'private - instance creation' }
GtPhlowCompositeTool >> toolTabs [
	<return: #Array of: #BrTab>
	^ Array 
		new: self tools size 
		streamContents: [ :aStream | 
			self toolTabsInto: aStream ]
]

{ #category : #'private - instance creation' }
GtPhlowCompositeTool >> toolTabsInto: aStream [
	self tools do: [ :eachTool | 
		self toolTab: eachTool into: aStream ]
]

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> tools [
	<return: #Array of: #GtPhlowTool>
	^ tools
]

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> tools: aGtPhlowTool [
	self 
		assert: [ aGtPhlowTool isNotNil ] 
		description: [ 'Phlow tool must be non-nil' ].
	tools := aGtPhlowTool
]
