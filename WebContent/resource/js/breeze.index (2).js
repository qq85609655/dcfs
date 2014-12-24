//框架页面的一些操作
var page={
	"defaultStyle":"base",
	"params" : null,
	click_event: $.fn.tap ? "tap" : "click",
	/**
	 * 设置样式
	 *
	 * @param style
	 *            样式名称
	 */
	loadStyle:function(){
		$("body").attr("class",this.defaultStyle);
	},
	/**
	 * 加载页面样式
	 */
	init:function(){
		page.handle_side_menu();
	},
	handle_side_menu:function() {
		$("#sidebar .nav-list li").hover(
			function(){
				$(this).addClass("hover");
			},
			function(){
				$(this).removeClass("hover");
			}
		);
		$("#sidebar-collapse").on(page.click_event, function() {
			c = $("#sidebar").hasClass("menu-min");
			page.sidebar_collapsed(!c);
		});
		$("#sidebar .nav-list").on(page.click_event, function(h) {
			var g = $(h.target).closest("a");
			if (!g || g.length == 0) {
				return;
			}
			c = $("#sidebar").hasClass("menu-min");
			if (!g.hasClass("dropdown-toggle")) {
				if (c && page.click_event == "tap" && g.get(0).parentNode.parentNode == this) {
					var i = g.find(".menu-text").get(0);
					if (h.target != i && !$.contains(i, h.target)) {
						return false;
					}
				}
				$(this).find('.active')
					.not(g.parents(".active")).each(function() {
					$(this).removeClass('active').removeClass('open');
					$(this).find(".submenu").slideUp(200);
				});
				g.parent().addClass('active');
				g.parents(".submenu").parent().addClass('active');
				//$("#mainFrame").attr("src", g.attr("href"));
				top.page._goTop();
				return;
			}
			var f = g.next().get(0);
			if (!$(f).is(":visible")) {
				var d = $(f.parentNode).closest("ul");
				if (c && d.hasClass("nav-list")) {
					return;
				}
				d.find("> .open > .submenu").each(function() {
					if (this != f && !$(this.parentNode).hasClass("active")) {
						$(this).slideUp(200).parent().removeClass("open");
					}
				});
			} else {} if (c && $(f.parentNode.parentNode).hasClass("nav-list")) {
				return false;
			}
			$(f).slideToggle(200).parent().toggleClass("open");
			return false;
		});
	},
	sidebar_collapsed: function(c) {
		c = c || false;
		var e = $("#sidebar");
		var d = $("#sidebar .icon-double-angle");
		var b = $("#main-content");
		if (c) {
			e.addClass('menu-min');
			d.removeClass('icon-double-angle-left').addClass('icon-double-angle-right');
			b.css('margin-left','40px');
		} else {
			e.removeClass('menu-min');
			d.addClass('icon-double-angle-left').removeClass('icon-double-angle-right');
			b.css('margin-left','190px');
		}
	},
	_runGoTop : function() {
		var scrollTop = $(document).scrollTop();
		if (scrollTop > 1) {
			var topElement = "<div class=\"bz-gotop\" onclick=\"top.page._goTop();\" title=\"回到顶部\"></div>";
			var gotoTop = $(".bz-gotop");
			if (gotoTop.length == 0) {
				$("body").append(topElement);
				gotoTop = $(".bz-gotop");
				gotoTop.hover(function() {
					var elementWidth = document.documentElement.clientWidth;
					$(this).css("left", elementWidth - 40);
					gotoTop.css("width", "40px");
				}, function() {
					var elementWidth = document.documentElement.clientWidth;
					$(this).css("left", elementWidth - 10);
					gotoTop.css("width", "10px");
				});
			}
			gotoTop.tooltip();
			if (gotoTop.css("display") == "none") {
				gotoTop.slideDown("fast");
			}
			var elementWidth = document.documentElement.clientWidth;
			var elementHeight = document.documentElement.clientHeight;
			gotoTop.css("top", elementHeight + scrollTop - 50);
			gotoTop.css("left", elementWidth - 10);
			gotoTop.css("width", "10px");
		} else {
			var gotoTop = $(".bz-gotop");
			if (gotoTop.length > 0) {
				gotoTop.slideUp("fast");
			}
		}
	},
	_goTop : function() {
		window.scrollTo(0, 0);
		this._runGoTop();
	},
	/**
	 * 消息提示
	 *
	 * @param title
	 *            弹出框标?
	 * @param uri
	 *            弹出页面?
	 * @param func
	 *            关闭后窗口执行的方法
	 * @param width
	 *            宽度
	 * @param height
	 *            高度
	 * @param style
	 *            提示样式：alert(默认),ask,msg,error
	 * @param modal
	 *            是否模式，默认?ue
	 */
	showPage : function(title, uri, params, width, height, buttons) {
		var dialogElement = "<div id=\"bz-dialog-showPage\" ><iframe class=\"modalFrame\" id=\"modalFrame\" name=\"modalFrame\"></iframe></div>";
		this.params = params;
		$("#bz-dialog-showPage").remove();
		$("body").append(dialogElement);
		var dialog = $("#bz-dialog-showPage");
		if (title == null) {
			title = "选择信息";
		}
		dialog.attr("title", title);
		var iframe = dialog.children("iframe:first");
		iframe.attr("src", uri);
		var elementHeight = document.documentElement.clientHeight;
		var elementWidth = document.documentElement.clientWidth;
		if (width == null) {
			width = elementWidth;
		}
		if (height == null || height > elementHeight) {
			height = elementHeight;
		}
		dialog.dialog({
			"autoOpen" : false,
			"height" : height,
			"width" : width,
			"modal" : true,
			"buttons" : buttons,
			"position": ['center',100],
			"close" : function() {
				page.params = null;
			},
			dragStop : function(event, ui) {
				var o = $(".ui-dialog");
				o.data("top", ui.position.top);
			}
		});
		dialog.dialog("open");
		dialog.css("padding", "0");
		// iframe.css("width",(dialog.width()-15));
	},
	/**
	 * 关闭窗口
	 */
	closePage : function() {
		$("#bz-dialog-showPage").dialog("close");
	},
	/**
	 * 关闭窗口
	 */
	closeAlert : function() {
		$("#bz-dialog-message").dialog("close");
	},
	/**
	 * 消息提示
	 *
	 * @param msg
	 *            消息使
	 * @param title
	 *            消息标题
	 * @param func
	 *            关闭后窗口执行的方法
	 * @param width
	 *            宽度
	 * @param height
	 *            高度
	 * @param style
	 *            提示样式：alert(默认),ask,msg,error
	 * @param modal
	 *            是否模式，默认?ue
	 * @param buttons
	 *            按钮及其执行的方法json对象
	 */
	alert : function(msg, title, func, width, height, style, modal, buttons) {
		// 判断页面有没有dialog，没有的话增势
		var dialogElement = "<div id=\"bz-dialog-message\" ><table class=\"bz-message\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"48px\"><div></div></td><td><p></p></td></tr></table></div>";
		/*
		 * var dialog = $("#bz-dialog-message"); if (dialog.length==0){
		 * $("body").append(dialogElement); dialog = $("#bz-dialog-message"); }
		 */
		$("#bz-dialog-message").remove();
		$("body").append(dialogElement);
		var dialog = $("#bz-dialog-message");
		if (title == null) {
			title = "提示信息";
		}
		if (style == null) {
			style = "alert";
		}
		var className = "bz-message-" + style;
		dialog.attr("title", title);
		dialog.find("p:first").html(msg);
		dialog.find("div:first").removeClass();
		dialog.find("div:first").addClass(className);

		if (height == null) {
			height = "auto";
		}
		if (modal == null) {
			modal = true;
		}
		var elementHeight = document.documentElement.clientHeight;
		var elementWidth = document.documentElement.clientWidth;
		if (width == null) {
			width = 500;
		}
		if (buttons == null) {
			buttons = {
				"取消": function() {
					$("#bz-dialog-message").dialog("close");
				}
			};
		}
		dialog.dialog({
			"autoOpen" : false,
			"height" : height,
			"width" : width,
			"modal" : modal,
			"maxHeight" : elementHeight,
			"maxWidth" : (elementWidth - 100),
			"close" : func,
			"buttons" : buttons,
			"position": ['center',100],
			dragStop : function(event, ui) {
				var o = $(".ui-dialog");
				o.data("top", ui.position.top);
			},
			show : function() {

			}
		});

		dialog.dialog("open");
	},
	/**
	 * 刷新提示?
	 */
	_refurbishDialog : function() {
		var o = $(".ui-dialog");
		if (o.length > 0) {
			if (o.data("top") == null) {
				var p = o.position();
				o.data("top", p.top);
			}
			var scrollTop = $(document).scrollTop();
			o.css("top", (scrollTop + o.data("top")));
		}
	},
	/**
	 * 提示信息
	 *
	 * @param msg
	 *            消息内容
	 * @param title
	 *            标题，?果为null，则不显示标?
	 * @param width
	 *            提示框宽?
	 * @param delay
	 *            延迟时间，默访000毫?
	 */
	tip : function(msg, title, width, delay) {
		if (msg == null) {
			return false;
		}
		var id = "tip_" + parseInt(100 * Math.random());
		var tipElement = "<div id=\""
				+ id
				+ "\" class=\"ui-widget-content ui-corner-all bz-tip-div\"><h3 class=\"ui-widget-header ui-corner-all\"></h3><p></p></div>";
		$(".bz-tip-div").remove();
		$("body").append(tipElement);
		var tipObj = $(".bz-tip-div");
		var h3 = tipObj.children("h3");
		var p = tipObj.children("p");
		if (title == null) {
			h3.css("display", "none");
		} else {
			h3.text(title);
		}
		p.text(msg);
		// var elementHeight = document.documentElement.clientHeight;
		var elementWidth = document.documentElement.clientWidth;
		var scrollTop = $(document).scrollTop();
		// tipObj.css("top",(((elementHeight-tipObj.outerHeight())/2)+scrollTop));
		tipObj.css("top", scrollTop);
		if (width != null) {
			tipObj.css("width", width);
		}
		tipObj.css("left", ((elementWidth - tipObj.outerWidth()) / 2));
		tipObj.slideDown("fast");
		if (delay == null) {
			delay = 3000;
		}
		setTimeout(function() {
			// $(".bz-tip-div").slideUp("fast");
			$("#" + id).slideUp("fast");
		}, delay);
	},
	/**
	 * 提示消息
	 *
	 * @param msg
	 *            消息
	 * @param delay
	 *            延迟关闭时间
	 */
	tip2 : function(msg, delay) {
		var id = "tip_" + parseInt(100 * Math.random());
		var tipElement = "<div id=\"" + id + "\" class=\"bz-tip\"></div>";
		$(".bz-tip").remove();
		$("body").append(tipElement);
		var tip = $(".bz-tip");
		// var elementHeight = document.documentElement.clientHeight;
		var elementWidth = document.documentElement.clientWidth;
		var scrollTop = $(document).scrollTop();
		tip.text(msg);
		// tip.css("top",(((elementHeight-tip.outerHeight())/2)+scrollTop));
		tip.css("top", scrollTop);
		tip.css("left", ((elementWidth - tip.outerWidth()) / 2));
		tip.slideDown("fast");
		if (delay == null) {
			delay = 3000;
		}
		setTimeout(function() {
			$("#" + id).slideUp("fast");
		}, delay);
	}
};

//启动必须运行的内容
$(document).ready(function(){
	//加载默认样式
	page.loadStyle();
	page.init();
	$("#navbar-container .ace-nav li").not("#navbar-container .ace-nav li li").bind("click",function(){
		if(!$(this).hasClass("open")) {
			$("#navbar-container .ace-nav .open").removeClass("open");
		}
		$(this).toggleClass("open");
	});
	$("#sidebar a:not(.dropdown-toggle)").click(function(){
		var $first = $("#breadcrumbs li:first");
		$("#breadcrumbs li:gt(0)").remove();
		$(this).parents("li").each(function(i, n){
			var text = $(n).find(".menu-text").html();
			if(text){
				$first.after($("<li><span class='icon-raquo'>&rsaquo;</span>"+text+"</li>"));
			}
		});
	});
});
$(window).scroll(function() {
	page._refurbishDialog();
	page._runGoTop();
});