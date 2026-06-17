Class {
	#name : #GtPhlowSelectTabSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'tabGroup',
		'selector',
		'selectedTabModel',
		'requestedTabModel'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #testing }
GtPhlowSelectTabSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #'gt - extensions' }
GtPhlowSelectTabSignal >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Selector';
			value: self selector.
		GtPhlowOverviewItem new
			name: 'Requested tab model';
			value: self requestedTabModel.
		GtPhlowOverviewItem new
			name: 'Selected tab model';
			value: self selectedTabModel.
		GtPhlowOverviewItem new
			name: 'Tab group';
			value: self tabGroup}
]

{ #category : #'gt - extensions' }
GtPhlowSelectTabSignal >> gtOverviewFor: aView [
	<gtView>
	selector ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name' text: #name weight: 0.3;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> requestedTabModel [
	^ requestedTabModel
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> requestedTabModel: anObject [
	requestedTabModel := anObject
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> selectedTabModel [
	^ selectedTabModel
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> selectedTabModel: anObject [
	selectedTabModel := anObject
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> selector [
	^ selector
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowSelectTabSignal >> tabGroup: anObject [
	tabGroup := anObject
]
