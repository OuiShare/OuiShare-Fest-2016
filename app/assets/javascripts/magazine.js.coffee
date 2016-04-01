# $(document).ready ->
# 	jssor_slider1_starter(slider1_container)


jssor_slider1_starter = (containerId) ->
	console.log('test')
	options = 
		$AutoPlay: true
		$PauseOnHover: 1
		$ArrowKeyNavigation: true
		$SlideWidth: 600
		$SlideSpacing: 0
		$DisplayPieces: 2
		$ParkingPosition: 300
		$ArrowNavigatorOptions:
			$Class: $JssorArrowNavigator$
			$ChanceToShow: 2
			$AutoCenter: 2
			$Steps: 1
		
	jssor_slider1 = new $JssorSlider$(containerId, options)
	#responsive code begin
	#you can remove responsive code if you don't want the slider scales while window resizes

	ScaleSlider = ->
		parentWidth = jssor_slider1.$Elmt.parentNode.clientWidth
		if parentWidth
			jssor_slider1.$ScaleWidth(Math.min(parentWidth))
		else
			$Jssor$.$Delay ScaleSlider, 30
		return

	ScaleSlider()
	$Jssor$.$AddEvent window, 'load', ScaleSlider
	$Jssor$.$AddEvent window, 'resize', ScaleSlider
	$Jssor$.$AddEvent window, 'orientationchange', ScaleSlider
	#responsive code end
	return