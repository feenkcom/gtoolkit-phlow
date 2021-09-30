"
I am a {{gtClass:GtPhlowToolAbstractDetailModel}}.
I define what level of information detail should be displayed by an {{gtClass:BlElement}} (a tool) I am attached to. The tool should use the given level of information detail and display corresponding context information. For example, in case of a {{gtClass:Class}}, a normal level of information detail can only display basic class definition, while a detailed level of information can display also the class hierarchy.
1. # How I Work

I am attached to a {{gtClass:BlElement|label=tool}} using {{gtMethod:BlElement>>#addInteractiveModelState:}}. There can be a parent {{gtClass:BlElement}} that knows which level of details should be used. Such parent should have {{gtClass:GtPhlowToolContainerDetailModel}} attached. Each time I am added to a {{gtClass:BlSpace}}, I fire {{gtClass:GtPhlowToolContainerDetailRequest}} to figure out a current tool level of detail that should be used. Parents may or may not answer it. Notice, that I am not informed by element parents, when they change their states.
1. # Cooperation

I should be used together with {{gtClass:GtPhlowToolDetailAptitude}}.
1. # Switching Levels Example

The following example changes an element background color on information level changes:   {{gtExample:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}}
1. # Obtaining Information Detail Level Example

The following example shows how a tool obtains a detailed level response from a parent element (container): {{gtExample:GtPhlowToolDetailModelExamples>>#containerElementDetailedResponse|codeExpanded=false|previewExpanded=true}}
1. # Meaning of Undefined Level Example

The following example shows that the tool obtains the level of information detail from the second parent, since first parent has undefined state: {{gtExample:GtPhlowToolDetailModelExamples>>#containerContainerToolDetailedLevel_InSpace|codeExpanded=false|previewExpanded=true|previewHeight=350}} 


"
Class {
	#name : #GtPhlowToolDetailModel,
	#superclass : #GtPhlowToolAbstractDetailModel,
	#category : 'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolDetailModel class >> modelName [
	^ 'Tool Volume'
]

{ #category : #defaults }
GtPhlowToolDetailModel >> defaultLevel [
	^ GtPhlowToolDetailState normalName
]

{ #category : #initialization }
GtPhlowToolDetailModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onAddedToSceneGraph ]
]

{ #category : #'private - event handling' }
GtPhlowToolDetailModel >> onAddedToSceneGraph [
	self updateVolumeFromToolContainer.
]

{ #category : #'private - updating' }
GtPhlowToolDetailModel >> updateVolumeFromToolContainer [
	| aResponse |
	aResponse := self request: GtPhlowToolContainerDetailRequest new.
	aResponse isUndefined
		ifTrue: [ ^ self ].
	self level: aResponse level
]
