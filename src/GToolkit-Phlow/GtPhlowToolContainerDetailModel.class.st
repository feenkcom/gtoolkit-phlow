"
I am a {{gtClass:GtPhlowToolAbstractDetailModel}}.
I define what level of information detail should be used by {{gtClass:BlElement}} child instances (tools). The tools should use the given level of detail and display corresponding context information. For example, in case of a {{gtClass:Class}}, a normal level of information detail can only display basic class definition, while a detailed level of information can display also the class hierarchy.
1. # How I Work

I am attached to a {{gtClass:BlElement|label=tool}} using {{gtMethod:BlElement>>#addInteractiveModelState:}}. I listen to {{gtClass:GtPhlowToolContainerDetailRequest}} from the attached element {{gtMethod:BlElement>>#children|label=#selector}}.  I answer the current level of information detail. 

Notice, that I do ** inform my element children, when I change my state. Currently, it is supposed that my children need to update the level of information deail only when attached to a scene graph.
1. # Providing Information Level Value Example

The following example shows how a tool obtains a detailed level response from a parent element to which I am attached to: {{gtExample:GtPhlowToolDetailModelExamples>>#containerElementDetailedResponse|codeExpanded=false|previewExpanded=true}}
1. # Example With Undefined State

The following example shows the case in which a container has undefined state. The undefined state is never answered by {{gtClass:GtPhlowToolContainerDetailModel}}: {{gtExample:GtPhlowToolDetailModelExamples>>#containerElementUndefinedResponse|codeExpanded=false|previewExpanded=true}} 
1. # Skipping Undefined Level Example

If my value is undefined, another parent has a change to answer the inforamtion level value: {{gtExample:GtPhlowToolDetailModelExamples>>#containerContainerToolDetailedLevel_InSpace|codeExpanded=false|previewExpanded=true|previewHeight=350}}


"
Class {
	#name : #GtPhlowToolContainerDetailModel,
	#superclass : #GtPhlowToolAbstractDetailModel,
	#category : 'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolContainerDetailModel class >> modelName [
	^ 'Tool Container Volume'
]

{ #category : #defaults }
GtPhlowToolContainerDetailModel >> defaultLevel [
	^ GtPhlowToolDetailState undefinedName
]

{ #category : #initialization }
GtPhlowToolContainerDetailModel >> initializeListeners [
	super initializeListeners.
	self
		when: GtPhlowToolContainerDetailRequest
		reply: [ :aResponse :aRequest | self volumeResponse: aResponse for: aRequest ]
]

{ #category : #'private - event handling' }
GtPhlowToolContainerDetailModel >> volumeResponse: aResponse for: aRequest [
	self isUndefined
		ifTrue: [ aRequest consumed: false ]
		ifFalse: [ aResponse level: self level ].
	^ aResponse
]
