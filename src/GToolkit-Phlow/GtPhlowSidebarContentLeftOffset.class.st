"
I am ${class:GtPhlowSidebarContentOffset}$.
I am used by ${class:GtPhlowHorizontalSidebarElement}$ by calling its ${method:GtPhlowHorizontalSidebarElement>>#beRight|label=#selector}$ method.
!! Big Distance Example
The following example shows a big distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}$
!! No Distance Example
The following example shows a zero distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}$
!! Default Distance Example
The following example shows a default distance: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_InContainer|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtPhlowSidebarContentLeftOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentLeftOffset >> margin [
	^ BlInsets left: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentLeftOffset >> marginExtra: anExtraLength [
	^ BlInsets left: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentLeftOffset >> name [
	^ 'Left Offset'
]
