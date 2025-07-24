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
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - updating' }
GtPhlowSidebarContentRightOffset >> adjustElement: anElement lenghtWithResizerStrategy: aResizerStrategy [
	"The resizer strategy does not know whether it should change height or width.
	For that reason the adjustment is dispatched to me."

	aResizerStrategy adjustWidthFor: anElement
]

{ #category : #'api - updating' }
GtPhlowSidebarContentRightOffset >> adjustElement: anElement resizerStrategyOnResizerResized: anEvent [
	"The element does not know whether it should store extent x or y value.
	For that reason the adjustment is dispatched to me.
	The given anEvent has extent information."

	anElement beExact: anEvent extent x
]

{ #category : #'api - updating' }
GtPhlowSidebarContentRightOffset >> adjustElementLength: anElement [ 
	"Set element height or width."

	anElement hExact: self length
]

{ #category : #'api - updating' }
GtPhlowSidebarContentRightOffset >> adjustElementOrthogonalLength: anElement [

	anElement vMatchParent
]

{ #category : #'api - updating' }
GtPhlowSidebarContentRightOffset >> adjustResizerElementPosition: aResizerElement [
	"Set the top/bottom/left/right resizer position"

	^ aResizerElement beRight
]

{ #category : #'api - testing' }
GtPhlowSidebarContentRightOffset >> isElementCollapsed: anElement [
	"Return true if an element lenght (height or width) is less or equal to lenght."

	<return: #Boolean>
	^ anElement width <= self length
]

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
