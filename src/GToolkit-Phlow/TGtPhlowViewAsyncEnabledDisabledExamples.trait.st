Trait {
	#name : #TGtPhlowViewAsyncEnabledDisabledExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - async enablement' }
TGtPhlowViewAsyncEnabledDisabledExamples >> asyncDisabled [
	<gtExample>
	| aView anAsyncView |
	aView := self phlowView.
	aView disableAsync.
	self assert: aView isAsyncEnabled not.
	anAsyncView := aView asTaskItView.
	self assert: aView == anAsyncView.
	^ anAsyncView
]

{ #category : #'examples - async enablement' }
TGtPhlowViewAsyncEnabledDisabledExamples >> asyncEnabled [
	<gtExample>
	| aView anAsyncView |
	aView := self phlowView.
	aView enableAsync.
	self assert: aView isAsyncEnabled.
	anAsyncView := aView asTaskItView.
	self assert: anAsyncView class equals: GtPhlowTaskItView.
	self assert: aView ~= anAsyncView.
	^ anAsyncView
]
