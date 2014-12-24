/* 
 * ��λ����
 * 
 *lbTokg      ��TOǧ�� 
 *lbTokg      ǧ��TO��
 *feetToinche Ӣ��TOӢ��
 *feetTocm    Ӣ��To����
 *incheTofeet Ӣ��TOӢ��
 *incheTocm   Ӣ��To����
 *cmToinche   ����ToӢ��
 *cmTofeet    ����ToӢ��
 *
 */
function fromConverToValues(fromObj,toObj,converType){
	    	var lbTokg = 0.4535924;       // ��TOǧ��
	    	var lbTokg = 2.2046226;       // ǧ��TO��
	    	var feetToinche = 12;         // Ӣ��TOӢ��
	    	var feetTocm = 30.48;         // Ӣ��To����
	    	var incheTofeet = 0.0833333;  // Ӣ��TOӢ��
	    	var incheTocm = 2.54;         // Ӣ��To����
	    	var cmToinche = 0.3937008;    // ����ToӢ��
	    	var cmTofeet = 0.0328084;     // ����ToӢ��
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
 * ����һλС����
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
 * ����ָ�� �� ����/�����*��ߣ�
 */
function calBmi(_weightObj,_heightObj,_bmiObj){
	
	var _weightVal = $(_weightObj).val();
	var _heightVal =$(_heightObj).val();
	
	if(null != _weightVal && ""!=_weightVal && null != _heightVal && "" != _heightVal){
		
		$(_bmiObj).val(Math.round(_weightVal/((_heightVal*_heightVal)/10000)*10)/10);
	
	}
	
}
/*
 * �����鼸��
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
 * ���㾻�ʲ�
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
 * ���ݳ������ڻ�ȡ��������
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
		returnAge = 0;//ͬ�� ��Ϊ0��
	}else{
		var ageDiff = nowYear - birthYear ; //��֮��
		if(ageDiff > 0){
			if(nowMonth == birthMonth){
				var dayDiff = nowDay - birthDay;//��֮��
				if(dayDiff < 0){
					returnAge = ageDiff - 1;
				}else{
					returnAge = ageDiff ;
				}
			}else{
				var monthDiff = nowMonth - birthMonth;//��֮��
				if(monthDiff < 0){
					returnAge = ageDiff - 1;
				}else{
					returnAge = ageDiff ;
				}
			}
		}else{
			returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		}
	}	
	return returnAge;//������������	
}


function converToValues(parm,converType){
	var bTokg = 0.4535924;       // ��TOǧ��
	var kgTob = 2.2046226;       // ǧ��TO��
	var feetToinche = 12;         // Ӣ��TOӢ��
	var feetTocm = 30.48;         // Ӣ��To����
	var incheTofeet = 0.0833333;  // Ӣ��TOӢ��
	var incheTocm = 2.54;         // Ӣ��To����
	var cmToinche = 0.3937008;    // ����ToӢ��
	var cmTofeet = 0.0328084;     // ����ToӢ��
	
	var ret;
	switch (converType){
		case 1://����ת����Ӣ�ߡ�Ӣ��
			ret = new Array();
			if(parm == ""){
				ret[0] = "";
				ret[1] = "";
			}else{
				ret[0] = parseInt(parm * cmTofeet);
				ret[1] = Math.round((parm * cmTofeet - ret[0]) * feetToinche);

			}
			break;
		case 2://Ӣ�ߡ�Ӣ�绻������
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm[0] * 	feetTocm + parm[1] * incheTocm);
			}
			break;
		case 3://ǧ��ת���ɰ�
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm * kgTob);
			}
			break;
		case 4://��ת����ǧ��
			if(parm == ""){
				ret = "";
			}else{
				ret = Math.round(parm * bTokg);
			}
			break;
	}
			
	return ret;
}