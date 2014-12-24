//判断是否安装Flash插件
function isFlashEnable() {
	try {
		// IE版本
		var swf_ie = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
	} catch (err) {
		try {
			// FireFox,Chrome版本
			var swf_f_c = navigator.plugins["Shockwave Flash"];
			if (swf_f_c == undefined) {
				if (confirm("访问本系统需要安装flash,马上安装吗?")) {
					window.open("http://www.adobe.com/go/getflashplayer","_self");
				}
			}
		} catch (ee) {
			if (confirm("访问本系统需要安装flash,马上安装吗?")) {
				window.open("http://www.adobe.com/go/getflashplayer","_self");
			}
		}
	}
}