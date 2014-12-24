/**
 * �����ַ�
 */
var specialChars = /[!@#\$%\^&\*\(\)\{\}\[\]<>_\+\|~`-]|[=\/\\\?;:,����#��%������*��������������������'"]/g;
/**
 * ��ѯ�������ַ�
 */
var searchspecialChars = /[%']/g;
/**
 * ���ݿ���������ַ�
 */
var dbSpecialChars = /[!@\^&\|~`'"%\\\?;]/g;
/*******************************************************************************
 * �����Ƕ��ַ�������String������չ�������κ�String���󶼿� ʹ����Щ���������磺 var str = " dslf dsf sfd ";
 * alert(str.trim()); //��ʾ�������ַ���"dslf dsf sfd" alert(str.deleteSpace());
 * //��ʾ�������ַ���"dslfdsfsfd"
 ******************************************************************************/
 
/*
 * function:���ַ�����߲�ָ�����ַ��� parameter�� countLen:����ַ����ĳ��� addStr:Ҫ���ӵ��ַ���
 * return:�������ַ���
 */
/**
 * ���ַ�����߲�ָ�����ַ���<br>
 * ���磺10.02 ִ�� lpad(8,'0')���õ���ֵΪ 00010.02
 * 
 * @param countLen
 *            ����ַ����ĳ���
 * @param addStr
 *            Ҫ���ӵ��ַ���
 * @return ��߲������ַ���
 */
String.prototype.lpad = function(countLen,addStr)
{
        // ���countLen�������֣���������
        if(isNaN(countLen))return this;

        // ��ʼ�ַ������ȴ���ָ���ĳ��ȣ����账��
        if(initStr.length >= countLen)return this;

        var initStr = this;        // ��ʼ�ַ���
        var tempStr = new String();        // ��ʱ�ַ���

        for(;;)
        {
                tempStr += addStr;
                if(tempStr.length >= countLen - initStr.length)
                {
                        tempStr = tempStr.substring(0,countLen - initStr.length);
                        break;
                }
        }
        return tempStr + initStr;
};

/*
 * function: parameter�� countLen:����ַ����ĳ��� addStr:Ҫ���ӵ��ַ��� return:�������ַ���
 */
/**
 * ���ַ����ұ߲�ָ�����ַ���<br>
 * ���磺10.02 ִ�� lpad(6,'0')���õ���ֵΪ 10.020
 * 
 * @param countLen
 *            ����ַ����ĳ���
 * @param addStr
 *            Ҫ���ӵ��ַ���
 * @return �ұ߲������ַ���
 */
String.prototype.rpad = function(countLen,addStr)
{
        // ���countLen�������֣���������
        if(isNaN(countLen))return this;

        // ��ʼ�ַ������ȴ���ָ���ĳ��ȣ��򲻴�����
        if(initStr.length >= countLen)return this;

        var initStr = this;        // ��ʼ�ַ���

        for(;;)
        {
                initStr += addStr;
                if(initStr.length >= countLen)
                {
                        initStr = initStr.substring(0,countLen);
                        break;
                }
        }
        return initStr;
};

/**
 * ȥ���ַ��������еĿո�
 * @return �������ַ���
 */
String.prototype.atrim = function()
{
    // ��������ʽ���ұ߿ո��ÿ��ַ��������
    return this.replace(/(\s+)|(��+)/g, "");
};

/**
 *ȥ���ַ������ߵĿո�
 *@return �������ַ���
 */
String.prototype.trim = function()
{
    // ��������ʽ��ǰ��ո��ÿ��ַ��������
    return this.replace(/(^\s+)|(\s+$)|(^��+)|(��+$)/g, "");
};
/**
 * ȥ���ַ�����ߵĿո�
 * @return �������ַ���
 */
String.prototype.ltrim = function()
{
        return this.replace(/(^\s+)|(^��+)/g,"");
};


/**
 * ȥ���ַ����ұߵĿո�
 * @return �������ַ���
 */
String.prototype.rtrim = function()
{
        return this.replace(/(\s+$)|(��+$)/g,"");
};

/*
 * function: return:�ֽ��� example:
 */
/**
 * ����ַ������ֽ���<br>
 * ���磺"test����".getByteֵΪ8
 * @return �ֽ���
 */
String.prototype.getByte = function()
{
        var intCount = 0;
        for(var i = 0;i < this.length;i ++)
        {
            // Ascii�����255��˫�ֽڵ��ַ�
            var ascii = this.charCodeAt(i).toString(16);
            var byteNum = ascii.length / 2.0;
            intCount += (byteNum + (ascii.length % 2) / 2);
        }
        return intCount;
};
/**
 * ָ���ַ�������ַ�ȫ��ת��Ϊ��Ӧ��ȫ���ַ�
 * @param dbcStr Ҫת���İ���ַ�����
 * @return ת������ַ���
 */
String.prototype.dbcToSbc = function(dbcStr)
{
        var resultStr = this;

        for(var i = 0;i < this.length;i ++)
        {
                switch(dbcStr.charAt(i))
                {
                        case ",":
                                resultStr = resultStr.replace(/\,/g,"��"); 
                                break;
                        case "!":
                                resultStr = resultStr.replace(/\!/g,"��"); 
                                break;
                        case "#":
                                resultStr = resultStr.replace(/\#/g,"��"); 
                                break;
                        case "|":
                                resultStr = resultStr.replace(/\|/g,"|"); 
                                break;
                        case ".":
                                resultStr = resultStr.replace(/\./g,"��"); 
                                break;
                        case "?":
                                resultStr = resultStr.replace(/\?/g,"��"); 
                                break;
                        case ";":
                                resultStr = resultStr.replace(/\;/g,"��"); 
                                break;
                }
        }
        return resultStr;
};

/**
 * ��ȡ���ֽ���ָ�����ִ�
 * @param index1 ��ʼ�ֽ�
 * @param index2 �����ֽ�
 * @return ���ؽ�ȡ����ַ���<br>ע��˫�ֽ��ַ����ܻ��������
 */
String.prototype.bytesubstr = function(index1,index2)
{
        var resultStr = "";
        var byteCount = 0;
        for(var i = index1;i < index2;i ++)
        {
                if(i > this.length)break;
                if(this.charCodeAt(i) > 255)byteCount += 2;
                else byteCount += 1;
                if(byteCount > (index2 - index1))break;
                resultStr += this.charAt(i);
        }
        return resultStr;
};

/**
 *  �ж��ַ����Ƿ��������ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isNumber = function() {
	return (this.isInt() || this.isFloat());
};

/**
 * �ж��ַ����Ƿ��Ǹ������ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isFloat = function() {
	return /^(?:-?|\+?)\d*\.\d+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ�������ָ�����ȡ�С��λ��������ֵ������С��λ����
 * @param length ���ֵĳ��ȣ�����С���͵�
 * @param precision ���ȣ�С����λ��
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isNumberLength= function(length,precision){
	intPart = length - precision;
	re = new RegExp("^(?:-?|\\+?)\\d{1," + intPart + "}(\\.\\d{0," + precision + "})?$","g");
	return re.test(this);
};
/**
 * �ж��ַ����Ƿ��������ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isInt = function() {
	return /^(?:-?|\+?)\d+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ��������ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isPlus = function() {
	return this.isPlusInt() || this.isPlusFloat();
};
/**
 * �ж��ַ����Ƿ������������ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isPlusFloat = function() {
	return /^\+?\d*\.\d+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ����������ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isPlusInt = function() {
	return /^\+?\d+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ��Ǹ����ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isMinus = function() {
	return this.isMinusInt() || this.isMinusFloat();
};
/**
 * �ж��ַ����Ƿ��Ǹ��������ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isMinusFloat = function() {
	return /^-\d*\.\d+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ��Ǹ������ַ���
 * @return ���������򷵻�true�����򷵻�false
 */
String.prototype.isMinusInt = function() {
	return /^-\d+$/g.test(this);
};

/**
 * �ж��ַ����Ƿ�ֻ���������ַ�
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isLeastCharSet = function() {
	return !(/[^A-Za-z0-9_]/g.test(this));
};
/**
 * �ж��ַ����Ƿ���Email�ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isEmail = function() {
	return /^\w+@.+\.\w+$/g.test(this);
};
/**
 * �ж��ַ����Ƿ������������ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isZip = function() {
	return /^\d{6}$/g.test(this);
};
/**
 *�ж��ַ����Ƿ��ǹ̶��绰�����ַ��� 
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isFixedTelephone = function() {
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,18}(-\d+)?$/g.test(this);
};
/**
 * �ж��ַ����Ƿ����ֻ��绰�����ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isMobileTelephone = function() {
	return this.isBaseMobileTelephone();
};
/**
 * �ж��ַ����Ƿ���13��15������ֻ��绰�����ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isBaseMobileTelephone = function() {
	return /^((13)|(15))\d{9}$/g.test(this);
};
/**
 * �ж��ַ����Ƿ���3G-18������ֻ��绰�����ַ���
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.is3GMobileTelephone = function() {
	return /^(18)\d{9}$/g.test(this);
};
/**
 * �ж��ַ����Ƿ��ǵ绰�����ַ����������������ֻ�
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isTelephone = function() {
	return this.isMobileTelephone() || this.isFixedTelephone();
};

/**
 * �ж��ַ����Ƿ��������ַ���(YYYY-MM-DD)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isDate = function() {
	return /^\d{1,4}-(?:(?:(?:0?[1,3,5,7,8]|1[0,2])-(?:0?[1-9]|(?:1|2)[0-9]|3[0-1]))|(?:(?:0?[4,6,9]|11)-(?:0?[1-9]|(?:1|2)[0-9]|30))|(?:(?:0?2)-(?:0?[1-9]|(?:1|2)[0-9])))$/g.test(this);
};
/**
 * �ж��ַ����Ƿ���ʱ���ַ��� (HH-mm-ss)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isTime = function() {
	return /^(?:(?:0?|1)[0-9]|2[0-3]):(?:(?:0?|[1-5])[0-9]):(?:(?:0?|[1-5])[0-9])(?:\.(?:\d{1,3}))?$/g.test(this);
};
/**
 * �ж��ַ����Ƿ�������ʱ���ַ���(YYYY-MM-DD HH-mm-ss)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isDateTime = function() {
	return /^\d{1,4}-(?:(?:(?:0?[1,3,5,7,8]|1[0,2])-(?:0?[1-9]|(?:1|2)[0-9]|3[0-1]))|(?:(?:0?[4,6,9]|11)-(?:0?[1-9]|(?:1|2)[0-9]|30))|(?:(?:0?2)-(?:0?[1-9]|(?:1|2)[0-9]))) +(?:(?:0?|1)[0-9]|2[0-3]):(?:(?:0?|[1-5])[0-9]):(?:(?:0?|[1-5])[0-9])(?:\.(?:\d{1,3}))?$/g.test(this);
};
/**
 * �Ƚ������ַ���
 * @param target Ҫ�Ƚϵ����ڴ�
 * @return ������򷵻�0,<br>
 * ���򷵻ص�ǰ�����ַ�����Ŀ���ַ���֮�����ĺ�������<br>
 * ������һ���ַ������������ڻ�����ʱ���ʽ���򷵻�null��
 */
String.prototype.compareDate = function(target) {
	var thisDate = this.toDate();
	var targetDate = target.toDate();
	if (thisDate == null || targetDate == null) {
		return null;
	}
	else {
		return thisDate.getTime() - targetDate.getTime();
	}
};
/**
 * �ж������ַ���ָ����ʱ���Ƿ��ǵ�ǰ����
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isToday = function() {
	return this.trim().split(' ')[0].compareDate(getSysDate()) == 0;
};
/**
 * �ж������ַ���ָ����ʱ���Ƿ����ڻ�׼����֮ǰ
 * @param baseDate �ȽϵĻ�׼����,����ڻ�׼����ǰ,��Ϊtrue
 * @param canEquals �Ƿ������׼����
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isBeforeDate = function(baseDate,canEquals) {
	if (baseDate == null || !baseDate.isDate()) {
		return false;
	}
	if (canEquals=="true"){
		return this.trim().split(' ')[0].compareDate(baseDate.trim().split(' ')[0]) <= 0;
	}else{
		return this.trim().split(' ')[0].compareDate(baseDate.trim().split(' ')[0]) < 0;
	}
};
/**
 * �ж������ַ���ָ����ʱ���Ƿ��ǻ�׼����֮��
 * @param baseDate �ȽϵĻ�׼����,����ڻ�׼���ں�,��Ϊtrue
 * @param canEquals �Ƿ������׼����
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isAfterDate = function(baseDate,canEquals) {
	if (baseDate == null || !baseDate.isDate()) {
		return false;
	}
	if (canEquals=="true"){
		return this.trim().split(' ')[0].compareDate(baseDate.trim().split(' ')[0]) >= 0;
	}else{
		return this.trim().split(' ')[0].compareDate(baseDate.trim().split(' ')[0]) > 0;
	}

};

/**
 * �ж�����ʱ���ַ���ָ���������Ƿ��ǻ�׼����ʱ��֮ǰ
 * @param baseDateTime ��׼����ʱ��
 * @param canEquals �Ƿ������׼����ʱ��
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isBeforeDateTime = function(baseDateTime,canEquals) {
	if (baseDateTime == null || !baseDateTime.isDateTime()) {
		return false;
	}
	if (canEquals=="true"){
		return this.trim().compareDate(baseDateTime.trim()) <= 0;
	}else{
		return this.trim().compareDate(baseDateTime.trim()) < 0;
	}
};
/**
 * �ж�����ʱ���ַ���ָ���������Ƿ��ǻ�׼����ʱ��֮��
 * @param baseDateTime ��׼����ʱ��
 * @param canEquals �Ƿ������׼����ʱ��
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.isAfterDateTime = function(baseDateTime,canEquals) {
	if (baseDateTime == null || !baseDateTime.isDateTime()) {
		return false;
	}
	if (canEquals=="true"){
		return this.trim().compareDate(baseDateTime.trim()) >= 0;
	}else{
		return this.trim().compareDate(baseDateTime.trim()) > 0;
	}
};
/**
 * �ж��ַ������Ƿ��������ַ�(�����ַ�����extendString.js�����Ϸ�ָ��)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.hasSpecialChar = function() {
	return !specialChars.test(this);
};
/**
 * �ж��ַ������Ƿ��в�ѯ�����ַ�(��ѯ�����ַ�����extendString.js�����Ϸ�ָ��)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.hasSearchSpecialChar = function() {
	return !searchspecialChars.test(this);
};
/**
 * �ж��ַ������Ƿ������ݿ���������ַ�(���ݿ���������ַ�����extendString.js�����Ϸ�ָ��)
 * @return �����򷵻�true�����򷵻�false
 */
String.prototype.hasDBSpecialChar = function() {
	return !dbSpecialChars.test(this);
};
/**
 * ɾ���ַ����еĿո�
 * @return ɾ������ַ���
 */
String.prototype.deleteSpace = function() {
	return this.replace(/( +)|(��+)/g, '');
};
/**
 * ɾ���ַ�����ָ�����ַ���
 * @param str ָ�����ַ���
 * @return ɾ������ַ���
 */
String.prototype.remove = function(str) {
	if (str == null || str == '') {
		return this;
	}
	return this.replace(str.toRegExp('g'), '');
};
/**
 * ���ַ����а�����find�ַ����滻��target�ַ����������滻��Ľ���ַ���
 * @param find �������ַ���
 * @param target Ҫ�滻���ַ���
 * @return �滻����ַ���
 */
String.prototype.replaceByString = function(find, target) {
	return this.replace(find.toRegExp('g'), target);
};
/**
 * ���ַ���ת������Ӧ��������ʽ,ʹ�÷���:
 * g ����ȫ��ƥ��
 * m ������Խ��ж���ƥ��
 * i �������ִ�Сдƥ��
 * ^ ƥ�������ַ����Ŀ�ʼλ��
 * $ ƥ�������ַ����Ľ���λ��
 * * ƥ��ǰ����ӱ��ʽ��λ���. �ȼ���{0,}
 * + ƥ��ǰ����ӱ��ʽһ�λ���. �ȼ���{1,}
 * ? ƥ��ǰ����ӱ��ʽ��λ�һ��. �ȼ���[0,1} , �����ַ������κ�һ���������Ʒ�(*, +, ?, {n}, {n,}, {n,m}) ����ʱ��ƥ��ģʽ�Ƿ�̰���ġ���̰��ģʽ�������ٵ�ƥ�����������ַ�������Ĭ�ϵ�̰��ģʽ�򾡿��ܶ��ƥ�����������ַ��������磬�����ַ��� "oooo"��'o+?' ��ƥ�䵥�� "o"���� 'o+' ��ƥ������ 'o'��

 * \d ƥ��һ�������ַ�. �ȼ��� [0-9]
 * \D ƥ��һ�������ַ�. �ȼ��� [^0-9]
 * \w  ,�ȼ��� "[A-Za-z0-9_]"
 * \W ƥ���κηǵ����ַ�,�ȼ��� "[^A-Za-z0-9]"
 * \s ƥ���κοհ��ַ�, �����ո� �Ʊ�� ��ҳ�� �ȵ�. �ȼ���[\f\n\r\t\v]
 * \S ƥ���κηǿհ��ַ�. �ȼ��� [^\f\r\n\t\v]
 * \b ƥ��һ�����ʱ߽磬Ҳ����ָ���ʺͿո���λ�á�
 * \B ƥ��ǵ��ʱ߽硣
 * 
 * (pattern)ƥ��pattern ����ȡ��һƥ�䡣����ȡ��ƥ����ԴӲ����� Matches ���ϵõ�����VBScript ��ʹ�� SubMatches ���ϣ���JScript ����ʹ�� $0��$9 ���ԡ�
 * 
 * (?:pattern)ƥ�� pattern ������ȡƥ������Ҳ����˵����һ���ǻ�ȡƥ�䣬�����д洢���Ժ�ʹ�á�����ʹ�� "��" �ַ� (|) �����һ��ģʽ�ĸ��������Ǻ����á����磬 'industr(?:y|ies) ����һ���� 'industry|industries' �����Եı��ʽ��
 * 
 * (?=pattern)����Ԥ�飬���κ�ƥ�� pattern ���ַ�����ʼ��ƥ������ַ���������һ���ǻ�ȡƥ�䣬Ҳ����˵����ƥ�䲻��Ҫ��ȡ���Ժ�ʹ�á����磬 'Windows (?=95|98|NT|2000)' ��ƥ�� "Windows 2000" �е� "Windows" ��������ƥ�� "Windows 3.1" �е� "Windows"��Ԥ�鲻�����ַ���Ҳ����˵����һ��ƥ�䷢���������һ��ƥ��֮��������ʼ��һ��ƥ��������������ǴӰ���Ԥ����ַ�֮��ʼ��
 * 
 * (?!pattern)����Ԥ�飬���κβ�ƥ��Negative lookahead matches the search string at any point where a string not matching pattern ���ַ�����ʼ��ƥ������ַ���������һ���ǻ�ȡƥ�䣬Ҳ����˵����ƥ�䲻��Ҫ��ȡ���Ժ�ʹ�á�����'Windows (?!95|98|NT|2000)' ��ƥ�� "Windows 3.1" �е� "Windows"��������ƥ�� "Windows 2000" �е� "Windows"��Ԥ�鲻�����ַ���Ҳ����˵����һ��ƥ�䷢���������һ��ƥ��֮��������ʼ��һ��ƥ��������������ǴӰ���Ԥ����ַ�֮��ʼ
 * 
 * ƥ��2-4������
 * 
  * �������
 * /^[\u4e00-\u9fa5]{2,4}$/g;
 * 
 * 
 * ƥ��6��18��(��ĸ,����,�»���)�ַ�
 * 
  * �������
 * /^\w{6,18}$/;
 * 
 * 
 * �������
 * /^[A-Za-z0-9_]$/;
 * 
 * 
 * ƥ��HTML��ǩ
 * 
 *  �������
 * /<[^>]*>|<\/[^>]*>/gm;
 * 
 * 
 *  �������
 * /<\/?[^>]+>/gm;
 * 
 * 
 * ƥ���������˵Ŀո�
 * 
 *  �������
/ * (^\s*)|(\s*$)/g;
 * 
 * 
 * ���ȼ�˳��(�Ӹߵ���)
 * \ ת���
 * (),(?:),(?=),[] Բ���źͷ�����
 * * , + , ? , {n} , {n,} , {n,m} �޶���
 * ^ , [vapour:content]nbsp; λ�ú�˳��
 * | "��"����
 * 
 * ƥ�������������Կո�ֿ�����ͬ����
 * 
 *  �������
 * /\b([a-z]+) \1\b/gim ;
 * 
 * �����ʾ���У��ӱ��ʽ����Բ����֮���ÿһ�
 * ������ı��ʽ����һ��������ĸ�ַ�������'[a-z]+' ��ָ���ġ�
 * ��������ʽ�ĵڶ������Ƕ�ǰ�����������ƥ������ã�Ҳ�����ɸ��ӱ��ʽ��ƥ��ĵڶ��γ��ֵĵ��ʡ�
 * '\1'����ָ����һ����ƥ�䡣���ʱ߽�Ԫ�ַ�ȷ��ֻ��ⵥ���ĵ��ʡ�
 * ����������������� "is issued" �� "this is" �����Ķ��ﶼ�ᱻ�ñ��ʽ����ȷ��ʶ��
 *  �������
 * var ss = "Is is the cost of of gasoline going up up?. Is is the cost of of gasoline going up up?.";
 * var re = /\b([a-z]+) \1\b/gim;    
 * var rv = ss.replace(re,"$1"); 
 * document.write(rv) //��� "Is the cost of gasoline going up?. Is the cost of gasoline going up?. "
 *  �������
 * /\bCha/
 * ƥ�䵥�� 'Chapter' ��ǰ�����ַ�����Ϊ���ǳ����ڵ��ʱ߽��
 * 
 *  �������
 * /ter\b/
 * ƥ�䵥�� 'Chapter' �е� 'ter'����Ϊ�������ڵ��ʱ߽�֮ǰ
 * 
 *  �������
 * /\Bapt/
 * ƥ�� 'apt'����Ϊ��λ�� 'Chapter' �м䣬������ƥ�� 'aptitude' �е�'apt'����Ϊ��λ�ڵ��ʱ߽��
 * ƥ��URL��ַ
 * 
 *  �������
 * /(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/
 * 
 * ��������URI �ֽ�ΪЭ�� (ftp, http, etc)��������ַ�Լ�ҳ��/·����
 * http://msdn.microsoft.com:80/scripting/default.htm
 * 
 * ��һ�������ӱ��ʽ����������� web ��ַ��Э�鲿�֡����ӱ��ʽƥ��λ��һ��ð�ź�������б��֮ǰ���κε��ʡ��ڶ��������ӱ��ʽ����õ�ַ��������ַ�����ӱ��ʽƥ�䲻���� '^'�� '/' �� ':' �ַ����κ��ַ����С������������ӱ��ʽ������վ�˿ں��룬���ָ���˸ö˿ںš����ӱ��ʽƥ����һ��ð�ŵ���������֡���󣬵��ĸ������ӱ��ʽ�����ɸ� web ��ַָ����·���Լ�\����ҳ����Ϣ�����ӱ��ʽƥ��һ���Ͷ����'#' ��ո�֮����ַ���
 * 
 * ����������ʽӦ����������ʾ�� URI ����ƥ������������ݣ�
 * 
 * RegExp.$1 ���� "http"
 * 
 * RegExp.$2 ���� "msdn.microsoft.com"
 * 
 * RegExp.$3 ���� ":80"
 * 
 * RegExp.$4 ���� "/scripting/default.htm"
 * ������ʽ�ķ���
 * 
 * 
 * 1 test����
 * 
 * ����һ��Booleanֵ����ָ���ڱ����ҵ��ַ������Ƿ����ģʽ
 * 
 * rgExp.test(str)
 * 
 * ȫ��RegExp��������Բ���test�������޸�
 * 
 * example1
 *  �������
 * var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var flag=reg.test(url);
  flag  //����true
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"

  
  search��test���������ܸ���ȫ��RegExp��������RegExp.input,RegExp.index,RegExp.lastIndex����undefined

2 match ����

ʹ��������ʽģʽ���ַ���ִ�в��ң������������ҵĽ����Ϊ���鷵��


 �������
stringObj.match(rgExp)


���match����û���ҵ�ƥ�䣬����null������ҵ�ƥ�䷵��һ�����鲢�Ҹ���ȫ��RegExp����������Է�ӳƥ������

match�������ص��������������ԣ�input��index��lastIndex��
Input���԰��������ı����ҵ��ַ�����
Index���԰������������������ַ�����ƥ������ַ�����λ�á�
LastIndex���԰��������һ��ƥ�������һ���ַ�����һ��λ�á�

���û������ȫ�ֱ�־��g���������0Ԫ�ذ�������ƥ�䣬����1��nԪ�ذ�����ƥ���������ֹ�����һ����ƥ�䡣
���൱��û������ȫ�ֱ�־��exec���������������ȫ�ֱ�־��Ԫ��0��n�а�������ƥ��

example1(û������ȫ�ֱ�־��

  
 �������
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=url.match(reg);
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"
  myArray  //����myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //���ء�http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //����0
  myArray.lastIndex //����51

  
example2(������ȫ�ֱ�־)
  
  
 �������
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/g;
  var myArray=url.match(reg);
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"
  myArray  //����myArray="http://msdn.microsoft.com:80/scripting/default.html"
  myArray.input //���ء�http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //����0
  myArray.lastIndex //����51

  
ע��������ȫ�ֱ�־������
  ���û������ȫ�ֱ�־��g���������0Ԫ�ذ�������ƥ�䣬����1��nԪ�ذ�����ƥ���������ֹ�����һ����ƥ�䡣
  ���൱��û������ȫ�ֱ�־��exec���������������ȫ�ֱ�־��Ԫ��0��n�а�������ƥ��

3 exex����

��������ʽģʽ���ַ������в��ң������ذ����ò��ҽ����һ�����顣


 �������
rgExp.exec(str)


���exec����û���ҵ�ƥ�䣬��������null��
������ҵ�ƥ�䣬��exec��������һ�����飬���Ҹ���ȫ��RegExp��������ԣ��Է�ӳƥ������
�����0Ԫ�ذ�����������ƥ�䣬����1��nԪ���а�������ƥ���г��ֵ�����һ����ƥ�䡣
���൱��û������ȫ�ֱ�־��g����match������

���Ϊ������ʽ������ȫ�ֱ�־��exec����lastIndex��ֵָʾ��λ�ÿ�ʼ���ҡ�
���û������ȫ�ֱ�־��exec����lastIndex��ֵ�����ַ�������ʼλ�ÿ�ʼ������

exec�������ص����� ���������ԣ��ֱ���input��index��lastIndex��
Input���԰��������������ҵ��ַ�����
Index�����а����������������ַ����б�ƥ������ַ�����λ�á�
LastIndex�����а�����ƥ������� һ���ַ�����һ��λ�á�

example1(û������ȫ�ֱ�־��

  
 �������
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=reg.exec(url);
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"
  myArray  //����myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //���ء�http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //����0
  myArray.lastIndex //����51

  
  û������ȫ�ֱ�־(g)ʱ,match������exec������ͬ
  
example2(����ȫ�ֱ�־��
    
  
 �������
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=reg.exec(url);
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"
  myArray  //����myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //���ء�http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //����0
  myArray.lastIndex //����51

   
4 search����

������������ʽ��������ƥ��ĵ�һ�����ַ�����λ�á�


 �������
stringOjb.search(rgExp)


search����ָ���Ƿ������Ӧ��ƥ�� ��
����ҵ�һ��ƥ�䣬search����������һ������ֵ��ָ�����ƥ������ַ�����ʼ��ƫ��λ�á�
���û���ҵ�ƥ�䣬�򷵻�-1��
  
example1

  
 �������
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var flag=url.search(reg);
  flag  //����0
  RegExp.$1 //����"http"
  RegExp.$2 //����"msdn.microsoft.com"
  RegExp.$3 //����":80"
  $egExp.$4 //����"/scripting/default.html"

  
  search��test���������ܸ���ȫ��RegExp��������RegExp.input,RegExp.index,RegExp.lastIndex����undefined
  5 replace����

���ظ���������ʽ���������滻����ַ����ĸ���

�ܸ���ȫ��RegExp����


 * @param regType
 * @return
 */
String.prototype.toRegExp = function(regType) {
	var find = ['\\\\', '\\$', '\\(', '\\)', '\\*', '\\+', '\\.', '\\[', '\\]', '\\?', '\\^', '\\{', '\\}', '\\|', '\\/'];
	var str = this;
	for (var i = 0; i < find.length; i++) {
		str = str.replace(new RegExp(find[i], 'g'), find[i]);
	}
	if (regType == null || regType.trim() == '') {
		return new RegExp(str);
	}
	return new RegExp(str, regType);
};
/**
 * ���ַ���ת����Date����Ҫ���ַ�������������ڻ�����ʱ���ʽ�����򷵻�null
 * @return Data����
 */
String.prototype.toDate = function() {
	if (this.isDate()) {
		var data = this.split('-');
		return new Date(parseInt(data[0],10), parseInt(data[1],10) - 1, parseInt(data[2],10));
	}
	else if (this.isDateTime()) {
		var data = this.split(' ');
		var date = data[0].split('-');
		var time = data[1].split(".")[0].split(':');
		return new Date(parseInt(date[0],10), parseInt(date[1],10) - 1, parseInt(date[2],10), 
			parseInt(time[0],10), parseInt(time[1],10), parseInt(time[2],10));
	}
	else {
		alert("��Ҫת���ĸ�ʽ����ȷ");
		return null;
	}
};
/**
 * �ж��ַ����Ƿ���ָ����ǰ׺��ʼ
 * @param prefix Ϊǰ׺��������ʽ���ַ���
 * @return ��ǰ׺�Ļ�,�ͷ���true
 */
String.prototype.startsWith = function(prefix) {
	if (prefix instanceof RegExp) {
		return new RegExp("^" + prefix.source).test(this);
	}
	else {
		return new RegExp("^" + prefix).test(this);
	}
};
/**
 * �ж��ַ����Ƿ���ָ���ĺ�׺����
 * @param suffix ��׺��������ʽ���ַ���
 * @return �Ǻ�׺�Ļ�,�ͷ���true
 */
String.prototype.endsWith = function(suffix) {
	if (suffix instanceof RegExp) {
		return new RegExp(suffix.source + "$").test(this);
	}
	else {
		return new RegExp(suffix + "$").test(this);
	}
};
/**
 * ���ַ�����HTML��Ҫ�ı��뷽ʽ����
 * @return �����Ĵ�
 */
String.prototype.encodeHtml = function() {
	var strToCode = this.replace(/</g,"&lt;");
	strToCode = strToCode.replace(/>/g,"&gt;");
	return strToCode;
};
/**
 * ���ַ�����HTML��Ҫ�ı��뷽ʽ����
 * @return �����Ĵ�
 */
String.prototype.decodeHtml = function() {
	var strToCode = this.replace(/&lt;/g,"<");
	strToCode = strToCode.replace(/&gt;/g,">");
	return strToCode;
};
/*******************************************************************************
 * �ַ�������String����չ��������
 ******************************************************************************/
/******************
 *** ���ڵĴ��� ***
 ******************/
/**
 * ��ȡϵͳ�����ַ���(YYYY-MM-DD)
 * return ���ڸ�ʽ���ַ���
 */
function getSysDate() {
	var today  = new Date();
	var nYear  = today.getFullYear();
	var nMonth = today.getMonth() + 1;
	var nDay   = today.getDate();
	var sToday = "";
	sToday += (nYear < 1000) ? "" + (1900 + nYear) : nYear;
	sToday += "-";
	sToday += (nMonth < 10) ? "0" + nMonth : nMonth;
	sToday += "-"
	sToday += (nDay < 10) ? "0" + nDay : nDay;
	return sToday;
}
/**
 * ��ȡϵͳ����ʱ���ַ���(YYYY-MM-DD HH-hh-ss)
 * @return ����ʱ���ʽ���ַ���
 */
function getSysDateTime() {
	var today  = new Date();
	var nYear  = today.getFullYear();
	var nMonth = today.getMonth() + 1;
	var nDay   = today.getDate();
	var nHours = today.getHours();
	var nMinutes = today.getMinutes();
	var nSeconds = today.getSeconds();
	var nMilliSeconds = today.getMilliseconds();
	var sToday = "";
	sToday += (nYear < 1000) ? "" + (1900 + nYear) : nYear;
	sToday += "-";
	sToday += (nMonth < 10) ? "0" + nMonth : nMonth;
	sToday += "-"
	sToday += (nDay < 10) ? "0" + nDay : nDay;
	sToday += " ";
	sToday += (nHours < 10) ? "0" + nHours : nHours;
	sToday += ":"
	sToday += (nMinutes < 10) ? "0" + nMinutes : nMinutes;
	sToday += ":"
	sToday += (nSeconds < 10) ? "0" + nSeconds : nSeconds;
	if (nMilliSeconds < 10) {
		sToday += "00" + nMilliSeconds;
	}
	else if (nMilliSeconds < 100) {
		sToday += "0" + nMilliSeconds;
	}
	else {
		sToday += nMilliSeconds;
	}
	return sToday;
}
/**
 * �õ���ǰ��(YYYY)
 * @return ���ص�ǰ���
 */
function getNowYear() {
	var today  = new Date();
	return today.getFullYear();
}
/**
 * �õ�ָ������������
 * @param day ָ��������
 * @return ָ������������
 */
function getNextYear(day){
	var today  = new Date();
	var t = today.getTime();
	var t = day*1000*60*60*24 + t;
	return new Date(t).getFullYear();
}
/**
 * �õ�ָ�������ַ��������
 * @param dateString ���ڵ��ַ���
 * @return �������
 */
function getYear(dateString){
	return dateString.subString(0,4);
}
