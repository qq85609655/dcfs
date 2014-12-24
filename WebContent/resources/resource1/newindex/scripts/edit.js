/**
 * 加载tab标签
 */
$(document).ready(function() {
	edit.loadPageData();
});

var edit = {
	/**
	 * 加载页面数据至缓冲区，目的是为了判断数据是否发生改变
	 */
	loadPageData : function() {
		var txt = $("input[type='text']:not([data='false'])");
		var select = $("select:not([data='false'])");
		var radio = $("input[type='radio']:not([data='false'])");
		var checkbox = $("input[type='checkbox']:not([data='false'])");
		var textarea = $("textarea:not([data='false'])");
		txt.data("old", txt.val());
		txt.data("background-color", txt.css("background-color"));
		select.data("old", select.val());
		select.data("background-color", select.css("background-color"));
		radio.data("old", radio.prop("checked"));
		radio.data("background-color", radio.css("background-color"));
		checkbox.data("old", checkbox.prop("checked"));
		checkbox.data("background-color", checkbox.css("background-color"));
		textarea.data("old", textarea.html());
		textarea.data("background-color", textarea.css("background-color"));
	},
	/**
	 * 检查数据是否改变
	 * @param flag 是否标记 1 标记，2 取消，null 0忽略
	 */
	checkData : function(flag) {
		var by = $("body");
		var f = by.data("flag");
		if (flag==null){
			if (f!=null){
				flag=f;
			}
		}else{
			by.data("flag",flag);
		}
		var warnColor = "#F9F900";
		var txt = $("input[type='text']:not([data='false'])");
		var select = $("select:not([data='false'])");
		var radio = $("input[type='radio']:not([data='false'])");
		var checkbox = $("input[type='checkbox']:not([data='false'])");
		var textarea = $("textarea:not([data='false'])");
		var change = true;
		$.each(txt, function(i, val) {
			if ($(val).val() != $(val).data("old")) {
				change = false;
				if (flag=="1"){
					$(val).css("background-color",warnColor);
				}
				if (flag=="2"){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
				if (flag==null){
					return false;
				}
			}else{
				if (flag!=null){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
			}
		});
		if (flag==null && change==false){
			return change;
		}
		$.each(select, function(i, val) {
			if ($(val).val() != $(val).data("old")) {
				change = false;
				if (flag=="1"){
					$(val).css("background-color",warnColor);
				}
				if (flag=="2"){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
				if (flag==null){
					return false;
				}
			}else{
				if (flag!=null){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
			}
		});
		if (flag==null && change==false){
			return change;
		}
		$.each(radio, function(i, val) {
			if ($(val).prop("checked") != $(val).data("old")) {
				change = false;
				if (flag=="1"){
					$(val).css("background-color",warnColor);
				}
				if (flag=="2"){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
				if (flag==null){
					return false;
				}
			}else{
				if (flag!=null){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
			}
		});
		if (flag==null && change==false){
			return change;
		}
		$.each(checkbox, function(i, val) {
			if ($(val).prop("checked") != $(val).data("old")) {
				change = false;
				if (flag=="1"){
					$(val).css("background-color",warnColor);
				}
				if (flag=="2"){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
				if (flag==null){
					return false;
				}
			}else{
				if (flag!=null){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
			}
		});
		if (flag==null && change==false){
			return change;
		}
		$.each(textarea, function(i, val) {
			if ($(val).html() != $(val).data("old")) {
				change = false;
				if (flag=="1"){
					$(val).css("background-color",warnColor);
				}
				if (flag=="2"){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
				if (flag==null){
					return false;
				}
			}else{
				if (flag!=null){
					var bc = $(val).data("background-color");
					if (bc==null){
						bc="none";
					}
					$(val).css("background-color",bc);
				}
			}
		});
		if (flag==null && change==false){
			return change;
		}
		return change;
	}
};