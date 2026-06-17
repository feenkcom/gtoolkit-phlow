Class {
	#name : #GtPhlowTabSelector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #factory }
GtPhlowTabSelector class >> byViewMethod [
	^ GtPhlowTabByViewMethodSelector new
]

{ #category : #factory }
GtPhlowTabSelector class >> byViewName [
	^ GtPhlowTabByViewNameSelector new
]

{ #category : #testing }
GtPhlowTabSelector class >> isAbstract [
	^ self name = #GtPhlowTabSelector 
]

{ #category : #actions }
GtPhlowTabSelector >> matchesTab: aTabGroup [ 
	self subclassResponsibility
]

{ #category : #actions }
GtPhlowTabSelector >> selectTabInGroup: aTabGroupElement on: anObject [
	<return: #GtPhlowToolSelectionStateResponse>
	^ aTabGroupElement viewModel tabs
		detect: [ :aTabModel | 
			self matchesTab: aTabModel ]
		ifFound: [ :aTabModel |
			| aSignal |
			aSignal := GtPhlowSelectTabSignal new
				tabGroup: aTabGroupElement;
				requestedTabModel: aTabModel;
				selector: self;
				emit.
			
		 	aTabModel select.
		 	
		 	aTabGroupElement viewModel selectedTabDo: [ :aTab |
		 		aSignal selectedTabModel: aTabModel ].
		 		
		 	GtPhlowToolSelectionStateResponse applied ]
		ifNone: [ GtPhlowToolSelectionStateResponse notApplied ]
]

{ #category : #actions }
GtPhlowTabSelector >> selectTabInInspectorElement: anInspectorElement on: anObject [
	<return: #GtPhlowToolSelectionStateResponse>
	anInspectorElement phlow
		firstChildWithCompositeViewContentDo: [ :aTabGroupElement | 
			^ self selectTabInGroup: aTabGroupElement on: anObject ].
			
	^ GtPhlowToolSelectionStateResponse notApplied
]
