Trait {
	#name : #TGtPhlowToolViewModel,
	#category : #'GToolkit-Phlow-Tool - Navigation'
}

{ #category : #'api - accessing' }
TGtPhlowToolViewModel >> element [
	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TGtPhlowToolViewModel >> gtOverview [
	^ {
		GtPhlowOverviewItem new
			name: 'Tool type';
			value: self type.
		GtPhlowOverviewItem new
			name: 'Tool element';
			value: self element.
		GtPhlowOverviewItem new
			name: 'Tool view model';
			value: self viewModel.
		GtPhlowOverviewItem new
			name: 'Tool model object';
			value: self object}
]

{ #category : #'gt - extensions' }
TGtPhlowToolViewModel >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name'
			text: #name
			weight: 0.3;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #'api - accessing' }
TGtPhlowToolViewModel >> object [
	^ self explicitRequirement
]

{ #category : #'api - accessing' }
TGtPhlowToolViewModel >> type [
	<return: #TGtPhlowToolType>
	^ self explicitRequirement
]

{ #category : #'api - accessing' }
TGtPhlowToolViewModel >> viewModel [
	^ self explicitRequirement
]
