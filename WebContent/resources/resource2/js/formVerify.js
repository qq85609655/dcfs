var success = "SUCCESS"; //У��ͨ���ķ���ֵ
var title = "formTitle"; //У������������������
/****************************************************************************
** ��������У�麯����Ҫ�����е�У�麯��������formVerify�ĸ�ʽ��д
** ����ֵΪ�ַ�����"SUCCESS"��ʾУ��ͨ��������ΪУ�鲻ͨ������ʾ��Ϣ
** �������ɸ��ģ��������formConfig�ļ������õĺ�����һ��
** �����ĵ�һ������ΪҪУ������IHTMLElement���󣬺���Ϊ�Զ�������б�
** ע��: �����Զ�����������ַ������ʹ��ݡ�
*****************************************************************************/

function formVerify(field) {
	return "SUCCESS";
}


//����У��
function numberVerify(field) {
	if (field.value.isNumber()) {
		return success;
	}
	return "ֻ�������֣�";
}

//����У��
function intVerify(field) {
	if (field.value.isInt()) {
		return success;
	}
	return "ֻ��������������";
}

//С��λ��У��
function numberLengthVerify(field,length,precision) {
	if (field.value.isNumberLength(length,precision)) {
		return success;
	}
	return "����λ�����"+(length-precision)+"λ,С��λ�����" + precision + "λ";
}

//������У��
function floatVerify(field) {
	if (field.value.isFloat()) {
		return success;
	}
	return "ֻ�������͸�������";
}

//����У��
function plusVerify(field) {
	if (field.value.isPlus()) {
		return success;
	}
	return "ֻ��������������";
}

//������У��
function plusIntVerify(field) {
	if (field.value.isPlusInt()) {
		return success;
	}
	return "ֻ����������������";
}

//��������У��
function plusFloatVerify(field) {
	if (field.value.isPlusFloat()) {
		return success;
	}
	return "ֻ������������������";
}

//����У��
function minusVerify(field) {
	if (field.value.isMinus()) {
		return success;
	}
	return "ֻ�������͸�����";
}

//������У��
function minusIntVerify(field) {
	if (field.value.isMinusInt()) {
		return success;
	}
	return "ֻ�������͸�������";
}

//��������У��
function minusFloatVerify(field) {
	if (field.value.isMinusFloat()) {
		return success;
	}
	return "ֻ�������͸���������";
}

//�����ʼ�У��
function emailVerify(field) {
	if (field.value.isEmail()) {
		return success;
	}
	return "���ǺϷ��ĵ����ʼ���ַ��";
}

//�����ַ�У��
function wordcharVerify(field) {
	if (field.value.isLeastCharSet()) {
		return success;
	}
	return "ֻ�������ʹ�Сд��ĸ�����ֺ��»��ߣ�";
}

//��������У��
function zipVerify(field) {
	if (field.value.isZip()) {
		return success;
	}
	return "���������������׼��";
}

//�ֻ���У��
function mobileVerify(field) {
	if (field.value.isMobileTelephone()) {
		return success;
	}
	return "�������ֻ��Ÿ�ʽ��";
}

//�绰����У��
function telephoneVerify(field) {

	if (field.value.isTelephone()) {
		return success;
	}
	return "�����ϵ绰�����ʽ����׼��ʽΪ��(xxxx)xxxxxxxx����xxxx-xxxxxxxx�����ֻ���";
}

//�绰����У��(�����Ƕ�����룬�Կո�򶺺�","�ָ�)
function telephonesVerify(field) {
	var str = field.value;
	str = str.replace(","," ");
	str = str.replace("��"," ");	

	var telephones = str.split(" ");
	for(i=0; i<telephones.length; i++){
		if(telephones[i]==""){
			continue;
		}
		if (!telephones[i].isTelephone()) {
			return "�����ϵ绰�����ʽ����׼��ʽΪ��(xxxx)xxxxxxxx����xxxx-xxxxxxxx�����ֻ��ţ�������룬ʹ�ÿո�򶺺ŷָ�";
		}
	}
	
	return success;
}

//���ڸ�ʽУ��
function dateVerify(field) {
	if (field.value.isDate()) {
		return success;
	}
	return "���������ڸ�ʽ��׼�����磺2004-04-23";
}

//ʱ���ʽУ��
function timeVerify(field) {
	if (field.value.isTime()) {
		return success;
	}
	return "������ʱ���ʽ��׼�����磺09:30:50";
}

//����ʱ���ʽУ��
function dateTimeVerify(field) {
	if (field.value.isDateTime()) {
		return success;
	}
	return "����������ʱ���ʽ��׼�����磺2004-04-23 09:30:50";
}

//�����ַ�У��
function hasSpecialCharVerify(field) {
	if (field.value.hasSpecialChar()) {
		return success;
	}
	return "��������������ַ��������ַ���Ϊ�����ַ�����" + specialChars.source;
}
function hasSearchCharVerify(field) {
	if (field.value.hasSearchSpecialChar()) {
		return success;
	}
	return "����������������������ַ�����" + searchspecialChars.source;
}
function hasDBSpecialCharVerify(field) {
	if (field.value.hasDBSpecialChar()) {
		return success;
	}
	return "��������������ַ��������ַ���Ϊ�����ַ�����" + dbSpecialChars.source;
}
//У�������ڱ������ض�������֮��
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
	return "������\"" + compField[0].getAttribute(title) + "\"֮��";
}

//У�������ڱ����ڵ�ǰ����֮��
function afterTodayVerify(field, canEquals) {
	var field = field;
	var compValue=getSysDate();
	if (field.value.isAfterDate(compValue, canEquals)) {
		return success;
	}
	return "�����ڵ�ǰ����֮��";
}

//У�������ڱ������ض�������֮ǰ
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
	return "������\"" + compField[0].getAttribute(title) + "\"֮ǰ��";
}

//У�������ڱ����ڵ�ǰ����֮ǰ
function beforeTodayVerify(field, canEquals) {
	var field = field;
	var compValue=getSysDate();
	if (field.value.isBeforeDate(compValue, canEquals)) {
		return success;
	}
	return "�����ڵ�ǰ����֮ǰ��";
}

//У��������ʱ��������ض�������ʱ��֮��
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
	return "������\"" + compField[0].getAttribute(title) + "\"֮��";
}

//У��������ʱ��������ض�������ʱ��֮ǰ
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
	return "������\"" + compField[0].getAttribute(title) + "\"֮ǰ��";
}

//��ĳ����ֵ֮��У��
function inValueVerify(field, lower, high, includeLower, includeHigher) {
	var value = field.value;
	if ( lower.isNumber() && high.isNumber()) {
		if(value.isNumber()){
			value = parseFloat(value);
		} else {
			return "�����������֣�";
		}
		lower = parseFloat(lower);
		high = parseFloat(high);
	}
	if (lower >= high) {
		return "��������Сֵ����С�ڴ�ֵ��";
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
	return "������\"" + lower + "\"��\"" + high + "\"֮�䣡";
}

//��ĳ����ֵ֮��У��
function outValueVerify(field, lower, high, includeLower, includeHigher) {
	var value = field.value;
	if (value.isNumber() && lower.isNumber() && high.isNumber()) {
		value = parseFloat(value);
		lower = parseFloat(lower);
		high = parseFloat(high);
	}
	if (lower >= high) {
		return "��������Сֵ����С�ڴ�ֵ��";
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
	return "������\"" + lower + "\"��\"" + high + "\"֮�⣡";
}

//ĳ������֮��У��
function inFieldVerify(field, lowerField, highField, includeLower, includeHigher) {
	var lower = document.getElementsByName(lowerField)[0].value;
	var high = document.getElementsByName(highField)[0].value;
	if (lower == null || lower.trim() == "") {
		return "\"" + document.getElementsByName(lowerField)[0].getAttribute(title) + "\"��ΪСֵ����Ϊ�գ�";
	}
	if (high == null || high.trim() == "") {
		return "\"" + document.getElementsByName(highField)[0].getAttribute(title) + "\"��Ϊ��ֵ����Ϊ�գ�";
	}
	return inValueVerify(field, lower, high, includeLower, includeHigher);
}

//ĳ������֮��У��
function outFieldVerify(field, lowerField, highField, includeLower, includeHigher) {
	var lower = document.getElementsByName(lowerField)[0].value;
	var high = document.getElementsByName(highField)[0].value;
	if (lower == null || lower.trim() == "") {
		return "\"" + document.getElementsByName(lowerField)[0].getAttribute(title) + "\"��ΪСֵ����Ϊ�գ�";
	}
	if (high == null || high.trim() == "") {
		return "\"" + document.getElementsByName(highField)[0].getAttribute(title) + "\"��Ϊ��ֵ����Ϊ�գ�";
	}
	return outValueVerify(field, lower, high, includeLower, includeHigher);
}

//����ĳ��ֵУ��
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
	return "�������" + (canEquals == "true" ? "�����\"" : "\"") + compValue + "\"��";
}

//С��ĳ��ֵУ��
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
	return "����С��" + (canEquals == "true" ? "�����\"" : "\"") + compValue + "\"��";
}

//����ĳ����ֵУ��
function uperFieldVerify(field, compField, canEquals) {
	var compValue = document.getElementsByName(compField)[0].value;
	if (compValue == null) {
		compValue = "";
	}
	return uperValueVerify(field, compValue, canEquals);
}

//С��ĳ����ֵУ��
function lowerFieldVerify(field, compField, canEquals) {
	var compValue = document.getElementsByName(compField)[0].value;
	if (compValue == null) {
		compValue = "";
	}
	return lowerValueVerify(field, compValue, canEquals);
}

//�ж����֤�Ƿ���ȷ
//ͨ��ģ�õ���Ӧ��У����
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
         return "���֤��������,����!";
     }
     return success;
}
//У��18λ�����֤����
function validId18(_id){
    _id=_id+"";
    var _num=_id.substr(0,17);
    var _parityBit=_id.substr(17);
    var _power=0;
    for(var i=0;i< 17;i++){
        //У��ÿһλ�ĺϷ���
        if(_num.charAt(i)<'0'||_num.charAt(i)>'9'){
            return false;
            break;
        }else{
            //��Ȩ
            _power+=parseInt(_num.charAt(i))*parseInt(powers[i]);
        }
    }
    //ȡģ
    var mod=parseInt(_power)%11;
    if(parityBit[mod]==_parityBit){
        return true;
    }
    return false;
}
   //У��15λ�����֤����
function validId15(_id){
    _id=_id+"";
    for(var i=0;i<_id.length;i++){
        //У��ÿһλ�ĺϷ���
        if(_id.charAt(i)<'0'||_id.charAt(i)>'9'){
            return false;
            break;
        }
    }
    var year=_id.substr(6,2);
    var month=_id.substr(8,2);
    var day=_id.substr(10,2);
    //У�����λ
    if(year<'01'||year >'90') return false;
    //У���·�
    if(month<'01'||month >'12') return false;
    //У����
    if(day<'01'||day >'31') return false;
    return true;
}