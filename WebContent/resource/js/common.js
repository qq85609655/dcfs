/* 
 * 单位换算
 * 
 *lbTokg      磅TO千克 
 *lbTokg      千克TO磅
 *feetToinche 英尺TO英寸
 *feetTocm    英尺To厘米
 *incheTofeet 英寸TO英尺
 *incheTocm   英寸To厘米
 *cmToinche   厘米To英寸
 *cmTofeet    厘米To英尺
 *
 */
function fromConverToValues(fromObj,toObj,converType){
	    	var lbTokg = 0.4535924;       // 磅TO千克
	    	var lbTokg = 2.2046226;       // 千克TO磅
	    	var feetToinche = 12;         // 英尺TO英寸
	    	var feetTocm = 30.48;         // 英尺To厘米
	    	var incheTofeet = 0.0833333;  // 英寸TO英尺
	    	var incheTocm = 2.54;         // 英寸To厘米
	    	var cmToinche = 0.3937008;    // 厘米To英寸
	    	var cmTofeet = 0.0328084;     // 厘米To英尺
	    	var fromVal = $(fromObj).val();
	    	var toVal = 0.0;
	    	if(null != fromVal && "" != fromVal){
	    	    if(converType == 'lbTokg'){
	    	    	toVal = fromVal * lbTokg;
	    	    }
	    	    if(converType == 'lbTokg'){
	    	    	toVal = fromVal * lbTokg;
	    	    }
	    	    if(converType == 'feetToinche'){
	    	    	toVal = fromVal * feetToinche;
	    	    }
	    	    if(converType == 'feetTocm'){
	    	    	toVal = fromVal * feetTocm;
	    	    }
	    	    if(converType == 'incheTofeet'){
	    	    	toVal = fromVal * incheTofeet;
	    	    }
	    	    if(converType == 'incheTocm'){
	    	    	toVal = fromVal * incheTocm;
	    	    }
	    	    if(converType == 'cmToinche'){
	    	    	toVal = fromVal * cmToinche;
	    	    }
	    	    if(converType == 'cmTofeet'){
	    	    	toVal = fromVal * cmTofeet;
	    	    }
	    	    $("#"+toObj).val(toVal);
	    	}
}

/*
 * 
 * 保留一位小数点
 * 
 */
function toDecimal(x) {  
	
    var f = parseFloat(x); 
    
    if (isNaN(f)) {  
        return;  
    }  
    
    f = Math.round(x*10)/10;  
    
    return f;  
} 

/*
 * 体重指数 ： 体重/（身高*身高）
 */
function calBmi(_weightObj,_heightObj,_bmiObj){
	
	var _weightVal = $(_weightObj).val();
	var _heightVal =$(_heightObj).val();
	
	if(null != _weightVal && ""!=_weightVal && null != _heightVal && "" != _heightVal){
		
		$(_bmiObj).val(Math.round(_weightVal/((_heightVal*_heightVal)/10000)*10)/10);
	
	}
	
}
/*
 * 计算结婚几年
 */
function calMarrayYear(marrayTimeObj,marrayYearObj){
	var marrayTimeVal = $(marrayTimeObj).val();
	if(null != marrayTimeVal && ""!=marrayTimeVal){
		var d = new Date(); 
		var curYear = d.getFullYear(); 
		var marrayYear = marrayTimeVal.substring(0,marrayTimeVal.indexOf('-'));
		$(marrayYearObj).val(curYear-marrayYear);
	}
}

/*
 * 计算净资产
 */
function calNetworth(total_asset,total_debt,valObj){

	var assetVal = $(total_asset).val();
	
	var debtVal  = $(total_debt).val();
	
	if(""!=assetVal && ""!=debtVal){
		var val = total_asset - total_debt;
		if(val < 0){
			val = val * (-1);
		}
		$(valObj).val(val);
	}
	
}

/*
 * 根据出生日期获取周岁年龄
 */
function getAge(strBirthday)
{       
	var returnAge;
	if(strBirthday == ""){
		returnAge = ""
		return returnAge;
	}
	strBirthday = strBirthday.substr(0,10);
	var strBirthdayArr=strBirthday.split("-");
	var birthYear = strBirthdayArr[0];
	var birthMonth = strBirthdayArr[1];
	var birthDay = strBirthdayArr[2];

	d = new Date();
	var nowYear = d.getFullYear();
	var nowMonth = d.getMonth() + 1;
	var nowDay = d.getDate();
	
	if(nowYear == birthYear){
		returnAge = 0;//同年 则为0岁
	}else{
		var ageDiff = nowYear - birthYear ; //年之差
		if(ageDiff > 0){
			if(nowMonth == birthMonth){
				var dayDiff = nowDay - birthDay;//日之差
				if(dayDiff < 0){
					returnAge = ageDiff - 1;
				}else{
					returnAge = ageDiff ;
				}
			}else{
				var monthDiff = nowMonth - birthMonth;//月之差
				if(monthDiff < 0){
					returnAge = ageDiff - 1;
				}else{
					returnAge = ageDiff ;
				}
			}
		}else{
			returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		}
	}	
	return returnAge;//返回周岁年龄	
}


function converToValues(parm,converType){
	var bTokg = 0.4535924;       // 磅TO千克
	var kgTob = 2.2046226;       // 千克TO磅
	var feetToinche = 12;         // 英尺TO英寸
	var feetTocm = 30.48;         // 英尺To厘米
	var incheTofeet = 0.0833333;  // 英寸TO英尺
	var incheTocm = 2.54;         // 英寸To厘米
	var cmToinche = 0.3937008;    // 厘米To英寸
	var cmTofeet = 0.0328084;     // 厘米To英尺
	
	var ret;
	switch (converType){
		case 1://厘米转换成英尺、英寸
			ret = new Array();
			if(parm == ""){
				ret[0] = "";
				ret[1] = "";
			}else{
				ret[0] = parseInt(parm * cmTofeet);
				ret[1] = Math.round((parm * cmTofeet - ret[0]) * feetToinche);

			}
			break;
		case 2://英尺、英寸换成厘米
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm[0] * 	feetTocm + parm[1] * incheTocm);
			}
			break;
		case 3://千克转换成磅
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm * kgTob);
			}
			break;
		case 4://磅转换成千克
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm * bTokg);
			}
			break;
	}
			
	return ret;
}