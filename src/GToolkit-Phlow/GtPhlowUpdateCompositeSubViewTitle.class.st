Class {
	#name : #GtPhlowUpdateCompositeSubViewTitle,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'subView'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #comparing }
GtPhlowUpdateCompositeSubViewTitle >> = anObject [
	^ super = anObject and: [ 
		self subView = anObject subView ]
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitle >> basicRemoveTabModel: aTabModel [
	self element viewModel removeTab: aTabModel.
	self view views remove: self subView ifAbsent: [ "ignore" ].
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitle >> basicUpdateTabModel: aTabModel with: aNewSubView [
	| anIndex |
	aTabModel widget label: aNewSubView title value asRopedText.
	anIndex := self view views indexOf: self subView.
	self view views at: anIndex put: aNewSubView
]

{ #category : #'accessing - ui' }
GtPhlowUpdateCompositeSubViewTitle >> detectTab [
	^ self element viewModel tabs 
		detect: [ :eachTabModel | (eachTabModel widget phlow entity = self subView)
			or: [ eachTabModel widget phlow entity definingMethod = self subViewDefiningMethod ] ]
		ifFound: [ :aTabModel | aTabModel ]
		ifNone: [ nil "Trying to find a tab that does not exist" ].
]

{ #category : #evaluating }
GtPhlowUpdateCompositeSubViewTitle >> execute [
	<return: #GtPhlowView>
	| aTabModel aNewSubView |
	aTabModel := self detectTab.
	aTabModel ifNil: [ ^ self ].
	aNewSubView := self newPhlowSubView.
	aNewSubView ifItHasContent: [
		self updateTabModel: aTabModel with: aNewSubView.
		^ aNewSubView ].
	self removeTabModel: aTabModel.
	^ aNewSubView
]

{ #category : #comparing }
GtPhlowUpdateCompositeSubViewTitle >> hash [
	^ super hash bitXor: self subView hash
]

{ #category : #'instance creation' }
GtPhlowUpdateCompositeSubViewTitle >> newPhlowSubView [
	^ GtPhlowView empty
		on: self subViewObject
		perform: self subViewMethodSelector
		withSomeArguments: self subViewArguments
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitle >> removeTabModel: aTabModel [
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			self element enqueueTask: (BlTaskAction new action: [
				self basicRemoveTabModel: aTabModel ]) ]
		otherwise: [
				self basicRemoveTabModel: aTabModel ]
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewTitle >> subView [
	^ subView
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewTitle >> subView: anObject [
	subView := anObject
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitle >> subViewArguments [
	^ self subViewBuildContext arguments
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitle >> subViewBuildContext [
	^ self subView buildContext
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitle >> subViewDefiningMethod [
	^ self subView definingMethod
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitle >> subViewMethodSelector [
	^ self subView methodSelector
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitle >> subViewObject [
	^ self subViewBuildContext object
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitle >> updateTabModel: aTabModel with: aNewSubView [
	BlUseAsyncFeatures
		ifEnabledDo: [ self element enqueueTask: (BlTaskAction new
			action: [ self basicUpdateTabModel: aTabModel with: aNewSubView ]) ]
		otherwise: [ 
			self basicUpdateTabModel: aTabModel with: aNewSubView ]
]
