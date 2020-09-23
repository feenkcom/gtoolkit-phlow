"
I am ${class:GtPhlowSidebarContentOffset}$.
I am used by ${class:GtPhlowVerticalSidebarElement}$ by calling its ${method:GtPhlowVerticalSidebarElement>>#beBottom|label=#selector}$ method.

!! Big Distance Example
The following example shows a big distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}$
!! No Distance Example
The following example shows a zero distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}$
!! Default Distance Example
The following example shows a default distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Bottom_InContainer|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtPhlowSidebarContentTopOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentTopOffset >> margin [
	^ BlInsets top: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentTopOffset >> marginExtra: anExtraLength [
	^ BlInsets top: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentTopOffset >> name [
	^ 'Top Offset'
]
