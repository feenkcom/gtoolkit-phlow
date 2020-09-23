"
I am an abstract class.
My subclasses are used by ${class:GtPhlowSidebarElement}$.
My subclasses provide a common API to compute a ${class:GtPhlowSidebarElement}$'s offset (margin) between its border and its content. The purpose of this distance is to create a distance between the sidebar resizer and the sidebar content.
!! Common API
- ${method:GtPhlowSidebarContentOffset>>#length:|label=#selector}$
- ${method:GtPhlowSidebarContentOffset>>#margin|label=#selector}$
- ${method:GtPhlowSidebarContentOffset>>#marginExtra:|label=#selector}$
!! Big Distance Example
The following example shows a big distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}$
!! No Distance Example
The following example shows a zero distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}$
!! Default Distance Example
The following example shows a default distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_InContainer|codeExpanded=false|previewExpanded=true}$
!! Concrete Implementations
See my ${class:GtPhlowSidebarContentOffset|expanded|show=#gtSubclassesFor:}$ for concrete implementations:
"
Class {
	#name : #GtPhlowSidebarContentOffset,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'length'
	],
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #factory }
GtPhlowSidebarContentOffset class >> bottom: anInteger [
	^ GtPhlowSidebarContentBottomOffset new length: anInteger
]

{ #category : #factory }
GtPhlowSidebarContentOffset class >> left: anInteger [
	^ GtPhlowSidebarContentLeftOffset new length: anInteger
]

{ #category : #factory }
GtPhlowSidebarContentOffset class >> right: anInteger [
	^ GtPhlowSidebarContentRightOffset new length: anInteger
]

{ #category : #factory }
GtPhlowSidebarContentOffset class >> top: anInteger [
	^ GtPhlowSidebarContentTopOffset new length: anInteger
]

{ #category : #'private - asserting' }
GtPhlowSidebarContentOffset >> assertLength: anInteger [
	self 
		assert: [ anInteger isNotNil ] 
		description: [ 'Lenght must be non-nil' ].
	self 
		assert: [ anInteger >= 0 ] 
		description: [ 'Lenght must be zero or positive' ].
	
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentOffset >> length [
	"Return the distance between a sidebar border and its content.
	The distance is considered only on the side with the sidebar resizer."
	<return: #Integer>
	^ length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentOffset >> length: anInteger [
	"Set the distance between a sidebar border and its content.
	The distance is considered only on the side with the sidebar resizer."
	self assertLength: anInteger.
	length := anInteger
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentOffset >> margin [
	"Return insets that is add to a content element margin with the purpose 
	to create an offset (margin) between the sidebar content and the sidebar resizer."
	<return: #BlInsets>
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentOffset >> marginExtra: anExtraLength [
	"Return insets that is add to a content element margin with the purpose 
	to create an offset (margin) between the sidebar content and the sidebar resizer.
	The resulting insets should include the extra length (which can be negative).
	I am used to update an existing margin."
	<return: #BlInsets>
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentOffset >> name [
	^ self asString
]

{ #category : #printing }
GtPhlowSidebarContentOffset >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: ': ';
		print: self length
]
