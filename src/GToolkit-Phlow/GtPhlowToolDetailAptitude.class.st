"
I am a {{gtClass:BrInteractiveAptitude}}.
I perform user defined actions on {{gtClass:GtPhlowToolDetailModel}} changes. Users may use the following methods to configure actions for different states:
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
		when: self state detailed
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> level: aNamedLevel style: aBlock [
	self
		when: (self state level: aNamedLevel)
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> normal: aBlock [
	self
		when: (self state normal or: (BlElementAbsentState ofType: self state))
		style: aBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> state [
	^ GtPhlowToolDetailState
]
