var MSG_ERROR_PAGE_NUM = 'ҳ��Ӧ��1~10000000֮�䡣';
var MSG_OVER_PAGE_NUM = '�ѳ�����ҳ����Χ��';

var ExcelXJBgcolor = 19;//Excel:С���б�����ɫ
var ExcelHJBgcolor = 15;//40;//Excel:�ϼ��б�����ɫ
var ExcelZJBgcolor = 38;//Excel:�ܼ��б�����ɫ
var ExcelLMBgcolor = 15;//23;//Excel:��ͷ�б�����ɫ

/*����˵����@jindun  1/9/2003
*
*===================================
* �ж��Ƿ�������
* is_numeric(sValue)
* ����:1����sValue:Ҫ�жϵ��ַ���
*===================================
*
*===================================
* �ж�С����ʽ�Ƿ���ȷ
* is_exactNumeric(sValue,posDigit,decDigit)
* ������1����sValue:Ҫ�жϵ��ַ���
*      2����posDigit��С������λ
*	   3����decDigit��С��С��λ
* ���� is_exactNumeric(1289.234,3,2) ����false
*     is_exactNumeric(12.89234,3,2) ����true
*     ��������ߡ������ж�
*===================================
*
*===================================
* �ж��Ƿ�������
* is_positiveNumeric(sValue)
* ����:1����sValue:Ҫ�жϵ��ַ���
*===================================
*
*===================================
* �ж��Ƿ��ǷǸ�����
* is_int(sValue)
* ����:1����sValue:Ҫ�жϵ��ַ���
*===================================
*
*===================================
* �ж��Ƿ���������
* is_positiveInt(sValue)
* ����:1����sValue:Ҫ�жϵ��ַ���
*===================================
*
*===================================
* ���ָ�ʽ��
* formatNumber(_express, iSize)
* ����:
*     _express: double
*     iSize:    int
* ����
* _formatNumber(12.3456, 3) = 12.346
*===================================
*
*===================================
* ����ȥ��һ�ַ�������ָ�����ַ���
* Trim(str1,str2)
* ����
*    1.str1:Ҫ������ַ���
*    2.str2��ȥ�����ַ����������ò������򱾷���Ĭ�ϸò�����ֵΪ�ո�
*===================================
*
*===================================
* �õ���ǰ�ͻ�������
* _getCurrentDate(iType)
* ����
*   iType:���ص����ڸ�ʽ
*   0    yyyy-mm-dd
*   1    yyyy-mm-dd hh
*   2    yyyy-mm-dd hh:mi
*   3    yyyy-mm-dd hh:mi:ss
*===================================
*
*===================================
* �ж��Ƿ�������
* is_Date(sValue, iType)
* ����˵����sValue����Ҫ�жϵ��ַ���
*         iType������������
*            0����YYYY-MM-DD
*             1����YYYY-MM-DD HH
*             2����YYYY-MM-DD HH:MI
*             3����YYYY-MM-DD HH:MI:SS
* ����ֵ��������ͷ�����false
*       ����Ϸ�������iTypeָ�������ڸ�ʽ��������
*===================================
*
*===================================
* �ж��Ƿ������֤��
* isIDCard(sInput) {
* ����:1����sInput������ֵ
*===================================
*
*===================================
* ��15λ���֤��ת��Ϊ18λ
* changeIDCard(v)
* ������ v:Ҫת�����ַ���
*===================================
*
*===================================
* ���ж�һ���ַ��Ƿ���ASCIIֵ
* isASCII( cValue )
* ����:1����cValue������ֵ
*===================================
*
*===================================
* ��һ���ַ����еĺ��ּ�Ϊ2���ַ������������ݿ�����ȷ����
* calcRealLength(sString)
* ����:1�������������ַ���
*===================================
*
*===================================
//���ɼ�¼��־
//��������Ϊ������ȡ���¼״̬���Ǽ��ˡ��Ǽ�ʱ�䡢����޸��ˡ�����޸�ʱ��
WriteLog(_width, jl_zt, jl_djr, jl_djsj, jl_zhdjr, jl_zhdjsj)
*===================================
*
*===================================
* �ж�ʱ�� hh:mi:ss��ʽ��ȷ����true
* ratifyTime(str)
* ����:1����ʱ����ַ���
*===================================
*
*/



//�ж��Ƿ�������
//����
//1����sValue:Ҫ�жϵ��ַ���
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

//* �ж�С����ʽ�Ƿ���ȷ
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

// �ж��Ƿ�������
//����
//1����sValue:Ҫ�жϵ��ַ���
function is_positiveNumeric(sValue) {
	if (!is_numeric(sValue)) {
        return false;
	}
	if (sValue.charAt(0) == "-" && sValue != "") {
        return false;
    }

	return true;
}

// �ж��Ƿ��ǷǸ�����
//����
//1����sValue:Ҫ�жϵ��ַ���
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

// �ж��Ƿ���������
//����
//1����sValue:Ҫ�жϵ��ַ���
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


//Trim����ȥ��һ�ַ�������ָ�����ַ���
//����
//   1.str1:Ҫ������ַ���
//   2.str2��ȥ�����ַ����������ò������򱾷���Ĭ�ϸò�����ֵΪ�ո�
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

//�õ���ǰ�ͻ�������
//����
//   iType:���ص����ڸ�ʽ
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

//����˵��:�ж��Ƿ������ڣ�
//����˵����sValue����Ҫ�жϵ��ַ���
//         iType������������
//             0����YYYY-MM-DD
//             1����YYYY-MM-DD HH
//             2����YYYY-MM-DD HH:MI
//             3����YYYY-MM-DD HH:MI:SS
//             4����YYYY��MM��DD��
//����ֵ��
//       ���Ϊ�շ��ؿ�
//       ������ͷ�����false
//       ����Ϸ�������iTypeָ�������ڸ�ʽ��������
function is_Date(sValue, iType) {
	var sDateRange1 = "0123456789-/. :"//�����ַ���Χ
	var sDateRange2 = "0123456789"//�����ַ���Χ

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

	if (tempValue.length > 14) {//�ַ������Ȳ��ܳ���14
		return false;
	}

	var IFExistDigit = false;
	for (i = 0; i < sValue.length; i++) {
		var _tempStr = sValue.charAt(i);
		if (sDateRange1.indexOf(_tempStr, 0) == -1) {//�����Ƿ��ַ�
			return false;
			break;
		}

		if (sDateRange2.indexOf(_tempStr, 0) > -1) {
			IFExistDigit = true;
		}
	}

	if (IFExistDigit == false) {//����������
		return false;
	}

	sValue = sValue.replace(/\//g,"-");
	sValue = sValue.replace(/\./g,"-");

	if (sValue.split("-").length > 3) {//��-���ַ��ĸ�������Ϊ����3
		return false;
	}
	if (sValue.split(":").length > 3) {//��:���ַ��ĸ�������Ϊ����3
		return false;
	}
	if (sValue.split(" ").length > 2) {//�� ���ַ��ĸ�������Ϊ����2
		return false;
	}
	if (sValue.split("-").length == 1 && sValue.split(":").length > 1) {//ֻ�С������ޡ�-�������
		return false;
	}

	var aValue = sValue.split("-");
	var iYear = null;
	var iMonth = null;
	var iDay = null;
	var iHours = null;
	var iMinutes = null;
	var iSeconds = null;

	if (!is_int(aValue[0])) {//��ݲ��ǷǸ�����
		return false;
	}
	iYear = aValue[0] - 1 + 1;
	if (iYear < 1900 || iYear > 2050) {//���Ӧ��1950����2050֮��
		return false;
	}

	if (aValue.length > 1) {//�·�
		if (!is_int(aValue[1])) {//�·ݲ��ǷǸ�����
			return false;
		}
		iMonth = aValue[1] - 1 + 1;
		if (iMonth < 0 || iMonth > 12) {//�·���1-12֮��
			return false;
		}
	}

	if (aValue.length == 3) {//����
		var aValue1 = aValue[2].split(" ");
		if (!is_int(aValue1[0])) {//���ڲ��ǷǸ�����
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
			if (!is_int(aValue2[0])) {//Сʱ���ǷǸ�����
				return false;
			}
			iHours = aValue2[0] - 1 + 1;
			if ((iMonth == 0 || iDay == 0) && iHours != 0) {
				return false;
			}

			if (iHours < 0 || iHours > 23) {//СʱӦ��0��23֮��
				return false;
			}

			if (aValue2.length > 1) {
				if (!is_int(aValue2[1])) {//�ֲ��ǷǸ�����
					return false;
				}

				iMinutes = aValue2[1] - 1 + 1;
				if ((iMonth == 0 || iDay == 0) && iMinutes != 0) {
					return false;
				}
				if (iMinutes < 0 || iMinutes > 59) {//��Ӧ��0��59֮��
					return false;
				}
			}

			if (aValue2.length == 3) {
				if (!is_int(aValue2[2])) {//�벻�ǷǸ�����
					return false;
				}

				iSeconds = aValue2[2] - 1 + 1;
				if ((iMonth == 0 || iDay == 0) && iSeconds != 0) {
					return false;
				}
				if (iSeconds < 0 || iSeconds > 59) {//��Ӧ��0��59֮��
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
			sReturn = sReturn.substring(0, 4) + "��" + sReturn.substring(4, 6) + "��" + sReturn.substring(6, 8) + "��";
			break;
	}

	return sReturn;
}

//�ж��Ƿ������֤��
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

//��15λ���֤��ת��Ϊ18λ
//����
//       v:Ҫת�����ַ���
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
//���ж�һ���ַ��Ƿ���ASCIIֵ
//cValue������ֵ
function isASCII(cValue)
{
	var sFormat = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	var iLocation = sFormat.indexOf( cValue );
	return( iLocation != -1 );
}

//��һ���ַ����еĺ��ּ�Ϊ2���ַ������������ݿ�����ȷ����
//sString�����������ַ���
function calcRealLength(sString)
{
	var iLength = 0;	// ��ʵ���ȼ�����
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
			zpobject.innerHTML = " �� Ƭ ";
		}
		if(buttonobject != null)
		{
			buttonobject.outerHTML = "";
		}
		return true;
	}
	else
	{
		alert("��Ƭɾ��ʧ�ܣ�");
		return false;
	}

}

//���ɼ�¼��־
//��������Ϊ������ȡ���¼״̬���Ǽ��ˡ��Ǽ�ʱ�䡢����޸��ˡ�����޸�ʱ��
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
    _str = _str + "<td width='44%'><font color='F57B3F'>��¼״̬��</font></td>";
    _str = _str + "<td width='56%'><font color='#006699'>" + jl_zt + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>�� �� �ˣ�</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_djr + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>�Ǽ�ʱ�䣺</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_djsj + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>����޸��ˣ�</font></td>";
    _str = _str + "<td><font color='#006699'>" + jl_zhdjr + "</font></td>";
    _str = _str + "</tr>";
    _str = _str + "<tr> ";
    _str = _str + "<td><font color='F57B3F'>����޸�ʱ�䣺</font></td>";
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

//alert������ʾ
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

//�ж��Ƿ�������(��������)
//����
//1����sValue:Ҫ�жϵ��ַ���
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

//�ж����� _Date1С�ڵ���_Date2 ����true
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

//�ж�ʱ�� hh:mi:ss��ʽ��ȷ����true
  function ratifyTime(str){

		  var Ret = false;
		  //Сʱ�ָ��


          var str1=str.value.substring(3,2);
		  //���ӷָ��
		  var str2=str.value.substring(6,5);
			var phour;
		  var pmin;
		  var psec;

          if(str1!=":"||str2!=":")
		  {
			alert("ʱ��ĸ�ʽӦΪ��01:01:01");
		    str.focus();
			return(false);
		  };

          if(str.value.length != 8)
		  {
			alert("ʱ��ĸ�ʽӦΪ��01:01:01");
		    str.focus();
			return(false);
		  };

		  if(!is_numeric(str.value.substring(2,0))){
			  alert("Сʱ����Ϊ����");
			  return(false);
		  }
		  if(!is_numeric(str.value.substring(5,3))){
			  alert("��������Ϊ����");
			  return(false);
		  }
		  if(!is_numeric(str.value.substring(8,6))){
			  alert("��������Ϊ����");
			  return(false);
		  }

		  phour=parseFloat(str.value.substring(2,0));//Сʱ
		  pmin=parseFloat(str.value.substring(5,3));//����
		  psec=parseFloat(str.value.substring(8,6));//��

		  if(phour>23||phour<0){
			alert("ʱ���Сʱλ���ܳ���23������С��0");
			str.focus();
			return(false);
		  };
          if(pmin>59||pmin<0){
			alert("ʱ��ķ���λ���ܳ���59������С��0");
			str.focus();
			return(false);
		  };
		  if(psec>59||psec<0){
			alert("ʱ�����λ���ܳ���59������С��0");
			str.focus();
			return(false);
		  };


	      return(true);
		}

//�ж�������Ƿ��ǺϷ���IP��ַ
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
   �ж��Ƿ���ϱ���淶
   ������������ֿ�ͷ������ֻ������ĸ�����֡��»���
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
   �ж��Ƿ���ϱ���淶
   ������������ֿ�ͷ������ֻ������ĸ�����֡��»���
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