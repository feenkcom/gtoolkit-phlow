"
Scripter examples for {{gtClass:GtMultiSplitterDiffElement}}: splitter selector visibility, switching splitters, label delegation and preservation of the inner diff element. Standalone diff rendering and navigation examples are in {{gtClass:GtDiffElementExamples}}.
"
Class {
	#name : #GtMultiSplitterDiffElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #private }
GtMultiSplitterDiffElementExamples >> assertLabels: fromText and: toText in: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'The previous label is displayed';
				// GtDiffOldLabelId;
				do: [ :label | self assert: label text asString = fromText ] ].
	aScripter
		checkStep: [ :s | 
			s
				label: 'The proposed label is displayed';
				// GtDiffNewLabelId;
				do: [ :label | self assert: label text asString = toText ] ]
]

{ #category : #private }
GtMultiSplitterDiffElementExamples >> assertLine: lineIndex in: editorId color: aColor scripter: aScripter [
	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the rendered line background';
				// editorId;
				do: [ :editor | 
					self
						assert: ((editor children at: lineIndex) background paint color
								blocResolveColorForTheme: editor theme)
								= (aColor blocResolveColorForTheme: editor theme) ] ]
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
					| color |
					color := editor theme diffElement editorBackgroundColor
							blocResolveColorForTheme: editor theme.
					self
						assert: (editor background paint color blocResolveColorForTheme: editor theme) = color.
					self
						assert: (editor children first background paint color
								blocResolveColorForTheme: editor theme) = color.
					self
						assert: (editor children last background paint color
								blocResolveColorForTheme: editor theme) = color ] ]
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> contentKeepsLabels [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self labelsBeforeContent.
	scripter
		doStep: [ :s | 
			s
				label: 'Supply content after the labels';
				block: [ :element | 
					element
						from: self previousText;
						to: self proposedText;
						splitters: self splitters ] ].
	self
		assertLabels: 'Before'
		and: 'After'
		in: scripter.
	self assertProgress: '1/2' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> labelsBeforeContent [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := BlScripter new.
	scripter extent: 800 @ 400.
	scripter
		element: (GtMultiSplitterDiffElement new
				matchParent;
				fromLabel: 'Before';
				toLabel: 'After';
				yourself).
	self
		assertLabels: 'Before'
		and: 'After'
		in: scripter.
	self assertProgress: '0/0' in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> labelsUpdateAfterRendering [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self multipleSplitters.
	scripter
		doStep: [ :s | 
			s
				label: 'Update both labels on the multi-splitter diff';
				block: [ :element | 
					element
						fromLabel: 'Before';
						toLabel: 'After' ] ].
	self
		assertLabels: 'Before'
		and: 'After'
		in: scripter.
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
	self
		assertLabels: 'Previous'
		and: 'Proposed'
		in: scripter.
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
				background: BlTheme default diffElement editorBackgroundColor;
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
		color: scripter element theme diffElement unchangedSideBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: scripter element theme diffElement unchangedSideBackgroundColor
		scripter: scripter.
	self assertWhiteEditor: GtDiffOldTextId in: scripter.
	self assertWhiteEditor: GtDiffNewTextId in: scripter.
	^ scripter
]

{ #category : #examples }
GtMultiSplitterDiffElementExamples >> switchSplitterKeepsLabelsAndElement [
	<gtExample>
	<return: #BlScripter>
	| scripter originalDiff |
	scripter := self labelsUpdateAfterRendering.
	scripter
		checkStep: [ :s | 
			s
				label: 'Keep the current diff element';
				// GtDiffElement;
				do: [ :diff | originalDiff := diff ] ].
	self
		selectSplitterLabeled: GtLineDiffSplitter new descriptionString
		in: scripter.
	scripter
		checkStep: [ :s | 
			s
				label: 'Switching splitters reuses the diff element';
				// GtDiffElement;
				do: [ :diff | self assert: diff == originalDiff ] ].
	self
		assertLabels: 'Before'
		and: 'After'
		in: scripter.
	self assertProgress: '1/2' in: scripter.
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
		color: scripter element theme diffElement unchangedSideBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: scripter element theme diffElement unchangedSideBackgroundColor
		scripter: scripter.
	self
		selectSplitterLabeled: GtLineDiffSplitter new descriptionString
		in: scripter.
	self
		assertLine: 2
		in: GtDiffOldTextId
		color: scripter element theme diffElement deletedLineBackgroundColor
		scripter: scripter.
	self
		assertLine: 4
		in: GtDiffNewTextId
		color: scripter element theme diffElement addedLineBackgroundColor
		scripter: scripter.
	self assertProgress: '1/2' in: scripter.
	self
		assertLabels: 'Previous'
		and: 'Proposed'
		in: scripter.
	^ scripter
]
