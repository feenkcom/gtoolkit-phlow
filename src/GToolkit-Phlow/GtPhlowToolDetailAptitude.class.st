"
I am a {{gtClass:BrInteractiveLook}}.
I perform user defined actions on {{gtClass:GtPhlowToolDetailModel}} changes. Users may use the following methods to configure actions for different states:
- {{gtMethod:GtPhlowToolDetailLook>>#normal:|label=#selector}},
- {{gtMethod:GtPhlowToolDetailLook>>#detailed:|label=#selector}}, and
- {{gtMethod:GtPhlowToolDetailLook>>#level:style:|label=#selector}}.
1. # Example

The following example changes an element background color on information level changes: {{gtExample:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}} 


"
Class {
	#name : #GtPhlowToolDetailAptitude,
	#superclass : #BrInteractiveAptitude,
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> detailed: aStyleBlock [
	self
		when: self state detailed
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> level: aNamedVolume style: aStyleBlock [
	self
		when: (self state level: aNamedVolume)
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> normal: aStyleBlock [
	self
		when: self state normal
		style: aStyleBlock
]

{ #category : #'api - style' }
GtPhlowToolDetailAptitude >> state [
	^ GtPhlowToolDetailState
]
