/**
 * 特殊字符
 */
var specialChars = /[!@#\$%\^&\*\(\)\{\}\[\]<>_\+\|~`-]|[=\/\\\?;:,！·#￥%……—*（）——、《》，。？'"]/g;
/**
 * 查询的特殊字符
 */
var searchspecialChars = /[%']/g;
/**
 * 数据库操作特殊字符
 */
var dbSpecialChars = /[!@\^&\|~`'"%\\\?;]/g;
/*******************************************************************************
 * 以下是对字符串对象（String）的扩展函数，任何String对象都可 使用这些函数，例如： var str = " dslf dsf sfd ";
 * alert(str.trim()); //显示这样的字符串"dslf dsf sfd" alert(str.deleteSpace());
 * //显示这样的字符串"dslfdsfsfd"
 ******************************************************************************/
 
/*
 * function:在字符串左边补指定的字符串 parameter： countLen:结果字符串的长度 addStr:要附加的字符串
 * return:处理后的字符串
 */
/**
 * 在字符串左边补指定的字符串<br>
 * 例如：10.02 执行 lpad(8,'0')，得到的值为 00010.02
 * 
 * @param countLen
 *            结果字符串的长度
 * @param addStr
 *            要附加的字符串
 * @return 左边补充后的字符串
 */
String.prototype.lpad = function(countLen,addStr)
{
        // 如果countLen不是数字，不处理返回
        if(isNaN(countLen))return this;

        // 初始字符串长度大于指定的长度，则不需处理
        if(initStr.length >= countLen)return this;

        var initStr = this;        // 初始字符串
        var tempStr = new String();        // 临时字符串

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
 * function: parameter： countLen:结果字符串的长度 addStr:要附加的字符串 return:处理后的字符串
 */
/**
 * 在字符串右边补指定的字符串<br>
 * 例如：10.02 执行 lpad(6,'0')，得到的值为 10.020
 * 
 * @param countLen
 *            结果字符串的长度
 * @param addStr
 *            要附加的字符串
 * @return 右边补充后的字符串
 */
String.prototype.rpad = function(countLen,addStr)
{
        // 如果countLen不是数字，不处理返回
        if(isNaN(countLen))return this;

        // 初始字符串长度大于指定的长度，则不处理返回
        if(initStr.length >= countLen)return this;

        var initStr = this;        // 初始字符串

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
 * 去掉字符串中所有的空格
 * @return 处理后的字符串
 */
String.prototype.atrim = function()
{
    // 用正则表达式将右边空格用空字符串替代。
    return this.replace(/(\s+)|(　+)/g, "");
};

/**
 *去掉字符串两边的空格
 *@return 处理后的字符串
 */
String.prototype.trim = function()
{
    // 用正则表达式将前后空格用空字符串替代。
    return this.replace(/(^\s+)|(\s+$)|(^　+)|(　+$)/g, "");
};
/**
 * 去掉字符串左边的空格
 * @return 处理后的字符串
 */
String.prototype.ltrim = function()
{
        return this.replace(/(^\s+)|(^　+)/g,"");
};


/**
 * 去掉字符串右边的空格
 * @return 处理后的字符串
 */
String.prototype.rtrim = function()
{
        return this.replace(/(\s+$)|(　+$)/g,"");
};

/*
 * function: return:字节数 example:
 */
/**
 * 获得字符串的字节数<br>
 * 例如："test测试".getByte值为8
 * @return 字节数
 */
String.prototype.getByte = function()
{
        var intCount = 0;
        for(var i = 0;i < this.length;i ++)
        {
            // Ascii码大于255是双字节的字符
            var ascii = this.charCodeAt(i).toString(16);
            var byteNum = ascii.length / 2.0;
            intCount += (byteNum + (ascii.length % 2) / 2);
        }
        return intCount;
};
/**
 * 指定字符集半角字符全部转变为对应的全角字符
 * @param dbcStr 要转换的半角字符集合
 * @return 转换后的字符串
 */
String.prototype.dbcToSbc = function(dbcStr)
{
        var resultStr = this;

        for(var i = 0;i < this.length;i ++)
        {
                switch(dbcStr.charAt(i))
                {
                        case ",":
                                resultStr = resultStr.replace(/\,/g,"，"); 
                                break;
                        case "!":
                                resultStr = resultStr.replace(/\!/g,"！"); 
                                break;
                        case "#":
                                resultStr = resultStr.replace(/\#/g,"＃"); 
                                break;
                        case "|":
                                resultStr = resultStr.replace(/\|/g,"|"); 
                                break;
                        case ".":
                                resultStr = resultStr.replace(/\./g,"。"); 
                                break;
                        case "?":
                                resultStr = resultStr.replace(/\?/g,"？"); 
                                break;
                        case ";":
                                resultStr = resultStr.replace(/\;/g,"；"); 
                                break;
                }
        }
        return resultStr;
};

/**
 * 获取按字节数指定的字串
 * @param index1 开始字节
 * @param index2 结束字节
 * @return 返回截取后的字符串<br>注意双字节字符可能会出现乱码
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
 *  判断字符串是否是数字字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isNumber = function() {
	return (this.isInt() || this.isFloat());
};

/**
 * 判断字符串是否是浮点数字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isFloat = function() {
	return /^(?:-?|\+?)\d*\.\d+$/g.test(this);
};
/**
 * 判断字符串是否是满足指定长度、小数位数（长度值包括了小数位数）
 * @param length 数字的长度，包括小数和点
 * @param precision 精度，小数的位数
 * @return 若是则返回true，否则返回false
 */
String.prototype.isNumberLength= function(length,precision){
	intPart = length - precision;
	re = new RegExp("^(?:-?|\\+?)\\d{1," + intPart + "}(\\.\\d{0," + precision + "})?$","g");
	return re.test(this);
};
/**
 * 判断字符串是否是整数字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isInt = function() {
	return /^(?:-?|\+?)\d+$/g.test(this);
};
/**
 * 判断字符串是否是正数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isPlus = function() {
	return this.isPlusInt() || this.isPlusFloat();
};
/**
 * 判断字符串是否是正浮点数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isPlusFloat = function() {
	return /^\+?\d*\.\d+$/g.test(this);
};
/**
 * 判断字符串是否是正整数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isPlusInt = function() {
	return /^\+?\d+$/g.test(this);
};
/**
 * 判断字符串是否是负数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isMinus = function() {
	return this.isMinusInt() || this.isMinusFloat();
};
/**
 * 判断字符串是否是负浮点数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isMinusFloat = function() {
	return /^-\d*\.\d+$/g.test(this);
};
/**
 * 判断字符串是否是负整数字符串
 * @return 若是正数则返回true，否则返回false
 */
String.prototype.isMinusInt = function() {
	return /^-\d+$/g.test(this);
};

/**
 * 判断字符串是否只包含单词字符
 * @return 若是则返回true，否则返回false
 */
String.prototype.isLeastCharSet = function() {
	return !(/[^A-Za-z0-9_]/g.test(this));
};
/**
 * 判断字符串是否是Email字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isEmail = function() {
	return /^\w+@.+\.\w+$/g.test(this);
};
/**
 * 判断字符串是否是邮政编码字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isZip = function() {
	return /^\d{6}$/g.test(this);
};
/**
 *判断字符串是否是固定电话号码字符串 
 * @return 若是则返回true，否则返回false
 */
String.prototype.isFixedTelephone = function() {
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,18}(-\d+)?$/g.test(this);
};
/**
 * 判断字符串是否是手机电话号码字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isMobileTelephone = function() {
	return this.isBaseMobileTelephone();
};
/**
 * 判断字符串是否是13、15号码段手机电话号码字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.isBaseMobileTelephone = function() {
	return /^((13)|(15))\d{9}$/g.test(this);
};
/**
 * 判断字符串是否是3G-18号码段手机电话号码字符串
 * @return 若是则返回true，否则返回false
 */
String.prototype.is3GMobileTelephone = function() {
	return /^(18)\d{9}$/g.test(this);
};
/**
 * 判断字符串是否是电话号码字符串，包括座机和手机
 * @return 若是则返回true，否则返回false
 */
String.prototype.isTelephone = function() {
	return this.isMobileTelephone() || this.isFixedTelephone();
};

/**
 * 判断字符串是否是日期字符串(YYYY-MM-DD)
 * @return 若是则返回true，否则返回false
 */
String.prototype.isDate = function() {
	return /^\d{1,4}-(?:(?:(?:0?[1,3,5,7,8]|1[0,2])-(?:0?[1-9]|(?:1|2)[0-9]|3[0-1]))|(?:(?:0?[4,6,9]|11)-(?:0?[1-9]|(?:1|2)[0-9]|30))|(?:(?:0?2)-(?:0?[1-9]|(?:1|2)[0-9])))$/g.test(this);
};
/**
 * 判断字符串是否是时间字符串 (HH-mm-ss)
 * @return 若是则返回true，否则返回false
 */
String.prototype.isTime = function() {
	return /^(?:(?:0?|1)[0-9]|2[0-3]):(?:(?:0?|[1-5])[0-9]):(?:(?:0?|[1-5])[0-9])(?:\.(?:\d{1,3}))?$/g.test(this);
};
/**
 * 判断字符串是否是日期时间字符串(YYYY-MM-DD HH-mm-ss)
 * @return 若是则返回true，否则返回false
 */
String.prototype.isDateTime = function() {
	return /^\d{1,4}-(?:(?:(?:0?[1,3,5,7,8]|1[0,2])-(?:0?[1-9]|(?:1|2)[0-9]|3[0-1]))|(?:(?:0?[4,6,9]|11)-(?:0?[1-9]|(?:1|2)[0-9]|30))|(?:(?:0?2)-(?:0?[1-9]|(?:1|2)[0-9]))) +(?:(?:0?|1)[0-9]|2[0-3]):(?:(?:0?|[1-5])[0-9]):(?:(?:0?|[1-5])[0-9])(?:\.(?:\d{1,3}))?$/g.test(this);
};
/**
 * 比较日期字符串
 * @param target 要比较的日期串
 * @return 若相等则返回0,<br>
 * 否则返回当前日期字符串和目标字符串之间相差的毫秒数，<br>
 * 若其中一个字符串不符合日期或日期时间格式，则返回null。
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
 * 判断日期字符串指定的时期是否是当前日期
 * @return 若是则返回true，否则返回false
 */
String.prototype.isToday = function() {
	return this.trim().split(' ')[0].compareDate(getSysDate()) == 0;
};
/**
 * 判断日期字符串指定的时期是否是在基准日期之前
 * @param baseDate 比较的基准日期,如果在基准日期前,则为true
 * @param canEquals 是否包含基准日期
 * @return 若是则返回true，否则返回false
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
 * 判断日期字符串指定的时期是否是基准日期之后
 * @param baseDate 比较的基准日期,如果在基准日期后,则为true
 * @param canEquals 是否包含基准日期
 * @return 若是则返回true，否则返回false
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
 * 判断日期时间字符串指定的日期是否是基准日期时间之前
 * @param baseDateTime 基准日期时间
 * @param canEquals 是否包含基准日期时间
 * @return 若是则返回true，否则返回false
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
 * 判断日期时间字符串指定的日期是否是基准日期时间之后
 * @param baseDateTime 基准日期时间
 * @param canEquals 是否包含基准日期时间
 * @return 若是则返回true，否则返回false
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
 * 判断字符串中是否含有特殊字符(特殊字符集在extendString.js的最上方指定)
 * @return 若有则返回true，否则返回false
 */
String.prototype.hasSpecialChar = function() {
	return !specialChars.test(this);
};
/**
 * 判断字符串中是否含有查询特殊字符(查询特殊字符集在extendString.js的最上方指定)
 * @return 若有则返回true，否则返回false
 */
String.prototype.hasSearchSpecialChar = function() {
	return !searchspecialChars.test(this);
};
/**
 * 判断字符串中是否含有数据库操作特殊字符(数据库操作特殊字符集在extendString.js的最上方指定)
 * @return 若有则返回true，否则返回false
 */
String.prototype.hasDBSpecialChar = function() {
	return !dbSpecialChars.test(this);
};
/**
 * 删除字符串中的空格
 * @return 删除后的字符串
 */
String.prototype.deleteSpace = function() {
	return this.replace(/( +)|(　+)/g, '');
};
/**
 * 删除字符串中指定的字符串
 * @param str 指定的字符串
 * @return 删除后的字符串
 */
String.prototype.remove = function(str) {
	if (str == null || str == '') {
		return this;
	}
	return this.replace(str.toRegExp('g'), '');
};
/**
 * 将字符串中包含的find字符串替换成target字符串，返回替换后的结果字符串
 * @param find 包含的字符串
 * @param target 要替换的字符串
 * @return 替换后的字符串
 */
String.prototype.replaceByString = function(find, target) {
	return this.replace(find.toRegExp('g'), target);
};
/**
 * 将字符串转换成相应的正则表达式,使用方法:
 * g 代表全局匹配
 * m 代表可以进行多行匹配
 * i 代表不区分大小写匹配
 * ^ 匹配输入字符串的开始位置
 * $ 匹配输入字符串的结束位置
 * * 匹配前面的子表达式零次或多次. 等价于{0,}
 * + 匹配前面的子表达式一次或多次. 等价于{1,}
 * ? 匹配前面的子表达式零次或一次. 等价于[0,1} , 当该字符跟在任何一个其他限制符(*, +, ?, {n}, {n,}, {n,m}) 后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串 "oooo"，'o+?' 将匹配单个 "o"，而 'o+' 将匹配所有 'o'。

 * \d 匹配一个数字字符. 等价于 [0-9]
 * \D 匹配一个非数字符. 等价于 [^0-9]
 * \w  ,等价于 "[A-Za-z0-9_]"
 * \W 匹配任何非单词字符,等价于 "[^A-Za-z0-9]"
 * \s 匹配任何空白字符, 包括空格 制表符 换页符 等等. 等价于[\f\n\r\t\v]
 * \S 匹配任何非空白字符. 等价于 [^\f\r\n\t\v]
 * \b 匹配一个单词边界，也就是指单词和空格间的位置。
 * \B 匹配非单词边界。
 * 
 * (pattern)匹配pattern 并获取这一匹配。所获取的匹配可以从产生的 Matches 集合得到，在VBScript 中使用 SubMatches 集合，在JScript 中则使用 $0…$9 属性。
 * 
 * (?:pattern)匹配 pattern 但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用 "或" 字符 (|) 来组合一个模式的各个部分是很有用。例如， 'industr(?:y|ies) 就是一个比 'industry|industries' 更简略的表达式。
 * 
 * (?=pattern)正向预查，在任何匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如， 'Windows (?=95|98|NT|2000)' 能匹配 "Windows 2000" 中的 "Windows" ，但不能匹配 "Windows 3.1" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。
 * 
 * (?!pattern)负向预查，在任何不匹配Negative lookahead matches the search string at any point where a string not matching pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如'Windows (?!95|98|NT|2000)' 能匹配 "Windows 3.1" 中的 "Windows"，但不能匹配 "Windows 2000" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始
 * 
 * 匹配2-4个汉字
 * 
  * 程序代码
 * /^[\u4e00-\u9fa5]{2,4}$/g;
 * 
 * 
 * 匹配6到18个(字母,数字,下划线)字符
 * 
  * 程序代码
 * /^\w{6,18}$/;
 * 
 * 
 * 程序代码
 * /^[A-Za-z0-9_]$/;
 * 
 * 
 * 匹配HTML标签
 * 
 *  程序代码
 * /<[^>]*>|<\/[^>]*>/gm;
 * 
 * 
 *  程序代码
 * /<\/?[^>]+>/gm;
 * 
 * 
 * 匹配左右两端的空格
 * 
 *  程序代码
/ * (^\s*)|(\s*$)/g;
 * 
 * 
 * 优先级顺序(从高到低)
 * \ 转义符
 * (),(?:),(?=),[] 圆括号和方括号
 * * , + , ? , {n} , {n,} , {n,m} 限定符
 * ^ , [vapour:content]nbsp; 位置和顺序
 * | "或"操作
 * 
 * 匹配两个连续的以空格分开的相同单词
 * 
 *  程序代码
 * /\b([a-z]+) \1\b/gim ;
 * 
 * 在这个示例中，子表达式就是圆括号之间的每一项。
 * 所捕获的表达式包括一个或多个字母字符，即由'[a-z]+' 所指定的。
 * 该正则表达式的第二部分是对前面所捕获的子匹配的引用，也就是由附加表达式所匹配的第二次出现的单词。
 * '\1'用来指定第一个子匹配。单词边界元字符确保只检测单独的单词。
 * 如果不这样，则诸如 "is issued" 或 "this is" 这样的短语都会被该表达式不正确地识别。
 *  程序代码
 * var ss = "Is is the cost of of gasoline going up up?. Is is the cost of of gasoline going up up?.";
 * var re = /\b([a-z]+) \1\b/gim;    
 * var rv = ss.replace(re,"$1"); 
 * document.write(rv) //输出 "Is the cost of gasoline going up?. Is the cost of gasoline going up?. "
 *  程序代码
 * /\bCha/
 * 匹配单词 'Chapter' 的前三个字符，因为它们出现在单词边界后
 * 
 *  程序代码
 * /ter\b/
 * 匹配单词 'Chapter' 中的 'ter'，因为它出现在单词边界之前
 * 
 *  程序代码
 * /\Bapt/
 * 匹配 'apt'，因为它位于 'Chapter' 中间，但不会匹配 'aptitude' 中的'apt'，因为它位于单词边界后
 * 匹配URL地址
 * 
 *  程序代码
 * /(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/
 * 
 * 将下述的URI 分解为协议 (ftp, http, etc)，域名地址以及页面/路径：
 * http://msdn.microsoft.com:80/scripting/default.htm
 * 
 * 第一个附加子表达式是用来捕获该 web 地址的协议部分。该子表达式匹配位于一个冒号和两个正斜杠之前的任何单词。第二个附加子表达式捕获该地址的域名地址。该子表达式匹配不包括 '^'、 '/' 或 ':' 字符的任何字符序列。第三个附加子表达式捕获网站端口号码，如果指定了该端口号。该子表达式匹配后跟一个冒号的零或多个数字。最后，第四个附加子表达式捕获由该 web 地址指定的路径以及\或者页面信息。该子表达式匹配一个和多个除'#' 或空格之外的字符。
 * 
 * 将该正则表达式应用于上面所示的 URI 后，子匹配包含下述内容：
 * 
 * RegExp.$1 包含 "http"
 * 
 * RegExp.$2 包含 "msdn.microsoft.com"
 * 
 * RegExp.$3 包含 ":80"
 * 
 * RegExp.$4 包含 "/scripting/default.htm"
 * 正则表达式的方法
 * 
 * 
 * 1 test方法
 * 
 * 返回一个Boolean值，它指出在被查找的字符串中是否存在模式
 * 
 * rgExp.test(str)
 * 
 * 全局RegExp对象的属性不由test方法来修改
 * 
 * example1
 *  程序代码
 * var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var flag=reg.test(url);
  flag  //返回true
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"

  
  search和test方法都不能更新全局RegExp对象，所以RegExp.input,RegExp.index,RegExp.lastIndex返回undefined

2 match 方法

使用正则表达式模式对字符串执行查找，并将包含查找的结果作为数组返回


 程序代码
stringObj.match(rgExp)


如果match方法没有找到匹配，返回null。如果找到匹配返回一个数组并且更新全局RegExp对象的属性以反映匹配结果。

match方法返回的数组有三个属性：input、index和lastIndex。
Input属性包含整个的被查找的字符串。
Index属性包含了在整个被查找字符串中匹配的子字符串的位置。
LastIndex属性包含了最后一次匹配中最后一个字符的下一个位置。

如果没有设置全局标志（g），数组的0元素包含整个匹配，而第1到n元素包含了匹配中曾出现过的任一个子匹配。
这相当于没有设置全局标志的exec方法。如果设置了全局标志，元素0到n中包含所有匹配

example1(没有设置全局标志）

  
 程序代码
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=url.match(reg);
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"
  myArray  //返回myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //返回“http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //返回0
  myArray.lastIndex //返回51

  
example2(设置了全局标志)
  
  
 程序代码
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/g;
  var myArray=url.match(reg);
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"
  myArray  //返回myArray="http://msdn.microsoft.com:80/scripting/default.html"
  myArray.input //返回“http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //返回0
  myArray.lastIndex //返回51

  
注意设置了全局标志后区别
  如果没有设置全局标志（g），数组的0元素包含整个匹配，而第1到n元素包含了匹配中曾出现过的任一个子匹配。
  这相当于没有设置全局标志的exec方法。如果设置了全局标志，元素0到n中包含所有匹配

3 exex方法

用正则表达式模式在字符串运行查找，并返回包含该查找结果的一个数组。


 程序代码
rgExp.exec(str)


如果exec方法没有找到匹配，则它返回null。
如果它找到匹配，则exec方法返回一个数组，并且更新全局RegExp对象的属性，以反映匹配结果。
数组的0元素包含了完整的匹配，而第1到n元素中包含的是匹配中出现的任意一个子匹配。
这相当于没有设置全局标志（g）的match方法。

如果为正则表达式设置了全局标志，exec从以lastIndex的值指示的位置开始查找。
如果没有设置全局标志，exec忽略lastIndex的值，从字符串的起始位置开始搜索。

exec方法返回的数组 有三个属性，分别是input、index、lastIndex。
Input属性包含了整个被查找的字符串。
Index属性中包含了整个被查找字符串中被匹配的子字符串的位置。
LastIndex属性中包含了匹配中最后 一个字符的下一个位置。

example1(没有设置全局标志）

  
 程序代码
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=reg.exec(url);
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"
  myArray  //返回myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //返回“http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //返回0
  myArray.lastIndex //返回51

  
  没有设置全局标志(g)时,match方法和exec方法相同
  
example2(设置全局标志）
    
  
 程序代码
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var myArray=reg.exec(url);
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"
  myArray  //返回myArray[0]="http://msdn.microsoft.com:80/scripting/default.html",
      myArray[1]="http",myArray[2]="msdn.microsoft.com",
      myArray[3]=":80",myArray[4]="/scripting/default.html"
  myArray.input //返回“http://msdn.microsoft.com:80/scripting/default.html"
  myArray.index //返回0
  myArray.lastIndex //返回51

   
4 search方法

返回与正则表达式查找内容匹配的第一个子字符串的位置。


 程序代码
stringOjb.search(rgExp)


search方法指明是否存在相应的匹配 。
如果找到一个匹配，search方法将返回一个整数值，指明这个匹配距离字符串开始的偏移位置。
如果没有找到匹配，则返回-1。
  
example1

  
 程序代码
var url="http://msdn.microsoft.com:80/scripting/default.html";
  var reg=/(\w+):\/\/([^\/:]+)(:\d*)?([^#]*)/;
  var flag=url.search(reg);
  flag  //返回0
  RegExp.$1 //返回"http"
  RegExp.$2 //返回"msdn.microsoft.com"
  RegExp.$3 //返回":80"
  $egExp.$4 //返回"/scripting/default.html"

  
  search和test方法都不能更新全局RegExp对象，所以RegExp.input,RegExp.index,RegExp.lastIndex返回undefined
  5 replace方法

返回根据正则表达式进行文字替换后的字符串的复制

能更新全局RegExp对象


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
 * 将字符串转换成Date对象，要求字符串必须符合日期或日期时间格式，否则返回null
 * @return Data对象
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
		alert("需要转换的格式不正确");
		return null;
	}
};
/**
 * 判断字符串是否以指定的前缀开始
 * @param prefix 为前缀的正则表达式或字符串
 * @return 是前缀的话,就返回true
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
 * 判断字符串是否以指定的后缀结束
 * @param suffix 后缀的正则表达式或字符串
 * @return 是后缀的话,就返回true
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
 * 将字符串按HTML需要的编码方式编码
 * @return 编码后的串
 */
String.prototype.encodeHtml = function() {
	var strToCode = this.replace(/</g,"&lt;");
	strToCode = strToCode.replace(/>/g,"&gt;");
	return strToCode;
};
/**
 * 将字符串按HTML需要的编码方式解码
 * @return 解码后的串
 */
String.prototype.decodeHtml = function() {
	var strToCode = this.replace(/&lt;/g,"<");
	strToCode = strToCode.replace(/&gt;/g,">");
	return strToCode;
};
/*******************************************************************************
 * 字符串对象（String）扩展函数结束
 ******************************************************************************/
/******************
 *** 日期的处理 ***
 ******************/
/**
 * 获取系统日期字符串(YYYY-MM-DD)
 * return 日期格式的字符串
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
 * 获取系统日期时间字符串(YYYY-MM-DD HH-hh-ss)
 * @return 日期时间格式的字符串
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
 * 得到当前年(YYYY)
 * @return 返回当前年份
 */
function getNowYear() {
	var today  = new Date();
	return today.getFullYear();
}
/**
 * 得到指定天数后的年份
 * @param day 指定的天数
 * @return 指定天数后的年份
 */
function getNextYear(day){
	var today  = new Date();
	var t = today.getTime();
	var t = day*1000*60*60*24 + t;
	return new Date(t).getFullYear();
}
/**
 * 得到指定日期字符串的年份
 * @param dateString 日期的字符串
 * @return 返回年份
 */
function getYear(dateString){
	return dateString.subString(0,4);
}
