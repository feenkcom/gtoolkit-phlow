"
I allow users to style an element based on {{gtClass:GtPhlowToolDetailState}} . Users may use the following methods to configure styles for different states:
- {{gtMethod:GtPhlowToolDetailAptitude>>#normal:|label=#selector}},
- {{gtMethod:GtPhlowToolDetailAptitude>>#detailed:|label=#selector}}, and
- {{gtMethod:GtPhlowToolDetailAptitude>>#level:style:|label=#selector}}.
1. # Example

The following example changes an element background color on information level changes: {{gtExample:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}} 


"
Class {
	#name : #GtPhlowToolDetailAptitude,
	#superclass : #BrLazyStyleAptitude,
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> detailed: aBlock [
	self
		when: GtPhlowToolDetailState detailed
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> left: aBlock [
	self
		when: GtPhlowToolDetailPositionState left
				| (BlElementAbsentState ofType: GtPhlowToolDetailPositionState)
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> leftDetailed: aBlock [
	self
		when: GtPhlowToolDetailState detailed
				& (GtPhlowToolDetailPositionState left
						| (BlElementAbsentState ofType: GtPhlowToolDetailPositionState))
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> leftNormal: aBlock [
	self
		when: GtPhlowToolDetailState normal
				| (BlElementAbsentState ofType: GtPhlowToolDetailState)
				& (GtPhlowToolDetailPositionState left
						| (BlElementAbsentState ofType: GtPhlowToolDetailPositionState))
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> level: aNamedLevel style: aBlock [
	self
		when: (GtPhlowToolDetailState level: aNamedLevel)
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> normal: aBlock [
	self
		when: (GtPhlowToolDetailState normal
				or: (BlElementAbsentState ofType: GtPhlowToolDetailState))
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> position: aNamedPosition style: aBlock [
	self
		when: (GtPhlowToolDetailPositionState position: aNamedPosition)
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> top: aBlock [
	self
		when: GtPhlowToolDetailPositionState top
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> topDetailed: aBlock [
	self
		when: GtPhlowToolDetailState detailed & GtPhlowToolDetailPositionState top
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> topNormal: aBlock [
	self
		when: GtPhlowToolDetailState normal
				| (BlElementAbsentState ofType: GtPhlowToolDetailState)
				& GtPhlowToolDetailPositionState top
		style: aBlock
]
