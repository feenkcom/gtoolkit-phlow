"
I am an example object exposing multiple tool views and tool actions for {{gtClass:GtPhlowMultipleViewsContentElement}} examples.
"
Class {
	#name : #GtMultipleViewsForExamplesObject,
	#superclass : #Object,
	#instVars : [
		'counter',
		'log'
	],
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #accessing }
GtMultipleViewsForExamplesObject >> counter [
	^ counter
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> gtActionIncrementWithCurrentToolUpdateFor: anAction [
	<gtToolAction>
	
	^ anAction button
		id: #incrementActionWithCurrentToolUpdate;
		icon: BrGlamorousVectorIcons add;
		label: 'Increment';
		tooltip: 'Increment with current tool update';
		priority: 10;
		action: [ :aButton | 
			self incrementCounter.
			aButton phlow fireCurrentToolUpdateWish ]
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> gtActionRefreshFor: anAction [
	<gtToolAction>
	
	^ anAction button
		id: #refreshContentAction;
		icon: BrGlamorousVectorIcons refresh;
		label: 'Refresh';
		tooltip: 'Refresh current tool';
		priority: 20;
		action: [ :aButton | 
			aButton phlow fireCurrentToolUpdateWish ]
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> gtActionSpanObjectCopyFor: anAction [
	<gtAction>
	
	^ anAction button
		id: #copyObject;
		priority: 15;
		icon: BrGlamorousVectorIcons changes;
		label: 'Spawn object copy';
		tooltip: 'Spawn a new copy of the object';
		target: GtMultipleViewsForExamplesObjectDefaultToolTarget;
		menuItemGroup: BrMenuItemGroupConfiguration editing;
		"menuItemPreview: [ self basename ];"
		action: [ :aButton | 
			aButton phlow spawnObject: self copy ]
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> gtActionSpanObjectNewFor: anAction [
	<gtAction>
	
	^ anAction button
		id: #createNewObject;
		priority: 20;
		icon: BrGlamorousVectorIcons changes;
		label: 'Spawn new object';
		tooltip: 'Spawn a new copy of the object';
		target: GtMultipleViewsForExamplesObjectDefaultToolTarget;
		menuItemGroup: BrMenuItemGroupConfiguration editing;
		"menuItemPreview: [ self basename ];"
		action: [ :aButton | 
			aButton phlow spawnObject: self class new ]
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> gtActionsExtraDropdownFor: anAction [
	<gtToolAction>
	
	^ anAction dropdown
		tooltip: 'Extra actions';
		icon: BrGlamorousVectorIcons hamburger;
		id: #extraObjectActions;
		priority: 100;
		menuItemsForObject: self fromTarget: GtMultipleViewsForExamplesObjectDefaultToolTarget
]

{ #category : #inspector }
GtMultipleViewsForExamplesObject >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
			addTool: (GtMultipleViewsForExamplesPhlowTool new
				object: self) ;
			addTool: super gtDefaultInspectorTool
]

{ #category : #views }
GtMultipleViewsForExamplesObject >> gtLogFor: aView [
	<gtToolView>
	^ aView list
		title: 'Log';
		priority: 20;
		items: [ self log ifEmpty: [ #('No actions yet') ] ifNotEmpty: [ self log ] ];
		itemText: [ :each | each ]
]

{ #category : #views }
GtMultipleViewsForExamplesObject >> gtSummaryFor: aView [
	<gtToolView>
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [
			{
				{'Counter'. self counter asString}.
				{'Log size'. self log size asString} } ];
			column: 'Property' text: [ :each | each first ];
			column: 'Value' text: [ :each | each second ]
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> incrementCounter [
	counter := counter + 1.
	log add: 'incremented to ', counter asString.
]

{ #category : #initialization }
GtMultipleViewsForExamplesObject >> initialize [
	super initialize.
	self resetData.
]

{ #category : #accessing }
GtMultipleViewsForExamplesObject >> log [
	^ log
]

{ #category : #actions }
GtMultipleViewsForExamplesObject >> postCopy [
	log := log copy
]

{ #category : #initialization }
GtMultipleViewsForExamplesObject >> resetData [
	counter := 0.
	log := OrderedCollection new.
]
