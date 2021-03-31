"
I am a ${class:BrInteractiveLook}$.
I perform user defined actions on ${class:GtPhlowToolDetailModel}$ changes. Users may use the following methods to configure actions for different states:
- ${method:GtPhlowToolDetailLook>>#normal:|label=#selector}$,
- ${method:GtPhlowToolDetailLook>>#detailed:|label=#selector}$, and
- ${method:GtPhlowToolDetailLook>>#level:style:|label=#selector}$.
!! Example
The following example changes an element background color on information level changes: ${example:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}$ 
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
