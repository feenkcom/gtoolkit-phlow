"
I am a ${class:BlElement}$.
I am a sidebar.

I know how to:
- ${method:GtPhlowSidebarElement>>#show|label=#selector}$, 
- ${method:GtPhlowSidebarElement>>#hide|label=#selector}$, 
- ${method:GtPhlowHorizontalSidebarElement>>#expand|label=#selector}$, and 
- ${method:GtPhlowHorizontalSidebarElement>>#collapse|label=#selector}$ myself.

The content can be defined sending the ${method:GtPhlowSidebarElement>>#contentStencil:|label=#selector}$ message with a ${class:BrStencil}$ as parameter.

Users can:
- set my width using a ${class:BrResizer|label=resizer}$ handler,
- collapse and expand by ${method:GtPhlowSidebarElement>>#onResizerDoubleClick:|label=double clicking}$ on the resizer.
!! Left Sidebar Example
The following example shows a sidebar with a label content that you can resize using the handler on the right: ${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_LeftSide_InContainer|codeExpanded=false|previewExpanded=true}$
!! Right Sidebar Example
The following example shows the sidebar on the right side:
${example:GtPhlowSidebarElementExamples>>#horizontalSidebarElement_RightSide_InContainer|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtPhlowHorizontalSidebarElement,
	#superclass : #GtPhlowSidebarElement,
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'api - location' }
GtPhlowHorizontalSidebarElement >> beLeft [
	"We want the sidebar on the left side, 
	therefore the rresizer on the right side."
	self resizerElement beRight.
	self contentOffset: (GtPhlowSidebarContentOffset right: self contentOffset length)
]

{ #category : #'api - location' }
GtPhlowHorizontalSidebarElement >> beRight [
	"We want the sidebar on the right side, 
	therefore the rresizer on the left side."
	self resizerElement beLeft.
	self contentOffset: (GtPhlowSidebarContentOffset left: self contentOffset length)
]

{ #category : #'api - visibility' }
GtPhlowHorizontalSidebarElement >> collapse [
	self width: self contentOffset length
]

{ #category : #defaults }
GtPhlowHorizontalSidebarElement >> defaultContentOffset [
	^ GtPhlowSidebarContentOffset right: self defaultContentOffsetLength
]

{ #category : #defaults }
GtPhlowHorizontalSidebarElement >> defaultResizerLook [
	^ BrGlamorousWithHorizontalResizerAptitude new
]

{ #category : #'api - visibility' }
GtPhlowHorizontalSidebarElement >> expand [
	self resizerStrategy adjustWidthFor: self.
]

{ #category : #initialization }
GtPhlowHorizontalSidebarElement >> initialize [
	super initialize.

	self addAptitude: (BrLayoutResizerAptitude new
		vInherit;
		vInherit: [ :aBlock | self contentElementDo: aBlock ])
]

{ #category : #'private - testing' }
GtPhlowHorizontalSidebarElement >> isCollapsed [
	<return: #Boolean>
	^ self width <= self contentOffset length
]

{ #category : #'private - event handling' }
GtPhlowHorizontalSidebarElement >> onResizerResized: anEvent [
	self beExact: anEvent extent x
]
