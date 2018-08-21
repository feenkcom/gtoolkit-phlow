initialization
initialize
	super initialize.
	actionStencils := OrderedCollection new.
	phlowActions := OrderedCollection new.
	priority := 50. "the lower the value, the closer to the left the tab appears"
	"self actionStencil: [ 
		| button |
		button := BrButton new.
		button 
				look: BrGlamorousButtonExteriorCircularLook + BrGlamorousButtonIconLook;
				icon: GLMUIThemeExtraIcons glamorousBrowse asElement ;
				action: [ button fireEvent: (GtPhlowObjectToSpawn new 
					object: self definingMethod;
					sourceElement: button) ] ]"