"
I am {{gtClass:GtPhlowSidebarContentOffset}}.
I am used by {{gtClass:GtPhlowHorizontalSidebarElement}} by calling its {{gtMethod:GtPhlowHorizontalSidebarElement>>#beLeft|label=#selector}} method.
1. # Big Distance Example

The following example shows a big distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}}
1. # No Distance Example

The following example shows a zero distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Default Distance Example

The following example shows a default distance: {{gtExample:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowSidebarContentRightOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : 'GToolkit-Phlow-Tool - UI Sidebar'
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
