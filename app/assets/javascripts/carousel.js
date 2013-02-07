/*	CarouFredSel: an infinite, circular jQuery carousel.
 Configuration created by the "Configuration Robot"
 at caroufredsel.frebsite.nl
 */
function startCarousel (pause,transition) {
    $("#carousel").carouFredSel({
//		width: 900,
		height: 200,
		align: "center",
		padding: 0,
		items: {
			visible: 5,
			minimum: 5,
			start: "random",
			width: 180,
			height: 200
		},
		auto: {
			pauseDuration: pause
		},
		scroll: {
            fx: "scroll",
            easing: "linear",
			wipe: true,
			items: 1,
			duration: transition,
			pauseOnHover: true
		},
		prev: {
			button: "#carousel_prev",
			key: "left"
		},
		next: {
			button: "#carousel_next",
			key: "right"
		},
		pagination: "#carousel_pag"
	});
}
