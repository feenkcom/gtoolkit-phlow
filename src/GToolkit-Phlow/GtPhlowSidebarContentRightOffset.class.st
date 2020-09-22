"
I am ${class:GtPhlowSidebarContentOffset}$.
I am used by ${class:GtPhlowHorizontalSidebarElement}$ by calling its ${method:GtPhlowHorizontalSidebarElement>>#beLeft|label=#selector}$ method.
!! Big Distance Example
The following example shows a big distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}$
!! No Distance Example
The following example shows a zero distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}$
!! Default Distance Example
The following example shows a default distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_InContainer|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtPhlowSidebarContentRightOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentRightOffset >> margin [
	^ BlInsets right: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentRightOffset >> marginExtra: anExtraLength [
	^ BlInsets right: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentRightOffset >> name [
	^ 'Right Offset'
]
