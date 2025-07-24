"
I am {{gtClass:GtPhlowSidebarContentOffset}}.
I am used by {{gtClass:GtPhlowVerticalSidebarElement}} by calling its {{gtMethod:GtPhlowVerticalSidebarElement>>#beTop|label=#selector}} method.

1. # Big Distance Example

The following example shows a big distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Bigger_InContainer|codeExpanded=false|previewExpanded=true}}
1. # No Distance Example

The following example shows a zero distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_Offset_Smaller_InContainer|codeExpanded=false|previewExpanded=true}}
1. # Default Distance Example

The following example shows a default distance: {{gtExample:GtPhlowSidebarElementExamples>>#verticalSidebarElement_Top_InContainer|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowSidebarContentBottomOffset,
	#superclass : #GtPhlowSidebarContentOffset,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - updating' }
GtPhlowSidebarContentBottomOffset >> adjustElement: anElement lenghtWithResizerStrategy: aResizerStrategy [
	"The resizer strategy does not know whether it should change height or width.
	For that reason the adjustment is dispatched to me."

	aResizerStrategy adjustHeightFor: anElement
]

{ #category : #'api - updating' }
GtPhlowSidebarContentBottomOffset >> adjustElement: anElement resizerStrategyOnResizerResized: anEvent [
	"The element does not know whether it should store extent x or y value.
	For that reason the adjustment is dispatched to me.
	The given anEvent has extent information."

	anElement beExact: anEvent extent y
]

{ #category : #'api - updating' }
GtPhlowSidebarContentBottomOffset >> adjustElementLength: anElement [ 
	"Set element height or width."

	anElement vExact: self length
]

{ #category : #'api - updating' }
GtPhlowSidebarContentBottomOffset >> adjustElementOrthogonalLength: anElement [

	anElement hMatchParent
]

{ #category : #'api - updating' }
GtPhlowSidebarContentBottomOffset >> adjustResizerElementPosition: aResizerElement [
	"Set the top/bottom/left/right resizer position"

	^ aResizerElement beBottom
]

{ #category : #'api - testing' }
GtPhlowSidebarContentBottomOffset >> isElementCollapsed: anElement [
	"Return true if an element lenght (height or width) is less or equal to lenght."

	<return: #Boolean>
	^ anElement height <= self length
]

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
