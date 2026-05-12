Class {
	#name : #GtPhlowDetailsView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'rows'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowDetailsView >> asElementDo: aBlockClosure [
	| grid cells header |
	grid := BrHorizontalGrid new.
	grid columnCount: 2.
	grid cellSpacing: 0.
	grid hMatchParent.
	grid vFitContent.
	header :=
			{self createHeaderCell: 'Name'.
			self createHeaderCell: 'Value'}.
	cells := rows flatCollect: 
					[:eachRow |
					
					 | rowName rowValue |
					 rowName := self createRowName: eachRow.
					 rowValue := self createRowValue: eachRow.
					 
					 self configureRowName: rowName value: rowValue.
					
					{ rowName . rowValue}].
	grid addChildren: header.
	grid addChildren: cells.
	grid := grid asScrollableElement.
	self beViewElement: grid.
	^aBlockClosure value: grid
]

{ #category : #'api - converting' }
GtPhlowDetailsView >> configureRowName: rowNameLabel value: rowValueLabel [
	| clickHandler eventSharer|
	
	clickHandler := BlEventHandler on: BlClickEvent
				do: 
					[:anEvent |
					anEvent consumed: true.
					self inform: 'Spawn!'.
					rowValueLabel phlow spawnObject: rowValueLabel viewModel model].
	
	eventSharer := BlSharedEventDistributor shareEvents: {
		BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlDragLeaveEvent.
		BlDragEndEvent }.
	
	rowNameLabel addEventHandler: eventSharer.
	rowValueLabel addEventHandler: eventSharer.
	
	rowNameLabel addEventHandler: clickHandler.
	rowValueLabel addEventHandler: clickHandler
]

{ #category : #'api - converting' }
GtPhlowDetailsView >> createHeaderCell: aString [
	^ (BrLabel new)
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				hFitContent;
				padding: (BlInsets top: 3 left: 6 bottom: 3 right: 6);
				text: aString
]

{ #category : #'api - converting' }
GtPhlowDetailsView >> createRowName: eachRow [
	^(BrLabel new)
		aptitude: (BrGlamorousLabelAptitude + BrGlamorousListItemAptitude);
		hFitContent;
		padding: (BlInsets top: 3 left: 6 bottom: 3 right: 6);
		constraintsDo: [ :c | c grid horizontal specAlignment: BlGridAlignment fill ];
		text: eachRow name
]

{ #category : #'api - converting' }
GtPhlowDetailsView >> createRowValue: eachRow [
	| value text |
	value := eachRow valueComputation value.
	text := eachRow textComputation value: value.
	^(BrLabel new)
		in: [:aLabel | aLabel viewModel model: value];
		aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude;
		hMatchParent;
		padding: (BlInsets
					top: 3
					left: 6
					bottom: 3
					right: 6);
		text: text
]

{ #category : #views }
GtPhlowDetailsView >> gtRowsFor: aView [
	<gtView>
	rows ifNil: [^aView empty].
	^(aView columnedList)
		title: 'Rows';
		priority: 11;
		items: [rows];
		column: 'Name' text: [:each | each name ];
		column: 'Value' text: [:each | each valueComputation ];
		column: 'Text' text: [:each | each textComputation ]
]

{ #category : #initialization }
GtPhlowDetailsView >> initialize [
	super initialize.
	
	rows := OrderedCollection new
]

{ #category : #'as yet unclassified' }
GtPhlowDetailsView >> row: aString value: aBlockClosure [
	rows add: (GtPhlowDetailsRow new
		name: aString;
		valueComputation: aBlockClosure)
]

{ #category : #'as yet unclassified' }
GtPhlowDetailsView >> row: aString value: aValueComputation text: aTextComputation [
	rows add: (GtPhlowDetailsRow new
		name: aString;
		valueComputation: aValueComputation;
		textComputation: aTextComputation)
]
