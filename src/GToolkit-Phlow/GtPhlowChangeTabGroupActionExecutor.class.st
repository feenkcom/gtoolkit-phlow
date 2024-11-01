Class {
	#name : #GtPhlowChangeTabGroupActionExecutor,
	#superclass : #GtPhlowChangeActionExecutor,
	#instVars : [
		'tabGroup',
		'updatingFuture',
		'actions',
		'mutex',
		'configuration'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #private }
GtPhlowChangeTabGroupActionExecutor >> actions [
	^ mutex critical: [ actions values ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupActionExecutor >> configuration [
	<return: #AsyncFutureExecutionConfiguration>
	^ configuration ifNil: [ configuration := self defaultConfiguration ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupActionExecutor >> configuration: aFutureExecutionConfiguration [
	configuration := aFutureExecutionConfiguration
]

{ #category : #initialization }
GtPhlowChangeTabGroupActionExecutor >> defaultConfiguration [
	^ GtPhlowUtility defaultFutureExecutionConfiguration
]

{ #category : #'gt - extensions' }
GtPhlowChangeTabGroupActionExecutor >> gtActionsFor: aView [
	<gtView>
	actions ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Actions';
		items: [ self actions ];
		column: 'Method selector'
			text: [ :anAction | anAction changeContext affectedMethodSelector ];
		column: 'Action' text: [ :anAction | anAction changeAction ] weight: 2;
		actionUpdateButton
]

{ #category : #initialization }
GtPhlowChangeTabGroupActionExecutor >> initialize [
	super initialize.

	mutex := Mutex new.
	actions := Dictionary new
]

{ #category : #private }
GtPhlowChangeTabGroupActionExecutor >> newSubmittedAction [
	^ GtPhlowChangeSubmittedAction new
		elementFuture: (BrAsyncElementFuture new
				element: self tabGroup;
				cancelSoft;
				executionConfiguration: self configuration;
				whenSuccess: [ :aTabGroup :anAction | anAction execute ])
]

{ #category : #private }
GtPhlowChangeTabGroupActionExecutor >> removeSubmittedAction: aSubmittedAction context: aChangeContext [
	mutex critical: [ 
		aSubmittedAction changeContext == aChangeContext ifTrue: [
			actions 
				removeKey: aChangeContext affectedMethodSelector
				ifAbsent: [ "ignore" ] ] ]
]

{ #category : #'api - execution' }
GtPhlowChangeTabGroupActionExecutor >> submit: aChangeAction context: aChangeContext [
	self tabGroup ifNil: [ ^ self ].
	
	mutex critical: [ 
		| aSubmittedAction anActionFuture aFuture |
		aSubmittedAction := actions 
			at: aChangeContext affectedMethodSelector
			ifAbsentPut: [ self newSubmittedAction ].
		aSubmittedAction 
			changeAction: aChangeAction;
			changeContext: aChangeContext.
		anActionFuture := [ aChangeAction prepareOn: aChangeContext ] asAsyncFuture.
		aFuture := anActionFuture map: [ :aResult | 
			self removeSubmittedAction: aSubmittedAction context: aChangeContext.
			aResult ].
		aSubmittedAction elementFuture future: aFuture ]
]

{ #category : #accessing }
GtPhlowChangeTabGroupActionExecutor >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupActionExecutor >> tabGroup: aBrTabGroup [
	tabGroup := aBrTabGroup
]
