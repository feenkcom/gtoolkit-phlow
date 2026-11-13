"
Scripter examples for splitter selection, navigation and change backgrounds in GtMultiSplitterDiffElement.
"
Class {
	#name : #GtMultiSplitterDiffElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #private }
GtMultiSplitterDiffElementExamples >> assertLine: lineIndex in: editorId color: aColor scripter: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the rendered line background';
				// editorId;
				do: [ :editor | self assert: (editor children at: lineIndex) background paint = aColor asBlPaint ] ]
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> assertProgress: aString in: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check change navigation progress';
				// GtDiffButtonsId;
				// BrLabel;
				do: [ :label | self assert: label text asString = aString ] ]
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> assertWhiteEditor: editorId in: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'The editor and unchanged lines remain white';
				// editorId;
				do: [ :editor | 
					self
						assert: editor background paint = BrGlamorousColors diffEditorBackgroundColor asBlPaint.
					self
						assert: editor children first background paint
								= BrGlamorousColors diffEditorBackgroundColor asBlPaint.
					self
						assert: editor children last background paint
								= BrGlamorousColors diffEditorBackgroundColor asBlPaint ] ]
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> deletionOnly [
	<gtExample>
	<return: #BlScripter>
	| scripter previous proposed |
	previous := String cr join: #('heading' 'one two three' 'footer').
	proposed := String cr join: #('heading' 'one two' 'footer').
	scripter := self
			scripterFrom: previous
			to: proposed
			splitters: {self splitters first}.
	self assertWhiteEditor: GtDiffOldTextId in: scripter.
	self assertWhiteEditor: GtDiffNewTextId in: scripter.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: BrGlamorousColors diffDeletedLineBackgroundColor
		scripter: scripter.
	self
		assertLine: 2
		in: GtDiffNewTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self assertProgress: '1/1' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> emptyTexts [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterFrom: ''
			to: ''
			splitters: {GtLineDiffSplitter new}.
	self assertProgress: '0/0' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> identicalTexts [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterFrom: self previousText
			to: self previousText
			splitters: self splitters.
	{GtDiffOldTextId.
		GtDiffNewTextId}
		do: [ :editorId | 
			scripter
				checkStep: [ :s | 
					s
						label: 'Identical content has no colored change regions';
						// editorId;
						do: [ :editor | 
							self
								assert: editor background paint = BrGlamorousColors diffEditorBackgroundColor asBlPaint.
							self
								assert: (editor children
										allSatisfy: [ :line | line background paint = BrGlamorousColors diffEditorBackgroundColor asBlPaint ]) ] ] ].
	self assertProgress: '0/0' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> insertionOnly [
	<gtExample>
	<return: #BlScripter>
	| scripter previous proposed |
	previous := String cr join: #('heading' 'one two' 'footer').
	proposed := String cr join: #('heading' 'one two three' 'footer').
	scripter := self
			scripterFrom: previous
			to: proposed
			splitters: {self splitters first}.
	self assertWhiteEditor: GtDiffOldTextId in: scripter.
	self assertWhiteEditor: GtDiffNewTextId in: scripter.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self
		assertLine: 2
		in: GtDiffNewTextId
		color: BrGlamorousColors diffAddedLineBackgroundColor
		scripter: scripter.
	self assertProgress: '1/1' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> multipleSplitters [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterFrom: self previousText
			to: self proposedText
			splitters: self splitters.
	scripter
		checkStep: [ :s | 
			s
				label: 'Multiple splitters show the selector';
				// #filter;
				do: [ :filter | self assert: filter visibility = BlVisibility visible ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Pane headers identify the comparison';
				// #'diff-container';
				onChildFromBlock: [ :holder | holder children first children first ];
				do: [ :header | 
					self assert: header children first text asString = 'Previous'.
					self assert: header children last text asString = 'Proposed' ] ].
	self assertProgress: '1/2' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> navigateToNextChange [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self multipleSplitters.
	scripter
		clickStep: [ :s | 
			s
				label: 'Go to the next change';
				// GtDiffButtonsId;
				// BrButton;
				@ 2 ].
	self assertProgress: '2/2' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> navigateToPreviousChange [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self navigateToNextChange.
	scripter
		clickStep: [ :s | 
			s
				label: 'Go to the previous change';
				// GtDiffButtonsId;
				// BrButton;
				@ 1 ].
	self assertProgress: '1/2' in: scripter.
	^ scripter
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> previousText [
	^ String cr join: #('heading' 'one two' 'middle' 'four five' 'footer')
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> proposedText [
	^ String cr join: #('heading' 'one two three' 'middle' 'four' 'footer')
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> scripterFrom: previous to: proposed splitters: theSplitters [
	| scripter |
	scripter := BlScripter new.
	scripter extent: 800 @ 400.
	scripter
		element: (GtMultiSplitterDiffElement new
				matchParent;
				background: BrGlamorousColors diffEditorBackgroundColor;
				from: previous;
				to: proposed;
				fromLabel: 'Previous';
				toLabel: 'Proposed';
				splitters: theSplitters;
				yourself).
	scripter
		checkStep: [ :s | 
			s
				label: 'Previous text is displayed';
				// GtDiffOldTextId;
				do: [ :editor | self assert: editor text asString = previous ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Proposed text is displayed';
				// GtDiffNewTextId;
				do: [ :editor | self assert: editor text asString = proposed ] ].
	^ scripter
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> selectSplitterLabeled: aLabel in: aScripter [
	aScripter
		clickStep: [ :s | 
			s
				label: 'Open the splitter menu';
				// GtFilterShortListSettingsElement ].
	aScripter filterStep
		onThisOrBreadthFirstChildOfKind: GtMultiSplitterDiffElement;
		clickOnDropdownFilterItemLabeled: aLabel;
		play
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> singleSplitter [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterFrom: self previousText
			to: self proposedText
			splitters: {self splitters first}.
	scripter
		checkStep: [ :s | 
			s
				label: 'A single splitter hides the selector';
				// #filter;
				do: [ :filter | self assert: filter visibility = BlVisibility gone ] ].
	self assertProgress: '1/2' in: scripter.
	^ scripter
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> splitters [
	^ {GtCharacterGroupDiffSplitter words ignoreWhitespace.
		GtLineDiffSplitter new}
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> switchBackToWordSplitter [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self switchToLineSplitter.
	self selectSplitterLabeled: self splitters first descriptionString in: scripter.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self assertWhiteEditor: GtDiffOldTextId in: scripter.
	self assertWhiteEditor: GtDiffNewTextId in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> switchToLineSplitter [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self multipleSplitters.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: BrGlamorousColors diffUnchangedSideBackgroundColor
		scripter: scripter.
	self
		selectSplitterLabeled: GtLineDiffSplitter new descriptionString
		in: scripter.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: BrGlamorousColors diffDeletedLineBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: BrGlamorousColors diffAddedLineBackgroundColor
		scripter: scripter.
	self assertProgress: '1/2' in: scripter.
	^ scripter
]
