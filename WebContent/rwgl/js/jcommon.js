var MSG_ERROR_PAGE_NUM = '页数应在1~10000000之间。';
var MSG_OVER_PAGE_NUM = '已超出总页数范围！';

var ExcelXJBgcolor = 19;//Excel:小计行背景颜色
var ExcelHJBgcolor = 15;//40;//Excel:合计行背景颜色
var ExcelZJBgcolor = 38;//Excel:总计行背景颜色
var ExcelLMBgcolor = 15;//23;//Excel:表头行背景颜色

/*函数说明：@jindun  1/9/2003
*
*===================================
* 判断是否是数字
* is_numeric(sValue)
* 参数:1——sValue:要判断的字符串
*===================================
*
*===================================
* 判断小数格式是否正确
* is_exactNumeric(sValue,posDigit,decDigit)
* 参数：1——sValue:要判断的字符串
*      2——posDigit：小数正数位
*	   3——decDigit：小数小数位
* 例： is_exactNumeric(1289.234,3,2) 返回false
*     is_exactNumeric(12.89234,3,2) 返回true
*     适用于身高、金额的判断
*===================================
*
*===================================
* 判断是否是正数
* is_positiveNumeric(sValue)
* 参数:1——sValue:要判断的字符串
*===================================
*
*===================================
* 判断是否是非负整数
* is_int(sValue)
* 参数:1——sValue:要判断的字符串
*===================================
*
*===================================
* 判断是否是正整数
* is_positiveInt(sValue)
* 参数:1——sValue:要判断的字符串
*===================================
*
*===================================
* 数字格式化
* formatNumber(_express, iSize)
* 参数:
*     _express: double
*     iSize:    int
* 例：
* _formatNumber(12.3456, 3) = 12.346
*===================================
*
*===================================
* 函数去掉一字符串两边指定的字符串
* Trim(str1,str2)
* 参数
*    1.str1:要处理的字符串
*    2.str2：去掉的字符串；不传该参数，则本方法默认该参数的值为空格．
*===================================
*
*===================================
* 得到当前客户端日期
* _getCurrentDate(iType)
* 参数
*   iType:返回的日期格式
*   0    yyyy-mm-dd
*   1    yyyy-mm-dd hh
*   2    yyyy-mm-dd hh:mi
*   3    yyyy-mm-dd hh:mi:ss
*===================================
*
*===================================
* 判断是否是日期
* is_Date(sValue, iType)
* 参数说明：sValue——要判断的字符串
*         iType——日期类型
*            0——YYYY-MM-DD
*             1——YYYY-MM-DD HH
*             2——YYYY-MM-DD HH:MI
*             3——YYYY-MM-DD HH:MI:SS
* 返回值：如果不和法返回false
*       如果合法，根据iType指定的日期格式返回日期
*===================================
*
*===================================
* 判断是否是身份证号
* isIDCard(sInput) {
* 参数:1——sInput：参数值
*===================================
*
*===================================
* 将15位身份证号转换为18位
* changeIDCard(v)
* 参数： v:要转换的字符串
*===================================
*
*===================================
* 求判断一个字符是否是ASCII值
* isASCII( cValue )
* 参数:1——cValue：参数值
*===================================
*
*===================================
* 将一个字符串中的汉字计为2个字符，以利于数据库中正确处理
* calcRealLength(sString)
* 参数:1——待记数的字符串
*===================================
*
*===================================
//生成记录日志
//参数依次为：表格宽度、记录状态、登记人、登记时间、最后修改人、最后修改时间
WriteLog(_width, jl_zt, jl_djr, jl_djsj, jl_zhdjr, jl_zhdjsj)
*===================================
*
*===================================
* 判断时间 hh:mi:ss格式正确返回true
* ratifyTime(str)
* 参数:1——时间的字符串
*===================================
*
*/



//判断是否是数字
//参数
//1——sValue:要判断的字符串
function is_numeric(sValue) {
	var Ret = true;
	var NumStr = "0123456789";
	var decUsed = false;
	var chr;

	if (sValue.length < 1) {
		return false;
	}

    if (sValue == ".") {
        Ret = false;
    }

	for (var i = 0; i < sValue.length; i++) {
		chr = sValue.charAt(i);
		if (NumStr.indexOf(chr,0) == -1) {
			if ((!decUsed) && chr == ".") {
				decUsed = true;
			} else {
				Ret = false;
			}
		}
	}

	return(Ret);
}

//* 判断小数格式是否正确
function is_exactNumeric(sValue,posDigit,decDigit){
	var Ret = true;
	var iSize = 0;
	var _value;
	if (!is_numeric(sValue)) {
		Ret = false;
	}
	if (!is_positiveInt(posDigit) || !is_int(decDigit)){
		Ret = false;
	}
	iSize = posDigit + 1 + decDigit;
	_value = formatNumber(sValue,decDigit);
	if (_value.length>iSize){
		Ret = false;
	}

	return(Ret);
}

// 判断是否是正数
//参数
//1——sValue:要判断的字符串
function is_positiveNumeric(sValue) {
	if (!is_numeric(sValue)) {
        return false;
	}
	if (sValue.charAt(0) == "-" && sValue != "") {
        return false;
    }

	return true;
}

// 判断是否是非负整数
//参数
//1——sValue:要判断的字符串
function is_int(sValue) {
	var Ret = true;
	var NumStr = "0123456789";
	var chr;

	for (var i = 0; i < sValue.length; i++) {
		chr = sValue.charAt(i);
		if (NumStr.indexOf(chr, 0) == -1) {
			Ret = false;
		}
	}

    if (Number(sValue) > 100000000) {
        Ret = false;
    }

	return(Ret);
}

// 判断是否是正整数
//参数
//1——sValue:要判断的字符串
function is_positiveInt(sValue) {
	if (!is_int(sValue)) {
        return false;
	}

	//if ( Number(sValue) == 0 && sValue != "") {
    //    return false;
   // }

	return true;
}

/**
 * Format number
 * parameter:
 *     _express: double
 *     iSize:    int
 *
 * _formatNumber(12.3456, 3) = 12.346
 */
function formatNumber(_express, iSize) {
	_express = _express - 1 + 1;
	iSize = iSize - 1 + 1;

	if (iSize > 10) {
		iSize = 10;
	}
	if (iSize < 0) {
		iSize = 0;
	}
	var iKey1 = Math.pow(10, 12);
	var dTemp = Math.round(_express * iKey1);
	var sTemp = "" + dTemp;
	var iEndNum = sTemp.substring(sTemp.length - 1, sTemp.length) - 1 + 1
	if (iEndNum = 9) {
		dTemp = dTemp + 1;
	} else {
		dTemp = dTemp + 2;
	}

	dTemp = dTemp / iKey1;

	var iKey = Math.pow(10, iSize);
	dTemp = Math.round(dTemp * iKey);

	_sValue = "" + dTemp / iKey;

	if (iSize > 0) {
		if (_sValue.indexOf(".", 0) == -1) {
			_sValue = _sValue + ".";
			for (i = 0; i < iSize; i++) {
				_sValue = _sValue + "0";
			}
		} else {
			iPosition = _sValue.indexOf(".", 0);
			iLen = _sValue.length;
			for (i = 0; i < iSize - iLen + iPosition + 1; i++) {
				_sValue = _sValue + "0";
			}
		}
	}
	return _sValue;
}

function formatNumFraction(number,pattern)
{
    var str = number.toString();
    var strInt;
    var strFloat;
    var formatInt;
    var formatFloat;
    if(/\./g.test(pattern))
    {
        formatInt = pattern.split('.')[0];
        formatFloat = pattern.split('.')[1];
    }
    else
    {
        formatInt = pattern;
        formatFloat = null;
    }

    if(/\./g.test(str))
    {
        if(formatFloat!=null)
        {
            var tempFloat = Math.round(parseFloat('0.'+str.split('.')[1])*Math.pow(10,formatFloat.length))/Math.pow(10,formatFloat.length);
            strInt = (Math.floor(number)+Math.floor(tempFloat)).toString();                
            strFloat = /\./g.test(tempFloat.toString())?tempFloat.toString().split('.')[1]:'0';          
        }
        else
        {
            strInt = Math.round(number).toString();
            strFloat = '0';
        }
    }
    else
    {
        strInt = str;
        strFloat = '0';
    }
    if(formatInt!=null)
    {
        var outputInt = '';
        var zero = formatInt.match(/0*$/)[0].length;
        var comma = null;
        if(/,/g.test(formatInt))
        {
            comma = formatInt.match(/,[^,]*/)[0].length-1;
        }
        var newReg = new RegExp('(\\d{'+comma+'})','g');

        if(strInt.length<zero)
        {
            outputInt = new Array(zero+1).join('0')+strInt;
            outputInt = outputInt.substr(outputInt.length-zero,zero)
        }
        else
        {
            outputInt = strInt;
        }

        var 
        outputInt = outputInt.substr(0,outputInt.length%comma)+outputInt.substring(outputInt.length%comma).replace(newReg,(comma!=null?',':'')+'$1')
        outputInt = outputInt.replace(/^,/,'');

        strInt = outputInt;
    }

    if(formatFloat!=null)
    {
        var outputFloat = '';
        var zero = formatFloat.match(/^0*/)[0].length;

        if(strFloat.length<zero)
        {
            outputFloat = strFloat+new Array(zero+1).join('0');
            //outputFloat = outputFloat.substring(0,formatFloat.length);
            var outputFloat1 = outputFloat.substring(0,zero);
            var outputFloat2 = outputFloat.substring(zero,formatFloat.length);
            outputFloat = outputFloat1+outputFloat2.replace(/0*$/,'');
        }
        else
        {
            outputFloat = strFloat.substring(0,formatFloat.length);
        }

        strFloat = outputFloat;
    }
    else
    {
        if(pattern!='' || (pattern=='' && strFloat=='0'))
        {
            strFloat = '';
        }
    }

    return strInt+(strFloat==''?'':'.'+strFloat);
}


//Trim函数去掉一字符串两边指定的字符串
//参数
//   1.str1:要处理的字符串
//   2.str2：去掉的字符串；不传该参数，则本方法默认该参数的值为空格．
function Trim(str1,str2){
	if (str2 == null) {
		str2 = " ";
	}

    var hasStr2 = true;
    while (hasStr2){
        if (str1.length<str2.length){
            return str1;
        }
        if (str1.substring(0,str2.length)==str2 ){
            str1 = str1.substring(str2.length,str1.length);
            hasStr2 = true;
        }
        else if( str1.substring(str1.length-str2.length,str1.length)==str2){
            str1 = str1.substring(0,str1.length-str2.length);
            hasStr2 = true;
        }else{
            hasStr2 = false;
        }
    }
	return str1;
}

//得到当前客户端日期
//参数
//   iType:返回的日期格式
//   0    yyyy-mm-dd
//   1    yyyy-mm-dd hh
//   2    yyyy-mm-dd hh:mi
//   3    yyyy-mm-dd hh:mi:ss
function _getCurrentDate(iType) {
     var _newDate = new Date()
	 var _Year = _newDate.getYear()
	 var _Month = 1 + _newDate.getMonth()
	 var _Day = _newDate.getDate()
	 var _Hour = _newDate.getHours();
	 var _Minute = _newDate.getMinutes();
	 var _Second = _newDate.getSeconds();

	 if (_Month.toString().length == 1) {
	     _Month = "0" + _Month;
     }

	 if (_Day.toString().length == 1) {
	     _Day = "0" + _Day;
	 }

	 if (_Hour.toString().length == 1) {
	     _Hour = "0" + _Hour;
	 }

	 if (_Minute.toString().length == 1) {
	     _Minute = "0" + _Minute;
	 }

	 if (_Second.toString().length == 1) {
	     _Second = "0" + _Second;
	 }

	 var _sDate = "";

	 switch (iType) {
		case 0:
			_sDate = _Year + "-" + _Month + "-" + _Day;
			break;
		case 1:
			_sDate = _Year + "-" + _Month + "-" + _Day + " " + _Hour;
			break;
		case 2:
			_sDate = _Year + "-" + _Month + "-" + _Day + " " + _Hour + ":" + _Minute;
			break;
		case 3:
			_sDate = _Year + "-" + _Month + "-" + _Day + " " + _Hour + ":" + _Minute + ":" + _Second;
			break;
	 }

	 return _sDate
}

//函数说明:判断是否是日期，
//参数说明：sValue——要判断的字符串
//         iType——日期类型
//             0——YYYY-MM-DD
//             1——YYYY-MM-DD HH
//             2——YYYY-MM-DD HH:MI
//             3——YYYY-MM-DD HH:MI:SS
//             4——YYYY年MM月DD日
//返回值：
//       如果为空返回空
//       如果不和法返回false
//       如果合法，根据iType指定的日期格式返回日期
function is_Date(sValue, iType) {
	var sDateRange1 = "0123456789-/. :"//日期字符范围
	var sDateRange2 = "0123456789"//日期字符范围

    sValue = Trim(sValue);

	if (sValue == "") {
		return sValue;
	}

	if (iType == null) {
		iType = 0;
	}

	tempValue = sValue.replace(/\//g,"");
	tempValue = tempValue.replace(/\./g,"");
	tempValue = tempValue.replace(/\-/g,"");
	tempValue = tempValue.replace(/\ /g,"");
	tempValue = tempValue.replace(/\:/g,"");

	if (tempValue.length > 14) {//字符串长度不能超过14
		return false;
	}

	var IFExistDigit = false;
	for (i = 0; i < sValue.length; i++) {
		var _tempStr = sValue.charAt(i);
		if (sDateRange1.indexOf(_tempStr, 0) == -1) {//包含非法字符
			return false;
			break;
		}

		if (sDateRange2.indexOf(_tempStr, 0) > -1) {
			IFExistDigit = true;
		}
	}

	if (IFExistDigit == false) {//不包含数字
		return false;
	}

	sValue = sValue.replace(/\//g,"-");
	sValue = sValue.replace(/\./g,"-");

	if (sValue.split("-").length > 3) {//“-”字符的个数不能为大于3
		return false;
	}
	if (sValue.split(":").length > 3) {//“:”字符的个数不能为大于3
		return false;
	}
	if (sValue.split(" ").length > 2) {//“ ”字符的个数不能为大于2
		return false;
	}
	if (sValue.split("-").length == 1 && sValue.split(":").length > 1) {//只有“：”无“-”则错误
		return false;
	}

	var aValue = sValue.split("-");
	var iYear = null;
	var iMonth = null;
	var iDay = null;
	var iHours = null;
	var iMinutes = null;
	var iSeconds = null;

	if (!is_int(aValue[0])) {//年份不是非副整数
		return false;
	}
	iYear = aValue[0] - 1 + 1;
	if (iYear < 1900 || iYear > 2050) {//年份应在1950——2050之间
		return false;
	}

	if (aValue.length > 1) {//月份
		if (!is_int(aValue[1])) {//月份不是非副整数
			return false;
		}
		iMonth = aValue[1] - 1 + 1;
		if (iMonth < 0 || iMonth > 12) {//月份在1-12之间
			return false;
		}
	}

	if (aValue.length == 3) {//日期
		var aValue1 = aValue[2].split(" ");
		if (!is_int(aValue1[0])) {//日期不是非副整数
			return false;
		}
		iDay = aValue1[0] - 1 + 1;
		switch (iMonth) {
			case 0:
				if (iDay != 0) {
					return false;
				}
				break;
			case 1:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 2:
				if ((iDay < 0) || (iYear % 4 == 0 && iDay > 29) || (iYear % 4 != 0 && iDay > 28)) return false;
				break;
			case 3:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 4:
				if (iDay < 0 || iDay > 30) return false;
				break;
			case 5:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 6:
				if (iDay < 0 || iDay > 30) return false;
				break;
			case 7:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 8:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 9:
				if (iDay < 0 || iDay > 30) return false;
				break;
			case 10:
				if (iDay < 0 || iDay > 31) return false;
				break;
			case 11:
				if (iDay < 0 || iDay > 30) return false;
				break;
			case 12:
				if (iDay < 0 || iDay > 31) return false;
				break;
		}

		if (aValue1.length == 2) {
			var aValue2 = aValue1[1].split(":");
			if (!is_int(aValue2[0])) {//小时不是非副整数
				return false;
			}
			iHours = aValue2[0] - 1 + 1;
			if ((iMonth == 0 || iDay == 0) && iHours != 0) {
				return false;
			}

			if (iHours < 0 || iHours > 23) {//小时应在0—23之间
				return false;
			}

			if (aValue2.length > 1) {
				if (!is_int(aValue2[1])) {//分不是非副整数
					return false;
				}

				iMinutes = aValue2[1] - 1 + 1;
				if ((iMonth == 0 || iDay == 0) && iMinutes != 0) {
					return false;
				}
				if (iMinutes < 0 || iMinutes > 59) {//分应在0—59之间
					return false;
				}
			}

			if (aValue2.length == 3) {
				if (!is_int(aValue2[2])) {//秒不是非副整数
					return false;
				}

				iSeconds = aValue2[2] - 1 + 1;
				if ((iMonth == 0 || iDay == 0) && iSeconds != 0) {
					return false;
				}
				if (iSeconds < 0 || iSeconds > 59) {//秒应在0—59之间
					return false;
				}
			}
		}
	}

	if (iYear == null) {
		return false;
	}

	sReturn = "" + iYear;
	if (iMonth == null) {
		sReturn = sReturn + "00"
	} else {
		if (iMonth < 10) {
			sReturn = sReturn + "0" + iMonth;
		} else {
			sReturn = sReturn + iMonth;
		}
	}
	if (iDay == null) {
		sReturn = sReturn + "00"
	} else {
		if (iDay < 10) {
			sReturn = sReturn + "0" + iDay;
		} else {
			sReturn = sReturn + iDay;
		}
	}
	if (iHours == null) {
		sReturn = sReturn + "00"
	} else {
		if (iHours < 10) {
			sReturn = sReturn + "0" + iHours;
		} else {
			sReturn = sReturn + iHours;
		}
	}
	if (iMinutes == null) {
		sReturn = sReturn + "00"
	} else {
		if (iMinutes < 10) {
			sReturn = sReturn + "0" + iMinutes;
		} else {
			sReturn = sReturn + iMinutes;
		}
	}

	if (iSeconds == null) {
		sReturn = sReturn + "00"
	} else {
		if (iSeconds < 10) {
			sReturn = sReturn + "0" + iSeconds;
		} else {
			sReturn = sReturn + iSeconds;
		}
	}

	switch (iType) {
		case 0:
			sReturn = sReturn.substring(0, 4) + "-" + sReturn.substring(4, 6) + "-" + sReturn.substring(6, 8);
			break;
		case 1:
			sReturn = sReturn.substring(0, 4) + "-" + sReturn.substring(4, 6) + "-" + sReturn.substring(6, 8) + " " + sReturn.substring(8, 10);
			break;
		case 2:
			sReturn = sReturn.substring(0, 4) + "-" + sReturn.substring(4, 6) + "-" + sReturn.substring(6, 8) + " " + sReturn.substring(8, 10) + ":" + sReturn.substring(10, 12);
			break;
		case 3:
			sReturn = sReturn.substring(0, 4) + "-" + sReturn.substring(4, 6) + "-" + sReturn.substring(6, 8) + " " + sReturn.substring(8, 10) + ":" + sReturn.substring(10, 12) + ":" + sReturn.substring(12, 14);
			break;
		case 4:
			sReturn = sReturn.substring(0, 4) + "年" + sReturn.substring(4, 6) + "月" + sReturn.substring(6, 8) + "日";
			break;
	}

	return sReturn;
}

//判断是否是身份证号
function isIDCard(sInput) {
	var NumStr="0123456789";
	var NumStr_1="0123456789Xx";

	if (sInput == "") {
		return false;
	}

	if (sInput.length != 15 && sInput.length != 18)	{
		return false;
	}

	if (sInput.length == 15) {
		for (i = 0; i < sInput.length; i++)
		{
			if (NumStr.indexOf(sInput.charAt(i),0) == -1)
			{
				return false;
			}
		}
	} else {
		for (i = 0;i < sInput.length - 1; i++)
		{
			if (NumStr.indexOf(sInput.charAt(i), 0) == -1)
			{
				return false;
			}
		}

		if (NumStr_1.indexOf(sInput.charAt(sInput.length - 1), 0) == -1)
		{
			return false;
		}
	}

	return true;
}

//将15位身份证号转换为18位
//参数
//       v:要转换的字符串
function changeIDCard(v)
{
	var wi=new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1) ;
	var ai=new Array ('1','0','x','9','8','7','6','5','4','3','2');
	if (v.length==15) {
		v=v.substring(0,6)+"19"+v.substring(6,15);
	}
	if (v.length==18) {
		v=v.substring(0,17);
	}
	if (v.length < 17) {
		return false;
	}
	var sum=0;
	for (var i=0;i<17;i++) {
		sum=sum+wi[i]*v.substring(i,i+1);
	}
	code=ai[sum%11];

	return v+code;
}

// The following added by Zhenghao
// 2000-09-29
//求判断一个字符是否是ASCII值
//cValue：参数值
function isASCII(cValue)
{
	var sFormat = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	var iLocation = sFormat.indexOf( cValue );
	return( iLocation != -1 );
}

//将一个字符串中的汉字计为2个字符，以利于数据库中正确处理
//sString：待记数的字符串
function calcRealLength(sString)
{
	var iLength = 0;	// 真实长度记数器
	for( i = 0; i < sString.length; i ++ )
	{
		if( isASCII( sString.charAt( i ) ) )
		{
			iLength += 1;
		}
		else
		{
			iLength += 2;
		}
	}

	return(iLength);
}

function deletepic(table, fieldzp, zptype, zpname, fieldkey, keyvalue, zpobject, buttonobject)
{
	var _url = "/operation/Servlet/COMMON/ZP_Delete_Servlet?tableName=" + table;
	_url += "&fieldZP=" + fieldzp;
	_url += "&zpType=" + zptype;
	_url += "&zpName=" + zpname;
	_url += "&fieldKey=" + fieldkey;
	_url += "&keyValue=" + keyvalue;
	_url += "&random=" + Math.random();
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.open("GET", _url, false);
	xmlhttp.send("");

	var _response = xmlhttp.responseText;
	_response = Trim(_response);
 	//alert(_response);
	if(_response == "true")
	{
		if(zpobject != null)
		{
			zpobject.innerHTML = " 照 片 ";
		}
		if(buttonobject != null)
		{
			buttonobject.outerHTML = "";
		}
		return true;
	}
	else
	{
		alert("照片删除失败！");
		return false;
	}

}

//生成记录日志
//参数依次为：表格宽度、记录状态、登记人、登记时间、最后修改人、最后修改时间
function WriteLog(_width, jl_zt, jl_djr, jl_djsj, jl_zhdjr, jl_zhdjsj) {
    _str = "<table align='center' width='" + _width + "' border='0' cellspacing='0' cellpadding='0'>";
    _str = _str + "<tr>";
    _str = _str + "<td align='right'><img id='LogInfo' border='0' src='/operation/jindun/images/common/log.gif' width='36' height='36'></td>";
    _str = _str + "</tr>";
    _str = _str + "</table>";
    _str = _str + "<cool:tip element='LogInfo' avoidmouse='false' duration=-1 delay=10 Style='border-color:#F57B3F;behavior: url(/operation/jindun/include/htc/tooltip_js.htc);display:none;'>";
    _str = _str + "<table width='220' border='0' cellpadding='5' cellspacing='0'>";
    _str = _str + "<tr>";
    _str = _str + "<td bgcolor='f7f7f7'>";
    _str = _str + "<table width='100%' border='0' cellspacing='0' cellpadding='1'>";
    _str = _str + "<tr> ";
    _str = _str + "<td width='44%'><font color='F57B3F'>记录状态：</font></td>";
    _str = _str + "<td width='56%'><font color='#006699'>" + jl_zt + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>登 记 人：</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_djr + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>登记时间：</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_djsj + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>最后修改人：</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_zhdjr + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>最后修改时间：</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_zhdjsj + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "</table>";
    _str = _str + "</td>";
    _str = _str + "</tr>";
    _str = _str + "</table>";
    _str = _str + "</cool:tip>";

    document.write(_str);
}

function refreshFrame(){
	var _window = window;
	var _framename = window.name;
	var _parent = window.parent;

	while (_window != top)
	{
		var _parentframe = eval("_parent.document.all." + _framename);
		if(_parentframe != null)
		{
			_parentframe.height = _window.document.all.outmostTable.offsetHeight;
		}
		else
		{
			break;
		}
		_window = _parent;
		_framename = _window.name;
		_parent = _window.parent;
	}
}

//alert错误提示
function doCritCode(field,crit,msg)
{
	if ( (-1!=crit) )
	{
		alert(msg)
		if (crit==1)
		{
			field.focus();  // focus does not work on certain netscape versions
			field.select();
		}
	}
}

//判断是否是数字(包括负数)
//参数
//1——sValue:要判断的字符串
function is_numericEx(oValue) {
	var Ret = true;
	var NumStr = "0123456789";
	var decUsed = false;
	var chr;
	var sValue;

    if ( oValue.indexOf("-") == -1 )
    {
		sValue = oValue;
    } else {
        sValue = oValue.substring(1 , oValue.length);
	}

	if (sValue.length < 1) {
		return false;
	}

    if (sValue == ".") {
        Ret = false;
    }

	for (var i = 0; i < sValue.length; i++) {
		chr = sValue.charAt(i);
		if (NumStr.indexOf(chr,0) == -1) {
			if ((!decUsed) && chr == ".") {
				decUsed = true;
			} else {
				Ret = false;
			}
		}
	}

	return(Ret);
}
function _compareTwoDateForString(_Date1, _Date2) {
     vDate1 = _Date1.split("-")
	 vDate2 = _Date2.split("-")
	 _Year1 = parseInt(vDate1[0]-0)
	 _Month1 = parseInt(vDate1[1]-0)
	 _Day1 = parseInt(vDate1[2]-0)

	 _Year2 = parseInt(vDate2[0]-0)
	 _Month2 = parseInt(vDate2[1]-0)
	 _Day2 = parseInt(vDate2[2]-0)

     if (_Year1 > _Year2) {
	    return false
	 }

	 if ((_Year1 == _Year2) && (_Month1 > _Month2)) {
	    return false
	 }

	 if ((_Year1 == _Year2) && (_Month1 == _Month2) && (_Day1 > _Day2)) {
	    return false
	 }

	 return true
}

//open Help window
function openHelp(_url) {
	window.open("/stmadc/stma/help/index.html", "_help","height=480,width=680,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes");
}
/*
==================================================================
LTrim(string) : Returns a copy of a string without leading spaces.
==================================================================
*/
function LTrim(str)
/*
   PURPOSE: Remove leading blanks from our string.
   IN: str - the string we want to LTrim
*/
{
   var whitespace = new String(" \t\n\r");

   var s = new String(str);

   if (whitespace.indexOf(s.charAt(0)) != -1) {
      // We have a string with leading blank(s)...

      var j=0, i = s.length;

      // Iterate from the far left of string until we
      // don't have any more whitespace...
      while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
         j++;

      // Get the substring from the first non-whitespace
      // character to the end of the string...
      s = s.substring(j, i);
   }
   return s;
}

/*
==================================================================
RTrim(string) : Returns a copy of a string without trailing spaces.
==================================================================
*/
function RTrim(str)
/*
   PURPOSE: Remove trailing blanks from our string.
   IN: str - the string we want to RTrim

*/
{
   // We don't want to trip JUST spaces, but also tabs,
   // line feeds, etc.  Add anything else you want to
   // "trim" here in Whitespace
   var whitespace = new String(" \t\n\r");

   var s = new String(str);

   if (whitespace.indexOf(s.charAt(s.length-1)) != -1) {
      // We have a string with trailing blank(s)...

      var i = s.length - 1;       // Get length of string

      // Iterate from the far right of string until we
      // don't have any more whitespace...
      while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
         i--;


      // Get the substring from the front of the string to
      // where the last non-whitespace character is...
      s = s.substring(0, i+1);
   }

   return s;
}

/*
=============================================================
Trim(string) : Returns a copy of a string without leading or trailing spaces
=============================================================
*/
function Trim(str)
/*
   PURPOSE: Remove trailing and leading blanks from our string.
   IN: str - the string we want to Trim

   RETVAL: A Trimmed string!
*/
{
   return RTrim(LTrim(str));
}

//判断日期 _Date1小于等于_Date2 返回true
function _compareTwoDateByValue(_Date1, _Date2) {
	 if ( _Date1 == "" || _Date2 == "" ) {
		 return true;
	 }
     vDate1 = _Date1.split("-");
	 vDate2 = _Date2.split("-");

	 var sDate1 = vDate1[0] + vDate1[1] + vDate1[2];
	 var sDate2 = vDate2[0] + vDate2[1] + vDate2[2];

     sDate1 = parseInt(sDate1-0);
	 sDate2 = parseInt(sDate2-0);

	 if ( sDate1>sDate2 ) {
        return false;
	 }

	 return true;
}

//判断时间 hh:mi:ss格式正确返回true
  function ratifyTime(str){

		  var Ret = false;
		  //小时分割符


          var str1=str.value.substring(3,2);
		  //分钟分割符
		  var str2=str.value.substring(6,5);
			var phour;
		  var pmin;
		  var psec;

          if(str1!=":"||str2!=":")
		  {
			alert("时间的格式应为：01:01:01");
		    str.focus();
			return(false);
		  };

          if(str.value.length != 8)
		  {
			alert("时间的格式应为：01:01:01");
		    str.focus();
			return(false);
		  };

		  if(!is_numeric(str.value.substring(2,0))){
			  alert("小时数据为数字");
			  return(false);
		  }
		  if(!is_numeric(str.value.substring(5,3))){
			  alert("分钟数据为数字");
			  return(false);
		  }
		  if(!is_numeric(str.value.substring(8,6))){
			  alert("秒钟数据为数字");
			  return(false);
		  }

		  phour=parseFloat(str.value.substring(2,0));//小时
		  pmin=parseFloat(str.value.substring(5,3));//分钟
		  psec=parseFloat(str.value.substring(8,6));//秒

		  if(phour>23||phour<0){
			alert("时间的小时位不能超过23，不能小于0");
			str.focus();
			return(false);
		  };
          if(pmin>59||pmin<0){
			alert("时间的分钟位不能超过59，不能小于0");
			str.focus();
			return(false);
		  };
		  if(psec>59||psec<0){
			alert("时间的秒位不能超过59，不能小于0");
			str.focus();
			return(false);
		  };


	      return(true);
		}

//判断输入的是否是合法的IP地址
function validIP(str){
    try{
        var ele = str.split(".");
        if(ele.length!=4){
            return false;
        }
        for(var i=0;i<ele.length;i++){
            var num = Trim(ele[i]);
            if(num.length==0){
                return false;
            }
            if(parseInt(num)<0 || parseInt(num)>255){
                return false;
            }
        }
        return true;
    }catch(exception){
        return false;
    }
}

/*
   判断是否符合编码规范
   编码必须以数字开头，内容只能是字母、数字、下划线
*/
function isCode(str) {
    var letterStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var allStr = "0123456789_"+letterStr;
	var chr;
	if ( str == "" ){
		return false;
	}
	chr = str.charAt(0);
	if ( letterStr.indexOf(chr,0) == -1 ) {
		return false;
	}
    for ( i=0; i<str.length; i++ ) {
		chr = str.charAt(i);
		if (  allStr.indexOf(chr,0) == -1 ) {
			return false;
		}
	}
	return true;
} 

/*
   判断是否符合编码规范
   编码必须以数字开头，内容只能是字母、数字、下划线
*/
function isCodeForField(str) {
    var letterStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    var allStr = "0123456789_"+letterStr;
	var chr;
	if ( str == "" ){
		return false;
	}
	chr = str.charAt(0);
	if ( letterStr.indexOf(chr,0) == -1 ) {
		return false;
	}
    for ( i=0; i<str.length; i++ ) {
		chr = str.charAt(i);
		if (  allStr.indexOf(chr,0) == -1 ) {
			return false;
		}
	}
	return true;
}