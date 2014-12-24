//���ҳ���һЩ����
var page={
	"defaultStyle":"base",
	"params" : null,
	click_event: $.fn.tap ? "tap" : "click",
	/**
	 * ������ʽ
	 *
	 * @param style
	 *            ��ʽ����
	 */
	loadStyle:function(){
		$("body").attr("class",this.defaultStyle);
	},
	/**
	 * ����ҳ����ʽ
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
			var topElement = "<div class=\"bz-gotop\" onclick=\"top.page._goTop();\" title=\"�ص�����\"></div>";
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
	 * ��Ϣ��ʾ
	 *
	 * @param title
	 *            �������?
	 * @param uri
	 *            ����ҳ��?
	 * @param func
	 *            �رպ󴰿�ִ�еķ���
	 * @param width
	 *            ���
	 * @param height
	 *            �߶�
	 * @param style
	 *            ��ʾ��ʽ��alert(Ĭ��),ask,msg,error
	 * @param modal
	 *            �Ƿ�ģʽ��Ĭ��?ue
	 */
	showPage : function(title, uri, params, width, height, buttons) {
		var dialogElement = "<div id=\"bz-dialog-showPage\" ><iframe class=\"modalFrame\" id=\"modalFrame\" name=\"modalFrame\"></iframe></div>";
		this.params = params;
		$("#bz-dialog-showPage").remove();
		$("body").append(dialogElement);
		var dialog = $("#bz-dialog-showPage");
		if (title == null) {
			title = "ѡ����Ϣ";
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
	 * �رմ���
	 */
	closePage : function() {
		$("#bz-dialog-showPage").dialog("close");
	},
	/**
	 * �رմ���
	 */
	closeAlert : function() {
		$("#bz-dialog-message").dialog("close");
	},
	/**
	 * ��Ϣ��ʾ
	 *
	 * @param msg
	 *            ��Ϣʹ
	 * @param title
	 *            ��Ϣ����
	 * @param func
	 *            �رպ󴰿�ִ�еķ���
	 * @param width
	 *            ���
	 * @param height
	 *            �߶�
	 * @param style
	 *            ��ʾ��ʽ��alert(Ĭ��),ask,msg,error
	 * @param modal
	 *            �Ƿ�ģʽ��Ĭ��?ue
	 * @param buttons
	 *            ��ť����ִ�еķ���json����
	 */
	alert : function(msg, title, func, width, height, style, modal, buttons) {
		// �ж�ҳ����û��dialog��û�еĻ�����
		var dialogElement = "<div id=\"bz-dialog-message\" ><table class=\"bz-message\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"48px\"><div></div></td><td><p></p></td></tr></table></div>";
		/*
		 * var dialog = $("#bz-dialog-message"); if (dialog.length==0){
		 * $("body").append(dialogElement); dialog = $("#bz-dialog-message"); }
		 */
		$("#bz-dialog-message").remove();
		$("body").append(dialogElement);
		var dialog = $("#bz-dialog-message");
		if (title == null) {
			title = "��ʾ��Ϣ";
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
				"ȡ��": function() {
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
	 * ˢ����ʾ?
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
	 * ��ʾ��Ϣ
	 *
	 * @param msg
	 *            ��Ϣ����
	 * @param title
	 *            ���⣬?��Ϊnull������ʾ��?
	 * @param width
	 *            ��ʾ���?
	 * @param delay
	 *            �ӳ�ʱ�䣬Ĭ��000��?
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
	 * ��ʾ��Ϣ
	 *
	 * @param msg
	 *            ��Ϣ
	 * @param delay
	 *            �ӳٹر�ʱ��
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

//�����������е�����
$(document).ready(function(){
	//����Ĭ����ʽ
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