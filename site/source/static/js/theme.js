/*
Name: 			Core Initializer
Written by: 	Okler Themes - (http://www.okler.net)
Version: 		1.1.0 - Fri Jan 31 2014 18:12:18
*/

(function() {

	"use strict";

	var Core = {

		initialized: false,

		initialize: function() {

			if (this.initialized) return;
			this.initialized = true;

			this.build();
			this.events();

		},

		build: function() {

			// Adds browser version on html class.
			$.browserSelector();

			// Adds window smooth scroll on chrome.
			var $html = $('html');
			if($html.hasClass("chrome") || $html.hasClass('ie11') || $html.hasClass('ie10')) {
				$.smoothScroll();
			}

			// Nav Menu
			this.navMenu();

			// Header Search
			this.headerSearch();

			// Page Top
			this.pageTop();

			// Animations
			this.animations();

			// Word Rotate
			this.wordRotate();

			// Newsletter
			this.newsletter();

			// Featured Boxes
			this.featuredBoxes();

			// Thumb Info
			this.thumbInfo();

			// Owl Carousel
			this.owlCarousel();

			// Tooltips
			$("a[rel=tooltip]").tooltip();

			// Sort
			this.sort();

			// Toggle
			this.toggle();

			// Twitter
			this.latestTweets();

			// Lightbox
			this.lightbox();

			// Parallax
			this.parallax();

		},

		events: function() {

			// Window Resize
			$(window).afterResize(function() {

				// Featured Boxes
				Core.featuredBoxes();

				// Revolution Slider Fix
				Core.fixRevolutionSlider();

				// Isotope
				$(".isotope").isotope('reLayout');

				// Masonry
				Core.masonry();

			});

			// Anchors Position
			$("a[data-hash]").on("click", function(e) {

				e.preventDefault();
				var header = $("body header:first"),
					headerHeight = header.height(),
					target = $(this).attr("href"),
					$this = $(this);

				if($(window).width() > 991) {
					$("html,body").animate({scrollTop: $(target).offset().top - (headerHeight + 50)}, 600, "easeOutQuad");
				} else {
					$("html,body").animate({scrollTop: $(target).offset().top - 30}, 600, "easeOutQuad");
				}

				return false;

			});

		},

		navMenu: function() {

			// Responsive Menu Events
			var addActiveClass = false;

			$("#mainMenu li.dropdown > a, #mainMenu li.dropdown-submenu > a").on("click", function(e) {

				if($(window).width() > 979) return;

				e.preventDefault();

				addActiveClass = $(this).parent().hasClass("resp-active");

				$("#mainMenu").find(".resp-active").removeClass("resp-active");

				if(!addActiveClass) {
					$(this).parents("li").addClass("resp-active");
				}

				return;

			});

			// Submenu Check Visible Space
			$("#mainMenu li.dropdown-submenu").hover(function() {

				if($(window).width() < 767) return;

				var subMenu = $(this).find("ul.dropdown-menu");

				if(!subMenu.get(0)) return;

				var screenWidth = $(window).width(),
					subMenuOffset = subMenu.offset(),
					subMenuWidth = subMenu.width(),
					subMenuParentWidth = subMenu.parents("ul.dropdown-menu").width(),
					subMenuPosRight = subMenu.offset().left + subMenu.width();

				if(subMenuPosRight > screenWidth) {
					subMenu.css("margin-left", "-" + (subMenuParentWidth + subMenuWidth + 10) + "px");
				} else {
					subMenu.css("margin-left", 0);
				}

			});

			// Mega Menu
			$(document).on("click", ".mega-menu .dropdown-menu", function(e) {
				e.stopPropagation()
			});

		},

		stickyMenu: function() {

			if($("body").hasClass("boxed"))
				return false;

			var body = $("body"),
				header = $("body header:first"),
				headerHeight = header.height(),
				logoWrapper = header.find(".logo"),
				logo = header.find(".logo img"),
				logoWidth = logo.width(),
				logoHeight = logo.height(),
				$this = this,
				lastScrollTop = 0,
				headerHeightSticky,
				logoSmallHeight = logo.attr("data-small-height");

			logo
				.css("height", logoSmallHeight);

			var logoSmallWidth = logo.width();

			logo
				.css("height", "auto")
				.css("width", "auto");

			$this.checkStickyMenu = function(fixHeader) {

				body.css("padding-top", headerHeight + 20);

				var st = $(window).scrollTop();

				if (st >= lastScrollTop){
					body.addClass("sticky-menu-down");
				} else {
					body.removeClass("sticky-menu-down");
				}

				lastScrollTop = st;

				if($(window).scrollTop() > 40 && $(window).width() > 991) {

					if(body.hasClass("sticky-menu-active"))
						return false;

					logo.stop(true, true);

					body.addClass("sticky-menu-active");

					logoWrapper.addClass("logo-sticky-active");

					logo.animate({
						width: logoSmallWidth,
						height: logoSmallHeight
					}, 200, function() {

						headerHeightSticky = header.height();

					});

				} else {

					if(body.hasClass("sticky-menu-active")) {

						body.removeClass("sticky-menu-active");

						logoWrapper.removeClass("logo-sticky-active");

						logo.animate({
							width: logoWidth,
							height: logoHeight
						}, 200, function() {

							logo.css({
								width: "auto",
								height: "auto"
							});

						});

					}

				}

				// Fix Padding Top
				if(fixHeader) {
					setTimeout(function() {
						$("body").css("padding-top", $("body header:first").height() + 20);
					}, 100);
				}

			}

			$(window).on("scroll", function(e) {

				$this.checkStickyMenu(false);

			});

			$this.checkStickyMenu(false);

		},

		headerSearch: function() {

			var searchEl = $("#headerSearch .search-input"),
				searchSubmit = searchEl.find("button");

			$(document).on("click", function(e) {
				if($(e.target).closest("#headerSearch").length === 0) {
					searchEl.removeClass("active");
					setTimeout(function() {
						searchEl.hide();
					}, 250);
				}
			});

			$("#headerSearchOpen").on("click", function(e) {
				e.preventDefault();

				searchEl.show();

				setTimeout(function() {
					searchEl.addClass("active");
				}, 50);

				setTimeout(function() {
					searchEl.find("input").focus();
				}, 250);
			});

			$("#headerSearchForm").validate({
				rules: {
					q: {
						required: true
					}
				},
	            errorPlacement: function(error, element) {

	            },
				highlight: function (element) {
					$(element)
						.closest(".control-group")
						.removeClass("success")
						.addClass("error");
				},
				success: function (element) {
					$(element)
						.closest(".control-group")
						.removeClass("error")
						.addClass("success");
				}
			});

			searchSubmit.on("click", function(e) {
				$("#headerSearchForm").submit();
			});

		},

		pageTop: function(options) {

			if(!$(".page-top").get(0)) {
				$("body").addClass("no-page-top");
				return;
			}

			$("div.page-top-slider:not(.manual)").each(function() {

				var slider = $(this);

				var defaults = {
					delay: 6000,
					startheight: 250,
					startwidth: 960,

					navigationType: "none",
					navigationArrows: "none",

					stopAtSlide: -1,
					stopAfterLoops: -1,

					shadow: 0,
					fullWidth: "on",
					onHoverStop: "off",
					videoJsPath: "vendor/rs-plugin/videojs/"
				}

				var config = $.extend({}, defaults, options, slider.data("plugin-options"));

				// Initialize Slider
				var sliderApi = slider.revolution(config).addClass("slider-init");

			});

			setTimeout(function() {
				$(".page-top-info").addClass("init");
			}, 500);

		},

		animations: function() {

			// Animation Appear
			$("[data-appear-animation]").each(function() {

				var $this = $(this);

				$this.addClass("appear-animation");

				if(!$("html").hasClass("no-csstransitions") && $(window).width() > 767) {

					$this.appear(function() {

						var delay = ($this.attr("data-appear-animation-delay") ? $this.attr("data-appear-animation-delay") : 1);

						if(delay > 1) $this.css("animation-delay", delay + "ms");
						$this.addClass($this.attr("data-appear-animation"));

						setTimeout(function() {
							$this.addClass("appear-animation-visible");
						}, delay);

					}, {accX: 0, accY: -150});

				} else {

					$this.addClass("appear-animation-visible");

				}

			});

			// Animation Progress Bars
			$("[data-appear-progress-animation]").each(function() {

				var $this = $(this);

				$this.appear(function() {

					var delay = ($this.attr("data-appear-animation-delay") ? $this.attr("data-appear-animation-delay") : 1);

					if(delay > 1) $this.css("animation-delay", delay + "ms");
					$this.addClass($this.attr("data-appear-animation"));

					setTimeout(function() {

						$this.animate({
							width: $this.attr("data-appear-progress-animation")
						}, 1500, "easeOutQuad", function() {
							$this.find(".progress-bar-tooltip").animate({
								opacity: 1
							}, 500, "easeOutQuad");
						});

					}, delay);

				}, {accX: 0, accY: -50});

			});

			// Count To
			$(".counters [data-to]").each(function() {

				var $this = $(this);

				$this.appear(function() {

					$this.countTo({});

				}, {accX: 0, accY: -150});

			});

			/* Circular Bars - Knob */
			if(typeof($.fn.knob) != "undefined") {
				$(".knob").knob({});
			}

		},

		wordRotate: function() {

			$(".word-rotate").each(function() {

				var $this = $(this),
					itemsWrapper = $(this).find(".word-rotate-items"),
					items = itemsWrapper.find("> span"),
					firstItem = items.eq(0),
					firstItemClone = firstItem.clone(),
					itemHeight = 0,
					currentItem = 1,
					currentTop = 0;

				itemHeight = firstItem.height();

				itemsWrapper.append(firstItemClone);

				$this
					.height(itemHeight)
					.addClass("active");

				setInterval(function() {

					currentTop = (currentItem * itemHeight);

					itemsWrapper.animate({
						top: -(currentTop) + "px"
					}, 300, "easeOutQuad", function() {

						currentItem++;

						if(currentItem > items.length) {

							itemsWrapper.css("top", 0);
							currentItem = 1;

						}

					});

				}, 2000);

			});

		},

		newsletter: function() {

			$("#newsletterForm").validate({
				submitHandler: function(form) {

					$.ajax({
						type: "POST",
						url: $("#newsletterForm").attr("action"),
						data: {
							"email": $("#newsletterForm #email").val()
						},
						dataType: "json",
						success: function (data) {
							if (data.response == "success") {

								$("#newsletterSuccess").removeClass("hidden");
								$("#newsletterError").addClass("hidden");

								$("#newsletterForm #email")
									.val("")
									.blur()
									.closest(".control-group")
									.removeClass("success")
									.removeClass("error");

							} else {

								$("#newsletterError").html(data.message);
								$("#newsletterError").removeClass("hidden");
								$("#newsletterSuccess").addClass("hidden");

								$("#newsletterForm #email")
									.blur()
									.closest(".control-group")
									.removeClass("success")
									.addClass("error");

							}
						}
					});

				},
				rules: {
					email: {
						required: true,
						email: true
					}
				},
	            errorPlacement: function(error, element) {

	            },
				highlight: function (element) {
					$(element)
						.closest(".control-group")
						.removeClass("success")
						.addClass("error");
				},
				success: function (element) {
					$(element)
						.closest(".control-group")
						.removeClass("error")
						.addClass("success");
				}
			});

		},

		featuredBoxes: function() {

			$("div.featured-box").css("height", "auto");

			$("div.featured-boxes").each(function() {

				var wrapper = $(this);
				var minBoxHeight = 0;

				$("div.featured-box", wrapper).each(function() {
					if($(this).height() > minBoxHeight)
						minBoxHeight = $(this).height();
				});

				$("div.featured-box", wrapper).height(minBoxHeight);

			});

		},

		thumbInfo: function() {

			$(".thumb-info").css("min-height", "auto");

			$(".thumb-info-list").each(function() {

				var wrapper = $(this);
				var minBoxHeight = 0;

				$(".thumb-info", wrapper).each(function() {
					if($(this).height() > minBoxHeight)
						minBoxHeight = $(this).height();
				});

				$(".thumb-info", wrapper).height(minBoxHeight);

			});

		},

		owlCarousel: function(options) {

			var total = $("div.owl-carousel:not(.manual)").length,
				count = 0;

			$("div.owl-carousel:not(.manual)").each(function() {

				var slider = $(this);

				var defaults = {
					 // Most important owl features
					items : 5,
					itemsCustom : false,
					itemsDesktop : [1199,4],
					itemsDesktopSmall : [980,3],
					itemsTablet: [768,2],
					itemsTabletSmall: false,
					itemsMobile : [479,1],
					singleItem : true,
					itemsScaleUp : false,

					//Basic Speeds
					slideSpeed : 200,
					paginationSpeed : 800,
					rewindSpeed : 1000,

					//Autoplay
					autoPlay : false,
					stopOnHover : false,

					// Navigation
					navigation : false,
					navigationText : ["<i class=\"icon icon-chevron-left\"></i>","<i class=\"icon icon-chevron-right\"></i>"],
					rewindNav : true,
					scrollPerPage : false,

					//Pagination
					pagination : true,
					paginationNumbers: false,

					// Responsive
					responsive: true,
					responsiveRefreshRate : 200,
					responsiveBaseWidth: window,

					// CSS Styles
					baseClass : "owl-carousel",
					theme : "owl-theme",

					//Lazy load
					lazyLoad : false,
					lazyFollow : true,
					lazyEffect : "fade",

					//Auto height
					autoHeight : false,

					//JSON
					jsonPath : false,
					jsonSuccess : false,

					//Mouse Events
					dragBeforeAnimFinish : true,
					mouseDrag : true,
					touchDrag : true,

					//Transitions
					transitionStyle : false,

					// Other
					addClassActive : false,

					//Callbacks
					beforeUpdate : false,
					afterUpdate : false,
					beforeInit: false,
					afterInit: false,
					beforeMove: false,
					afterMove: false,
					afterAction: false,
					startDragging : false,
					afterLazyLoad : false
				}

				var config = $.extend({}, defaults, options, slider.data("plugin-options"));

				// Initialize Slider
				slider.owlCarousel(config).addClass("owl-carousel-init");

			});

		},

		sort: function() {

			$("ul.sort-source").each(function() {

				var source = $(this);
				var destination = $("ul.sort-destination[data-sort-id=" + $(this).attr("data-sort-id") + "]");

				if(destination.get(0)) {

					$(window).load(function() {

						destination.isotope({
							itemSelector: "li",
							layoutMode: 'sloppyMasonry'
						});

						source.find("a").click(function(e) {

							e.preventDefault();

							var $this = $(this),
								sortId = $this.parents(".sort-source").attr("data-sort-id"),
								filter = $this.parent().attr("data-option-value");

							source.find("li.active").removeClass("active");
							$this.parent().addClass("active");

							destination.isotope({
								filter: filter
							});

							self.location = "#" + filter.replace(".","");

							$(".sort-source-title[data-sort-id=" + sortId + "] strong").html($this.html());

							return false;

						});

						$(window).bind("hashchange", function(e) {

							var hashFilter = "." + location.hash.replace("#",""),
								hash = (hashFilter == "." || hashFilter == ".*" ? "*" : hashFilter);

							source.find("li.active").removeClass("active");
							source.find("li[data-option-value='" + hash + "']").addClass("active");

							destination.isotope({
								filter: hash
							});

						});

						var hashFilter = "." + (location.hash.replace("#","") || "*");

						var initFilterEl = source.find("li[data-option-value='" + hashFilter + "'] a");

						if(initFilterEl.get(0)) {
							source.find("li[data-option-value='" + hashFilter + "'] a").click();
						} else {
							source.find("li:first-child a").click();
						}

					});

				}

			});

		},

		toggle: function() {

			var $this = this,
				previewParClosedHeight = 25;

			$("section.toggle.active > p").addClass("preview-active");
			$("section.toggle.active > div.toggle-content").slideDown(350, function() {});

			$("section.toggle > label").click(function(e) {

				var parentSection = $(this).parent(),
					parentWrapper = $(this).parents("div.toogle"),
					previewPar = false,
					isAccordion = parentWrapper.hasClass("toogle-accordion");

				if(isAccordion && typeof(e.originalEvent) != "undefined") {
					parentWrapper.find("section.toggle.active > label").trigger("click");
				}

				parentSection.toggleClass("active");

				// Preview Paragraph
				if(parentSection.find("> p").get(0)) {

					previewPar = parentSection.find("> p");
					var previewParCurrentHeight = previewPar.css("height");
					previewPar.css("height", "auto");
					var previewParAnimateHeight = previewPar.css("height");
					previewPar.css("height", previewParCurrentHeight);

				}

				// Content
				var toggleContent = parentSection.find("> div.toggle-content");

				if(parentSection.hasClass("active")) {

					$(previewPar).animate({
						height: previewParAnimateHeight
					}, 350, function() {
						$(this).addClass("preview-active");
					});

					toggleContent.slideDown(350, function() {});

				} else {

					$(previewPar).animate({
						height: previewParClosedHeight
					}, 350, function() {
						$(this).removeClass("preview-active");
					});

					toggleContent.slideUp(350, function() {});

				}

			});

		},

		lightbox: function(options) {

			if(typeof($.magnificPopup) == "undefined") {
				return false;
			}

			// Internationalization of Lightbox
			$.extend(true, $.magnificPopup.defaults, {
				tClose: 'Close (Esc)', // Alt text on close button
				tLoading: 'Loading...', // Text that is displayed during loading. Can contain %curr% and %total% keys
				gallery: {
					tPrev: 'Previous (Left arrow key)', // Alt text on left arrow
					tNext: 'Next (Right arrow key)', // Alt text on right arrow
					tCounter: '%curr% of %total%' // Markup for "1 of 7" counter
				},
				image: {
					tError: '<a href="%url%">The image</a> could not be loaded.' // Error message when image could not be loaded
				},
				ajax: {
					tError: '<a href="%url%">The content</a> could not be loaded.' // Error message when ajax request failed
				}
			});

			$(".lightbox").each(function() {

				var el = $(this);

				var config, defaults = {}
				if(el.data("plugin-options"))
					config = $.extend({}, defaults, options, el.data("plugin-options"));

				$(this).magnificPopup(config);

			});

		},

		parallax: function() {

			if(typeof($.stellar) == "undefined") {
				$(".parallax").addClass("parallax-init");
				return false;
			}

			$(window).load(function () {

				if($(".parallax").get(0)) {
					if(!Modernizr.touch) {
						$(window).stellar({
							responsive:true,
							scrollProperty: 'scroll',
							parallaxElements: false,
							horizontalScrolling: false,
							horizontalOffset: 0,
							verticalOffset: 0
						});
					} else {
						$(".parallax").addClass("disabled");
					}
				}

				$(".parallax").addClass("parallax-init");

			});

		},

		latestTweets: function() {

			var wrapper = $("#tweet"),
				accountId = wrapper.data("account-id");

			if(wrapper.get(0) && accountId != "") {
				getTwitters("tweet", {
					id: accountId,
					count: 2
				});

				wrapper.before($("<a />").addClass("twitter-account").html("@" + accountId).attr("href", "http://www.twitter.com/" + accountId).attr("target", "_blank"));

			} else {
				wrapper.empty();
			}

		},

		masonry: function() {

			var $container;

			$(".masonry-list").each(function() {

				var $container = $(this);

				$container.waitForImages(function() {

					$container.masonry({
						itemSelector: '.masonry-item'
					});

					$container.addClass("init");

				});

			});

		},

		fixRevolutionSlider: function() {

			$(".revslider-initialised").each(function() {
				try{
					$(this).revredraw();
				} catch(e) {}
			});

		}

	};

	Core.initialize();

	$(window).load(function () {

		// Sticky Meny
		Core.stickyMenu();

		// Masonry
		Core.masonry();

	});

})();