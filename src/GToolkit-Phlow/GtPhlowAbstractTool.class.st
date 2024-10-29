Class {
	#name : #GtPhlowAbstractTool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #testing }
GtPhlowAbstractTool class >> isAbstract [
	^ self name = #GtPhlowAbstractTool 
]

{ #category : #selection }
GtPhlowAbstractTool >> applySelectionState: aSelectionState toElement: aToolElement [
	self supportsSelectionHandling ifFalse: [ ^ self ].

	(aSelectionState appliesToTool: self) ifFalse: [ ^ self ].
	
	GtPhlowApplyToolSelectionSignal new
		toolElement: aToolElement;
		phlowView: self;
		selectionState: aSelectionState;
		emit.
	
	self basicApplySelectionState: aSelectionState toElement: aToolElement
]

{ #category : #'api - converting' }
GtPhlowAbstractTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	self subclassResponsibility
]

{ #category : #'api - converting' }
GtPhlowAbstractTool >> asTabDo: aBlock [
	| toolTab |
	toolTab := BrTab new
		aptitude: self tabLook;
		label: self name;
		icon: self icon;
		stencil: [ 
			self asTabElement ].
	
	toolTab phlow 
		beToolLabel; 
		entity: self.
	
	aBlock cull: toolTab cull: self.
]

{ #category : #'private - converting' }
GtPhlowAbstractTool >> asTabElement [
	"Return a tool element that is going to be used as a part of ${class:GtPhlowCompositeTool}$"
	<return: #BlElement>
	^ self asToolElementDo: [ :anElement | 
		anElement ]
]

{ #category : #'api - converting' }
GtPhlowAbstractTool >> asToolElementDo: aOneArgBlock [
	"Create a properly initialized tool element"
	self subclassResponsibility
]

{ #category : #selection }
GtPhlowAbstractTool >> basicApplySelectionState: aSelectionState toElement: aToolElement [
	"Default way to apply the selection to a tool element."
	aSelectionState applySelectionStateToElement: aToolElement
]

{ #category : #selection }
GtPhlowAbstractTool >> basicExtractSelectionStateFromElement: aToolElement [
	"Subclasses should override this method to change how the current selection state is extracted from the given element. This should just be called if #supportsSelectionHandling returns true."
	
	self assert: [ self supportsSelectionHandling ].
	
	^ aToolElement extractToolSelectionState
]

{ #category : #configuring }
GtPhlowAbstractTool >> beToolContentElement: anElement [
	"Set up a given element to play a role of a tool element."

	"anElement phlow 
		beToolContent;
		entity: self."
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> context: aPhlowContext [
	"Tools may use the given phlow context"

	
]

{ #category : #selection }
GtPhlowAbstractTool >> extractSelectionStateFromElement: aToolElement [
	self supportsSelectionHandling ifFalse: [ 
		^ GtPhlowToolNullSelectionState uniqueInstance  ].
	
	^ (self basicExtractSelectionStateFromElement: aToolElement)
		targetToolIdentifier: self toolTabIdentifier;
		yourself
]

{ #category : #accessing }
GtPhlowAbstractTool >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: self;
		addTool: super gtDefaultInspectorTool
]

{ #category : #'gt-extension' }
GtPhlowAbstractTool >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			| aContainer |
			aContainer := BrFrame new
				matchParent;
				padding: (BlInsets all: 20).
			self asElementDo: [ :anElement | 
				aContainer addChild: anElement ].
			aContainer ]
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> icon [
	"Return a tool icon"
	<return: #BlElement>
	^ BrGlamorousVectorIcons inspect 
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> name [
	"Return a tool name"
	<return: #String or: #BlText>
	^ self class name
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> object [
	"compatibility method for ${GLMBlocObjectToSelect}$"
	^ self
]

{ #category : #'api - accessing' }
GtPhlowAbstractTool >> object: anObject [
	"defaults tools must implement this message"
]

{ #category : #action }
GtPhlowAbstractTool >> prepareForReusedNavigation [
	"This tool is about to be reused in a navigation phlow.
	Give specific tools a chance to reset cached data, or 
	perform other clean-ups."
]

{ #category : #'testing ' }
GtPhlowAbstractTool >> supportsSelectionHandling [
	"Indicates whether or not this tool can extract and restore its selection"
	^ false
]

{ #category : #'private - accessing' }
GtPhlowAbstractTool >> tabLook [
	"Return a look to display tab tool"
	^ BrGlamorousTabSwitcherWithLabelAptitude
]

{ #category : #accessing }
GtPhlowAbstractTool >> toolTabIdentifier [
	^ GtPhlowToolTabIdentifier forTool: self
]
