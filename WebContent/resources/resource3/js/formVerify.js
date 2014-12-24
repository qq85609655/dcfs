var success = "SUCCESS"; //校验通过的返回值
var title = "formTitle"; //校验域的域标题属性名称
/****************************************************************************
** 表单域内容校验函数，要求所有的校验函数必须以formVerify的格式编写
** 返回值为字符串，"SUCCESS"表示校验通过，否则为校验不通过的提示信息
** 函数名可更改，但必须和formConfig文件中配置的函数名一致
** 函数的第一个参数为要校验的域的IHTMLElement对象，后面为自定义参数列表
** 注意: 所有自定义参数均以字符串类型传递。
*****************************************************************************/

function formVerify(field) {
	return "SUCCESS";
}


//数字校验
function numberVerify(field) {
	if (field.value.isNumber()) {
		return success;
	}
	return "只能填数字！";
}

//整数校验
function intVerify(field) {
	if (field.value.isInt()) {
		return success;
	}
	return "只能填半角型整数！";
}

//小数位数校验
function numberLengthVerify(field,length,precision) {
	if (field.value.isNumberLength(length,precision)) {
		return success;
	}
	return "整数位数最多"+(length-precision)+"位,小数位数最多" + precision + "位";
}

//浮点数校验
function floatVerify(field) {
	if (field.value.isFloat()) {
		return success;
	}
	return "只能填半角型浮点数！";
}

//正数校验
function plusVerify(field) {
	if (field.value.isPlus()) {
		return success;
	}
	return "只能填半角型正数！";
}

//正整数校验
function plusIntVerify(field) {
	if (field.value.isPlusInt()) {
		return success;
	}
	return "只能填半角型正整数！";
}

//正浮点数校验
function plusFloatVerify(field) {
	if (field.value.isPlusFloat()) {
		return success;
	}
	return "只能填半角型正浮点数！";
}

//负数校验
function minusVerify(field) {
	if (field.value.isMinus()) {
		return success;
	}
	return "只能填半角型负数！";
}

//负整数校验
function minusIntVerify(field) {
	if (field.value.isMinusInt()) {
		return success;
	}
	return "只能填半角型负整数！";
}

//负浮点数校验
function minusFloatVerify(field) {
	if (field.value.isMinusFloat()) {
		return success;
	}
	return "只能填半角型负浮点数！";
}

//电子邮件校验
function emailVerify(field) {
	if (field.value.isEmail()) {
		return success;
	}
	return "不是合法的电子邮件地址！";
}

//单词字符校验
function wordcharVerify(field) {
	if (field.value.isLeastCharSet()) {
		return success;
	}
	return "只能填半角型大小写字母、数字和下划线！";
}

//邮政编码校验
function zipVerify(field) {
	if (field.value.isZip()) {
		return success;
	}
	return "不符合邮政编码标准！";
}

//手机号校验
function mobileVerify(field) {
	if (field.value.isMobileTelephone()) {
		return success;
	}
	return "不符合手机号格式！";
}

//电话号码校验
function telephoneVerify(field) {

	if (field.value.isTelephone()) {
		return success;
	}
	return "不符合电话号码格式！标准格式为：(xxxx)xxxxxxxx或者xxxx-xxxxxxxx或者手机号";
}

//电话号码校验(可以是多个号码，以空格或逗号","分割)
function telephonesVerify(field) {
	var str = field.value;
	str = str.replace(","," ");
	str = str.replace("，"," ");	

	var telephones = str.split(" ");
	for(i=0; i<telephones.length; i++){
		if(telephones[i]==""){
			continue;
		}
		if (!telephones[i].isTelephone()) {
			return "不符合电话号码格式！标准格式为：(xxxx)xxxxxxxx或者xxxx-xxxxxxxx或者手机号，多个号码，使用空格或逗号分割";
		}
	}
	
	return success;
}

//日期格式校验
function dateVerify(field) {
	if (field.value.isDate()) {
		return success;
	}
	return "不符合日期格式标准！例如：2004-04-23";
}

//时间格式校验
function timeVerify(field) {
	if (field.value.isTime()) {
		return success;
	}
	return "不符合时间格式标准！例如：09:30:50";
}

//日期时间格式校验
function dateTimeVerify(field) {
	if (field.value.isDateTime()) {
		return success;
	}
	return "不符合日期时间格式标准！例如：2004-04-23 09:30:50";
}

//特殊字符校验
function hasSpecialCharVerify(field) {
	if (field.value.hasSpecialChar()) {
		return success;
	}
	return "不允许包含特殊字符！以下字符集为特殊字符集：" + specialChars.source;
}
function hasSearchCharVerify(field) {
	if (field.value.hasSearchSpecialChar()) {
		return success;
	}
	return "搜索条件不允许包含以下字符！：" + searchspecialChars.source;
}
function hasDBSpecialCharVerify(field) {
	if (field.value.hasDBSpecialChar()) {
		return success;
	}
	return "不允许包含特殊字符！以下字符集为特殊字符集：" + dbSpecialChars.source;
}
//校验域日期必须在特定域日期之后
function afterDateVerify(field, compFieldName, canEquals) {
	var field = field;
	var compField = document.getElementsByName(compFieldName);
	var compValue;
	if (compField != null && compField.length > 0) {
		compValue = compField[0].value;
	}
	if (field.value.isAfterDate(compValue, canEquals)) {
		return success;
	}
	return "必须在\"" + compField[0].getAttribute(title) + "\"之后！";
}

//校验域日期必须在当前日期之后
function afterTodayVerify(field, canEquals) {
	var field = field;
	var compValue=getSysDate();
	if (field.value.isAfterDate(compValue, canEquals)) {
		return success;
	}
	return "必须在当前日期之后！";
}

//校验域日期必须在特定域日期之前
function beforeDateVerify(field, compFieldName, canEquals) {
	var field = field;
	var compField = document.getElementsByName(compFieldName);
	var compValue;
	if (compField != null && compField.length > 0) {
		compValue = compField[0].value;
	}
	if (field.value.isBeforeDate(compValue, canEquals)) {
		return success;
	}
	return "必须在\"" + compField[0].getAttribute(title) + "\"之前！";
}

//校验域日期必须在当前日期之前
function beforeTodayVerify(field, canEquals) {
	var field = field;
	var compValue=getSysDate();
	if (field.value.isBeforeDate(compValue, canEquals)) {
		return success;
	}
	return "必须在当前日期之前！";
}

//校验域日期时间必须在特定域日期时间之后
function afterDateTimeVerify(field, compFieldName, canEquals) {
	var field = field;
	var compField = document.getElementsByName(compFieldName);
	var compValue;
	if (compField != null && compField.length > 0) {
		compValue = compField[0].value;
	}
	if (field.value.isAfterDateTime(compValue, canEquals)) {
		return success;
	}
	return "必须在\"" + compField[0].getAttribute(title) + "\"之后！";
}

//校验域日期时间必须在特定域日期时间之前
function beforeDateTimeVerify(field, compFieldName, canEquals) {
	var field = field;
	var compField = document.getElementsByName(compFieldName);
	var compValue;
	if (compField != null && compField.length > 0) {
		compValue = compField[0].value;
	}
	if (field.value.isBeforeDateTime(compValue, canEquals)) {
		return success;
	}
	return "必须在\"" + compField[0].getAttribute(title) + "\"之前！";
}

//在某两个值之间校验
function inValueVerify(field, lower, high, includeLower, includeHigher) {
	var value = field.value;
	if ( lower.isNumber() && high.isNumber()) {
		if(value.isNumber()){
			value = parseFloat(value);
		} else {
			return "必须输入数字！";
		}
		lower = parseFloat(lower);
		high = parseFloat(high);
	}
	if (lower >= high) {
		return "参数错误，小值必须小于大值！";
	}
	if (value > lower && value < high) {
		return success;
	}
	if (includeLower == "true" && value == lower) {
		return success;
	}
	if (includeHigher == "true" && value == high) {
		return success;
	}
	return "必须在\"" + lower + "\"和\"" + high + "\"之间！";
}

//在某两个值之外校验
function outValueVerify(field, lower, high, includeLower, includeHigher) {
	var value = field.value;
	if (value.isNumber() && lower.isNumber() && high.isNumber()) {
		value = parseFloat(value);
		lower = parseFloat(lower);
		high = parseFloat(high);
	}
	if (lower >= high) {
		return "参数错误，小值必须小于大值！";
	}
	if (value < lower || value > high) {
		return success;
	}
	if (includeLower == "true" && value == lower) {
		return success;
	}
	if (includeHigher == "true" && value == high) {
		return success;
	}
	return "必须在\"" + lower + "\"和\"" + high + "\"之外！";
}

//某两个域之间校验
function inFieldVerify(field, lowerField, highField, includeLower, includeHigher) {
	var lower = document.getElementsByName(lowerField)[0].value;
	var high = document.getElementsByName(highField)[0].value;
	if (lower == null || lower.trim() == "") {
		return "\"" + document.getElementsByName(lowerField)[0].getAttribute(title) + "\"作为小值不可为空！";
	}
	if (high == null || high.trim() == "") {
		return "\"" + document.getElementsByName(highField)[0].getAttribute(title) + "\"作为大值不可为空！";
	}
	return inValueVerify(field, lower, high, includeLower, includeHigher);
}

//某两个域之外校验
function outFieldVerify(field, lowerField, highField, includeLower, includeHigher) {
	var lower = document.getElementsByName(lowerField)[0].value;
	var high = document.getElementsByName(highField)[0].value;
	if (lower == null || lower.trim() == "") {
		return "\"" + document.getElementsByName(lowerField)[0].getAttribute(title) + "\"作为小值不可为空！";
	}
	if (high == null || high.trim() == "") {
		return "\"" + document.getElementsByName(highField)[0].getAttribute(title) + "\"作为大值不可为空！";
	}
	return outValueVerify(field, lower, high, includeLower, includeHigher);
}

//大于某个值校验
function uperValueVerify(field, compValue, canEquals) {
	var value = field.value;
	if (value.isNumber() && compValue.isNumber()) {
		value = parseFloat(value);
		compValue = parseFloat(compValue);
	}
	if (value > compValue) {
		return success;
	}
	if (canEquals == "true" && value == compValue) {
		return success;
	}
	return "必须大于" + (canEquals == "true" ? "或等于\"" : "\"") + compValue + "\"！";
}

//小于某个值校验
function lowerValueVerify(field, compValue, canEquals) {
	var value = field.value;
	if (value.isNumber() && compValue.isNumber()) {
		value = parseFloat(value);
		compValue = parseFloat(compValue);
	}
	if (value < compValue) {
		return success;
	}
	if (canEquals == "true" && value == compValue) {
		return success;
	}
	return "必须小于" + (canEquals == "true" ? "或等于\"" : "\"") + compValue + "\"！";
}

//大于某个域值校验
function uperFieldVerify(field, compField, canEquals) {
	var compValue = document.getElementsByName(compField)[0].value;
	if (compValue == null) {
		compValue = "";
	}
	return uperValueVerify(field, compValue, canEquals);
}

//小于某个域值校验
function lowerFieldVerify(field, compField, canEquals) {
	var compValue = document.getElementsByName(compField)[0].value;
	if (compValue == null) {
		compValue = "";
	}
	return lowerValueVerify(field, compValue, canEquals);
}

//判断身份证是否正确
//通过模得到对应的校验码
var powers=new Array("7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2");
var parityBit=new Array("1","0","X","9","8","7","6","5","4","3","2");

function idCardVerify(field){
     var _id=field.value;
     if(_id=="") return;
     var _valid=false;
     if(_id.length==15){
         _valid=validId15(_id);
     }else if(_id.length==18){
         _valid=validId18(_id);
     }
  	 if(!_valid){
         return "身份证号码有误,请检查!";
     }
     return success;
}
//校验18位的身份证号码
function validId18(_id){
    _id=_id+"";
    var _num=_id.substr(0,17);
    var _parityBit=_id.substr(17);
    var _power=0;
    for(var i=0;i< 17;i++){
        //校验每一位的合法性
        if(_num.charAt(i)<'0'||_num.charAt(i)>'9'){
            return false;
            break;
        }else{
            //加权
            _power+=parseInt(_num.charAt(i))*parseInt(powers[i]);
        }
    }
    //取模
    var mod=parseInt(_power)%11;
    if(parityBit[mod]==_parityBit){
        return true;
    }
    return false;
}
   //校验15位的身份证号码
function validId15(_id){
    _id=_id+"";
    for(var i=0;i<_id.length;i++){
        //校验每一位的合法性
        if(_id.charAt(i)<'0'||_id.charAt(i)>'9'){
            return false;
            break;
        }
    }
    var year=_id.substr(6,2);
    var month=_id.substr(8,2);
    var day=_id.substr(10,2);
    //校验年份位
    if(year<'01'||year >'90') return false;
    //校验月份
    if(month<'01'||month >'12') return false;
    //校验日
    if(day<'01'||day >'31') return false;
    return true;
}