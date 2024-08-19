Class {
	#name : #GtPhlowApplyToolSelectionSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'toolElement',
		'phlowView',
		'selectionState'
	],
	#category : #'GToolkit-Phlow-Beacon'
}

{ #category : #'gt - extensions' }
GtPhlowApplyToolSelectionSignal >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Selection state';
			value: self selectionState.
		GtPhlowOverviewItem new
			name: 'Phlow view';
			value: self phlowView.
		GtPhlowOverviewItem new
			name: 'Tool element';
			value: self toolElement}
]

{ #category : #'gt - extensions' }
GtPhlowApplyToolSelectionSignal >> gtOverviewFor: aView [
	<gtView>
	selectionState ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name' text: #name weight: 0.3;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> phlowView [
	^ phlowView
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> phlowView: anObject [
	phlowView := anObject
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> selectionState [
	^ selectionState
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> selectionState: anObject [
	selectionState := anObject
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> toolElement [
	^ toolElement
]

{ #category : #accessing }
GtPhlowApplyToolSelectionSignal >> toolElement: anObject [
	toolElement := anObject
]
