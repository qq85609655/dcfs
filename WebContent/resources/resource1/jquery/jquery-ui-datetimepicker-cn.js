$.datepicker.regional['cn'] = {
	closeText: '确定',
	prevText: '<向前',
	nextText: '向后>',
	currentText: '今天',
	monthNamesShort: ['一月','二月','三月','四月','五月','六月','七月',' 八月','九月','十月','十一月','十二月'],
	dayNamesMin: ['日','一','二','三','四','五','六'],
	dateFormat: 'yy-mm-dd',
	firstDay: 1,
	isRTL: false,
	showMonthAfterYear: false,
	yearSuffix: ''
};
$.datepicker.setDefaults($.datepicker.regional['cn']);
$.timepicker.regional['zh-CN'] = {
	timeOnlyTitle: '选择时间',
	timeText: '时间',
	hourText: '小时',
	minuteText: '分钟',
	secondText: '秒钟',
	millisecText: '微秒',
	timezoneText: '时区',
	currentText: '现在时间',
	closeText: '确定',
	timeFormat: 'hh:mm:00',
	amNames: ['AM', 'A'],
	pmNames: ['PM', 'P'],
	ampm: false
};
$.timepicker.setDefaults($.timepicker.regional['zh-CN']);