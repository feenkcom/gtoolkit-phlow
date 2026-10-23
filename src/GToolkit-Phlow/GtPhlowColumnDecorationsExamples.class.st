"
Composable decorations with lazy state, shared computed values, nested content, and column lifecycle coverage.
"
Class {
	#name : #GtPhlowColumnDecorationsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> columnedList [
	<gtExample>
	| view element cells calls |
	calls := 0.
	view := GtPhlowView empty columnedList
		items: [ #(0 25 50 75 100) ];
		column: 'Value' numberDo: [ :column |
			column item: [ :value | calls := calls + 1. value ];
				format: [ :value | value asString, '%' ];
				decorate: [ :d |
					d normalizedBar maximum: [ 100 ].
					d border color: Color green ] ].
	element := view asElement.
	element size: 400 @ 240; forceLayout.
	cells := (element query // GtPhlowColumnDecorationElement) all collect: #content.
	self assert: cells size equals: 5.
	self assert: calls equals: 5.
	self assert: (cells collect: #fraction) asArray equals: { 0. 1/4. 1/2. 3/4. 1 }.
	cells do: [ :cell | self assert: cell bar width equals: cell width * cell fraction ].
	^ element
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> compositionAndReuse [
	<gtExample>
	| column cell binder label bar |
	column := GtPhlowNumberColumn new format: [ :value | value asString, ' units' ].
	column decorate: [ :d |
		d normalizedBar maximum: [ 100 ].
		d border color: Color green; width: 2 ].
	cell := column decorations wrap: column createCellElement.
	binder := GtPhlowColumnDecorationsDataBinder new
		decorations: column decorations;
		dataBinder: (MessageSend receiver: column selector: #bindToCellElement:cellObject:atPosition:).
	cell size: 200 @ 30; forceLayout.
	binder cellElement: cell; rowIndex: 1; columnIndex: 1; itemObject: 50; build.
	cell forceLayout.
	bar := cell content.
	label := bar content.
	self assert: label text asString equals: '50 units'.
	self assert: bar fraction equals: 1/2.
	self assert: bar bar width equals: bar width / 2.
	self assert: bar bar width > 0.
	cell width: 400; forceLayout.
	self assert: bar bar width equals: bar width / 2.
	binder cellElement: cell; rowIndex: 2; columnIndex: 1; itemObject: 0; build.
	cell forceLayout.
	self assert: bar bar width equals: 0.
	self assert: label text asString equals: '0 units'.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> divergingBars [
	<gtExample>
	| decoration cell |
	decoration := GtPhlowColumnNormalizedBarDecoration new minimum: [ -100 ]; maximum: [ 300 ].
	cell := decoration wrap: (GtPhlowNumberColumn new createCellElement).
	cell size: 400 @ 30; forceLayout.
	self assert: decoration baselineFraction equals: 1/4.
	decoration bind: cell value: -50 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar position x equals: 50.
	self assert: cell bar width equals: 50.
	decoration bind: cell value: 150 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar position x equals: 100.
	self assert: cell bar width equals: 150.
	decoration bind: cell value: -1/10 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar position x equals: 98.
	self assert: cell bar width equals: 2.
	decoration bind: cell value: 1/10 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar position x equals: 100.
	self assert: cell bar width equals: 2.
	decoration bind: cell value: 0 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar width equals: 0.
	decoration bind: cell value: -500 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar position x equals: 0.
	self assert: cell bar width equals: 100.
	cell width: 800; forceLayout.
	self assert: cell bar width equals: 200.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> errorRecovery [
	<gtExample>
	| column cell binder |
	column := GtPhlowNumberColumn new item: #yourself.
	column decorate: [ :d | d normalizedBar maximum: [ 100 ] ].
	cell := GtPhlowCellElement new content: (column decorations wrap: column createCellElement).
	binder := column computeDecoratedDataBinder: (MessageSend receiver: column selector: #bindToCellElement:cellObject:atPosition:).
	binder cellElement: cell; itemObject: 'invalid'; rowIndex: 1; columnIndex: 1; build.
	self assert: cell exception notNil.
	binder cellElement: cell; itemObject: 50; rowIndex: 2; columnIndex: 1; build.
	self assert: cell exception isNil.
	self assert: cell content fraction equals: 1/2.
	self assert: cell content content text asString equals: '50'.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> lazyBounds [
	<gtExample>
	| decoration minimumCalls maximumCalls |
	minimumCalls := 0.
	maximumCalls := 0.
	decoration := GtPhlowColumnNormalizedBarDecoration new
		minimum: [ minimumCalls := minimumCalls + 1. -100 ];
		maximum: [ maximumCalls := maximumCalls + 1. 300 ].
	self assert: minimumCalls + maximumCalls equals: 0.
	self assert: (decoration fractionFor: 0) equals: 1/4.
	decoration fractionFor: 50.
	self assert: minimumCalls equals: 1.
	self assert: maximumCalls equals: 1.
	decoration minimum: [ minimumCalls := minimumCalls + 1. -300 ].
	self assert: minimumCalls equals: 1.
	self assert: decoration baselineFraction equals: 1/2.
	self assert: maximumCalls equals: 2.
	decoration maximum: [ maximumCalls := maximumCalls + 1. 100 ].
	self assert: decoration baselineFraction equals: 3/4.
	decoration prepareForUpdateContent.
	self assert: (decoration fractionFor: 0) equals: 3/4.
	self assert: minimumCalls equals: 4.
	self assert: maximumCalls equals: 4.
	^ decoration
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> lazyMaximum [
	<gtExample>
	| column bar calls maximum |
	calls := 0.
	maximum := 100.
	column := GtPhlowNumberColumn new.
	column decorate: [ :d | bar := d normalizedBar maximum: [ calls := calls + 1. maximum ] ].
	self assert: calls equals: 0.
	self assert: (bar fractionFor: 50) equals: 1/2.
	self assert: (bar fractionFor: 25) equals: 1/4.
	self assert: calls equals: 1.
	maximum := 200.
	column prepareForUpdateContent.
	self assert: calls equals: 1.
	self assert: (bar fractionFor: 50) equals: 1/4.
	self assert: calls equals: 2.
	^ column
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> listForInspection [
	<gtExample>
	^ (GtPhlowView empty columnedList
		items: [ #(0 25 50 75 100) ];
		column: 'Value' numberDo: [ :column |
			column item: #yourself;
				decorate: [ :d | d normalizedBar maximum: [ 100 ]. d border ] ]) asElement
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> minimumBarWidth [
	<gtExample>
	| decoration cell |
	decoration := GtPhlowColumnNormalizedBarDecoration new maximum: [ 1000 ].
	cell := decoration wrap: (GtPhlowNumberColumn new createCellElement).
	cell size: 100 @ 30; forceLayout.
	decoration bind: cell value: 1 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar width equals: 2.
	decoration bind: cell value: 500 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar width equals: 50.
	decoration bind: cell value: 0 rowIndex: 1 columnIndex: 1.
	cell forceLayout.
	self assert: cell bar width equals: 0.
	decoration bind: cell value: 1 rowIndex: 1 columnIndex: 1.
	cell width: 1; forceLayout.
	self assert: cell bar width equals: 1.
	cell width: 100; forceLayout.
	self assert: cell bar width equals: 2.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> normalization [
	<gtExample>
	| bar |
	bar := GtPhlowColumnNormalizedBarDecoration new maximum: [ 0 ].
	self assert: (bar fractionFor: 0) equals: 0.
	bar maximum: [ 10 ].
	self assert: (bar fractionFor: -5) equals: 0.
	self assert: (bar fractionFor: 20) equals: 1.
	bar fraction: [ :value | value / 20 ].
	self assert: (bar fractionFor: 10) equals: 1/2.
	{ [ -1 ]. [ 'invalid' ]. [ Float infinity ] } do: [ :block |
		bar maximum: block.
		self assert: ([ bar fractionFor: 1. false ] on: Error do: [ :error | true ]) ].
	bar fraction: [ :value | Float nan ].
	self assert: ([ bar fractionFor: 1. false ] on: Error do: [ :error | true ]).
	^ bar
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> ordinaryNumberColumn [
	<gtExample>
	| column cell |
	column := GtPhlowNumberColumn new.
	self assert: column canBeForGtDeclarativeView.
	cell := column createCellElement.
	self assert: cell class equals: BrLabel.
	column bindToCellElement: cell cellObject: 42 atPosition: 1.
	self assert: cell text asString equals: '42'.
	column decorate: [ :d | d border ].
	self assert: column canBeForGtDeclarativeView not.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> projectBalance [
	<gtExample>
	| rows view element cells |
	rows := { 'Atlas' -> -100. 'Beacon' -> -1. 'Cedar' -> 0. 'Delta' -> 1. 'Ember' -> 300 }.
	view := GtPhlowView empty columnedList
		title: 'Project balance';
		items: [ rows ];
		column: 'Project' text: #key;
		column: 'Balance' numberDo: [ :column |
			column item: #value;
				format: [ :value | value asString, ' h' ];
				decorate: [ :d |
					d normalizedBar
						minimum: [ rows inject: 0 into: [ :bound :row | bound min: row value ] ];
						maximum: [ rows inject: 0 into: [ :bound :row | bound max: row value ] ];
						color: (Color blue alpha: 0.18) ] ].
	element := view asElement.
	element size: 600 @ 260; forceLayout.
	cells := (element query // GtPhlowColumnDecorationElement) all.
	self assert: cells size equals: rows size.
	cells do: [ :cell | self assert: cell baselineFraction equals: 1/4 ].
	self assert: cells second bar width equals: 2.
	self assert: cells third bar width equals: 0.
	self assert: cells fourth bar width equals: 2.
	^ element
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> projectMetrics [
	<gtExample>
	| rows view element maximumCalls |
	rows := {
		{ 'Atlas'. 'Platform'. 120. 18. 'Active' }.
		{ 'Beacon'. 'Tools'. 75. 9. 'Review' }.
		{ 'Cedar'. 'Platform'. 200. 24. 'Active' }.
		{ 'Delta'. 'Research'. 40. 3. 'Planned' }.
		{ 'Ember'. 'Tools'. 0. 0. 'Paused' } }.
	maximumCalls := 0.
	view := GtPhlowView empty columnedList
		title: 'Project metrics';
		items: [ rows ];
		column: 'Project' text: [ :row | row first ];
		column: 'Team' text: [ :row | row second ];
		column: 'Hours' numberDo: [ :column |
			column item: [ :row | row third ];
				format: [ :hours | hours asString, ' h' ];
				decorate: [ :d |
					d normalizedBar
						maximum: [ maximumCalls := maximumCalls + 1.
							rows inject: 0 into: [ :maximum :row | maximum max: row third ] ];
						color: (Color blue alpha: 0.18).
					d border color: (Color blue alpha: 0.3); width: 1 ] ];
		column: 'Tasks' numberDo: [ :column | column item: [ :row | row fourth ] ];
		column: 'Status' text: [ :row | row fifth ].
	self assert: maximumCalls equals: 0.
	self assert: view columns size equals: 5.
	element := view asElement.
	element size: 900 @ 300; forceLayout.
	self assert: maximumCalls equals: 1.
	self assert: ((element query // GtPhlowColumnDecorationElement) all collect: [ :outer | outer content fraction ]) asArray
		equals: { 3/5. 3/8. 1. 1/5. 0 }.
	^ element
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> projectMetricsWithoutBorder [
	<gtExample>
	| rows view element maximumCalls cells |
	rows := {
		{ 'Atlas'. 'Platform'. 1200. 18. 'Active' }.
		{ 'Beacon'. 'Tools'. 75. 9. 'Review' }.
		{ 'Cedar'. 'Platform'. 200. 24. 'Active' }.
		{ 'Delta'. 'Research'. 40. 3. 'Planned' }.
		{ 'Ember'. 'Tools'. 1. 1. 'Paused' }.
		{ 'Falco'. 'Tools'. 0. 0. 'Paused' } }.
	maximumCalls := 0.
	view := GtPhlowView empty columnedList
		title: 'Project metrics without borders';
		items: [ rows ];
		column: 'Project' text: [ :row | row first ];
		column: 'Team' text: [ :row | row second ];
		column: 'Hours' numberDo: [ :column |
			column item: [ :row | row third ];
				format: [ :hours | (hours asString, ' h') asRopedText bold ];
				decorate: [ :d |
					d normalizedBar
						maximum: [ maximumCalls := maximumCalls + 1.
							rows inject: 0 into: [ :maximum :row | maximum max: row third ] ];
						color: (Color blue alpha: 0.18) ] ];
		column: 'Tasks' numberDo: [ :column | column item: [ :row | row fourth ] ];
		column: 'Status' text: [ :row | row fifth ].
	self assert: maximumCalls equals: 0.
	self assert: view columns size equals: 5.
	element := view asElement.
	element size: 900 @ 300; forceLayout.
	self assert: maximumCalls equals: 1.
	cells := (element query // GtPhlowColumnDecorationElement) all.
	self assert: cells size equals: rows size.
	self assert: (cells collect: #fraction) asArray equals: { 1. 1/16. 1/6. 1/30. 1/1200. 0 }.
	self assert: (cells collect: [ :cell | cell content text asString ]) asArray
		equals: #('1200 h' '75 h' '200 h' '40 h' '1 h' '0 h').
	cells do: [ :cell |
		| expectedWidth |
		self assert: cell width > 0.
		expectedWidth := cell fraction isZero
			ifTrue: [ 0 ]
			ifFalse: [ ((cell width * cell fraction) max: 2) min: cell width ].
		self assert: cell bar width equals: expectedWidth ].
	self assert: cells fifth width * cells fifth fraction < 2.
	self assert: cells fifth bar width equals: 2.
	self assert: cells last bar width equals: 0.
	^ element
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> reverseComposition [
	<gtExample>
	| column cell binder |
	column := GtPhlowNumberColumn new.
	column decorate: [ :d | d border color: Color green. d normalizedBar maximum: [ 100 ] ].
	cell := column decorations wrap: column createCellElement.
	binder := GtPhlowColumnDecorationsDataBinder new
		decorations: column decorations;
		dataBinder: (MessageSend receiver: column selector: #bindToCellElement:cellObject:atPosition:).
	binder cellElement: cell; itemObject: 50; rowIndex: 1; columnIndex: 1; build.
	self assert: cell fraction equals: 1/2.
	self assert: cell content content text asString equals: '50'.
	^ cell
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> singleSidedBounds [
	<gtExample>
	| decoration |
	decoration := GtPhlowColumnNormalizedBarDecoration new minimum: [ -100 ]; maximum: [ -20 ].
	self assert: decoration baselineFraction equals: 1.
	self assert: (decoration fractionFor: -50) equals: 1/2.
	decoration minimum: [ 20 ]; maximum: [ 100 ].
	self assert: decoration baselineFraction equals: 0.
	self assert: (decoration fractionFor: 50) equals: 1/2.
	decoration minimum: [ 0 ]; maximum: [ 0 ].
	self assert: decoration baselineFraction equals: 0.
	self assert: (decoration fractionFor: 0) equals: 0.
	decoration minimum: [ 10 ]; maximum: [ -10 ].
	self assert: ([ decoration fractionFor: 0. false ] on: Error do: [ :error | true ]).
	decoration minimum: [ Float nan ]; maximum: [ 100 ].
	self assert: ([ decoration fractionFor: 0. false ] on: Error do: [ :error | true ]).
	^ decoration
]

{ #category : #examples }
GtPhlowColumnDecorationsExamples >> textColumn [
	<gtExample>
	| column cell binder |
	column := GtPhlowTextColumn new.
	column decorate: [ :d | d normalizedBar maximum: [ 100 ]. d border ].
	cell := column decorations wrap: column createCellElement.
	binder := GtPhlowColumnDecorationsDataBinder new
		decorations: column decorations;
		dataBinder: (MessageSend receiver: column selector: #bindToCellElement:cellObject:atPosition:);
		cellElement: cell; itemObject: 50; rowIndex: 1; columnIndex: 1.
	binder build.
	self assert: cell content fraction equals: 1/2.
	^ cell
]
