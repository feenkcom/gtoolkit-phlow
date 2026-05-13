"
I composte several {{gtClass:GtPhlowTool}} tools in one view.
I use {{gtClass:BrTabGroup}} to display all my sub-tools, see {{gtMethod:GtPhlowCompositeTool>>#asElementDo:|label=#selector}}.
1. # Changing Displayed Objects

{{gtClass:GtPhlowTool}} sub-tools can ask to change observed objects (domain models) in all my sub-tools by {{gtMethod:BlElement>>#fireEvent:|label=firing}} the {{gtClass:GtPhlowToolObjectChangeWish}} event. To this aim, sub-tools should install {{gtClass:GtPhlowToolChangedObjectHandler}} which asks for objects (domain models) that a user wish to observe by individual {{gtClass:GtPhlowTool}} sub-tools. We recomend to install the handler in an overriden {{gtMethod:GtPhlowAbstractTool>>#asTabElement|label=#selector}} method since the handler is not useful if a tool is used alone (not composed by me).
1. ## Shared Object Example

In the following example, you can increase the displayed value by clicking on the plus button. The changes are properly reflected in both tabs: {{gtExample:GtPhlowCompositeToolExamples>>#compositeTool|codeExpanded=false|previewExpanded=true}} 


"
Class {
	#name : #GtPhlowCompositeTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'tools',
		'toolName'
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

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> addTools: aCollection [
	aCollection do: [ :aTool |
		self addTool: aTool ]
]

{ #category : #'api - converting' }
GtPhlowCompositeTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| aTabGroup |
	
	aTabGroup := BrTabGroup new
		id: #'Composite Tool';
		aptitude: BrGlamorousTabGroupSwitcherAptitude;
		addTabs: self toolTabs.
	aTabGroup addEventHandler: GtPhlowToolObjectChangeHandler new.
	aTabGroup addEventHandler: (GtPhlowToolUpdateEventHandler new onUpdateSend: #onCompositeUpdateWish: to: GtPhlowToolInParentUpdater new).
	aTabGroup phlow toolViewModel: (GtPhlowToolCompositeViewModel new tabGroup: aTabGroup).
	
	^ aOneArgBlock cull: aTabGroup
]

{ #category : #selection }
GtPhlowCompositeTool >> basicExtractSelectionStateFromElement: aTabGroupElement [
	| selectedToolTabIdentifier containedToolElement containedToolContext |
	selectedToolTabIdentifier := (GtPhlowCompositeToolSelectedTabExtractor new
			tabGroupElement: aTabGroupElement) extractTabIdentifier.

	containedToolElement := aTabGroupElement content children
			ifNotEmpty: #first
			ifEmpty: [ ^ GtPhlowToolNullSelectionState uniqueInstance ].
	containedToolContext := containedToolElement phlow.

	^ GtPhlowCompositeToolSelectionState new
		selectedToolTabIdentifier: selectedToolTabIdentifier;
		selectedToolSelectionState: (containedToolContext entity
				ifNotNil: [ :anEntity | anEntity extractSelectionStateFromElement: containedToolElement ]
				ifNil: [ GtPhlowToolNullSelectionState uniqueInstance ])
]

{ #category : #defaults }
GtPhlowCompositeTool >> defaultTools [
	^ Array empty
]

{ #category : #'api - converting' }
GtPhlowCompositeTool >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		tools: self tools copy;
		addTool: (GtPhlowTool default object: self)
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
	^ toolName ifNil: [ 
		tools 
			ifEmpty: ['composite'] 
			ifNotEmpty: [ :currentTools |
				currentTools first name 
					ifNil: [ 'composite' ] ]]
]

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> name: aName [
	toolName := aName
]

{ #category : #'api - accessing' }
GtPhlowCompositeTool >> object [
	^ self tools
		ifEmpty: [ super object ]
		ifNotEmpty: [ :aCollection | aCollection anyOne object ]
]

{ #category : #action }
GtPhlowCompositeTool >> prepareForReusedNavigation [
	self tools do: [ :aTool |
		aTool prepareForReusedNavigation ]
]

{ #category : #'testing ' }
GtPhlowCompositeTool >> supportsSelectionHandling [
	"Composite tools know how to extract and restore the selected tool"
	^ true
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
