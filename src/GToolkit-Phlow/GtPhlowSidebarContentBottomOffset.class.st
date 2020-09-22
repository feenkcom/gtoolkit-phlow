"
I am ${class:GtPhlowSidebarContentOffset}$.
I am used by ${class:GtPhlowVerticalSidebarElement}$ by calling its ${method:GtPhlowVerticalSidebarElement>>#beTop|label=#selector}$ method.

!! Big Distance Example
The following example shows a big distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}$
!! No Distance Example
The following example shows a zero distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}$
!! Default Distance Example
The following example shows a default distance: ${example:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_InContainer|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtPhlowSidebarContentBottomOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - accessing' }
GtPhlowSidebarContentBottomOffset >> margin [
	^ BlInsets bottom: self length
]

{ #category : #'api - accessing' }
GtPhlowSidebarContentBottomOffset >> marginExtra: anExtraLength [
	^ BlInsets bottom: self length + anExtraLength
]

{ #category : #'private - accessing' }
GtPhlowSidebarContentBottomOffset >> name [
	^ 'Bottom Offset'
]
