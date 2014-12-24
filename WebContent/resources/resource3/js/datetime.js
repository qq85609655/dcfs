function DateTime(year, month, day, hour, min, sec, millisec){ 
var d = new Date(); 

if (year || year == 0){ 
d.setFullYear(year); 
} 
if (month || month == 0){ 
d.setMonth(month - 1); 
} 
if (day || day == 0){ 
d.setDate(day); 
} 
if (hour || hour == 0){ 
d.setHours(hour); 
} 
if (min || min == 0){ 
d.setMinutes(min); 
} 
if (sec || sec == 0){ 
d.setSeconds(sec); 
} 
if (millisec || millisec == 0){ 
d.setMilliseconds(millisec); 
} 
// ��ָ���������ӵ���ʵ����ֵ�ϡ�
this.AddDays = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setDate(result.GetDay() + value); 
return result; 
};
// ��ָ����Сʱ���ӵ���ʵ����ֵ�ϡ�
this.AddHours = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} ;
var result = this.Clone(); 
result.GetValue().setHours(result.GetHour() + value); 
return result; 
} ;
// ��ָ���ķ������ӵ���ʵ����ֵ�ϡ�
this.AddMinutes = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setMinutes(result.GetMinute() + value); 
return result; 
} ;
// ��ָ���ĺ������ӵ���ʵ����ֵ�ϡ�
this.AddMilliseconds = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setMilliseconds(result.GetMillisecond() + value); 
return result; 
} ;
// ��ָ�����·����ӵ���ʵ����ֵ�ϡ�
this.AddMonths = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setMonth(result.GetValue().getMonth() + value); 
return result; 
} ;
// ��ָ���������ӵ���ʵ����ֵ�ϡ�
this.AddSeconds = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setSeconds(result.GetSecond() + value); 
return result; 
} ;
// ��ָ����������ӵ���ʵ����ֵ�ϡ�
this.AddYears = function(value){ 
if(!ValidateAddMethodParam(value)){ 
return null; 
} 
var result = this.Clone(); 
result.GetValue().setFullYear(result.GetYear() + value); 
return result; 
} ;
// ����ʵ����ֵ��ָ���� Date ֵ��Ƚϣ���ָʾ��ʵ�������ڡ����ڻ�������ָ���� Date ֵ��
this.CompareTo = function(other){ 
var internalTicks = other.getTime(); 
var num2 = d.getTime(); 
if (num2 > internalTicks) 
{ 
return 1; 
} 
if (num2 < internalTicks) 
{ 
return -1; 
} 
return 0; 
} ;
// ����һ����ֵ��ͬ����DateTime����
this.Clone = function(){ 
return new DateTime( 
this.GetYear() 
,this.GetMonth() 
,this.GetDay() 
,this.GetHour() 
,this.GetMinute() 
,this.GetSecond() 
,this.GetMillisecond()); 
} ;
// ����һ��ֵ����ֵָʾ��ʵ���Ƿ���ָ���� DateTime ʵ����ȡ�
this.Equals = function(other){ 
return this.CompareTo(other) == 0; 
} ;
// ��ȡ��ʵ�������ڲ��֡�
this.GetDate = function(){ 
var result = new DateTime(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0, 0); 
return result ; 
};
// ��ȡ��ʵ������ʾ������Ϊ�����еĵڼ��졣
this.GetDay = function(){ 
return d.getDate(); 
};
// ��ȡ��ʵ������ʾ�����������ڼ���
this.GetDayOfWeek = function(){ 
return d.getDay(); 
};
// ��ȡ��ʵ������ʾ���ڵ�Сʱ���֡�
this.GetHour = function(){ 
return d.getHours(); 
};
// ��ȡ��ʵ������ʾ���ڵķ��Ӳ��֡�
this.GetMinute = function(){ 
return d.getMinutes(); 
};
// ��ȡ��ʵ������ʾ���ڵĺ��벿�֡�
this.GetMillisecond = function(){ 
return d.getMilliseconds(); 
};
// ��ȡ��ʵ������ʾ���ڵ��·ݲ��֡�
this.GetMonth = function(){ 
return d.getMonth() + 1; 
};
// ��ȡ��ʵ�����¸���һ�յ�DateTime����
this.GetNextMonthFirstDay = function(){ 
var result = new DateTime(this.GetYear(), this.GetMonth(), 1, 0, 0, 0, 0); 
result = result.AddMonths(1); 
return result; 
};
// ��ȡ��ʵ������һ�����յ�DateTime����
this.GetNextWeekFirstDay = function(){ 
var result = this.GetDate(); 
return result.AddDays(7 - result.GetDayOfWeek()); 
};
// ��ȡ��ʵ������һ�����յ�DateTime����
this.GetNextYearFirstDay = function(){ 
return new DateTime(this.GetYear() + 1, 1, 1, 0, 0, 0, 0); 
};
// ��ȡ��ʵ������ʾ���ڵ��벿�֡�
this.GetSecond = function(){ 
return d.getSeconds(); 
};
// ���ش�ʵ����Dateֵ
this.GetValue = function(){ 
return d; 
};
// ��ȡ��ʵ������ʾ���ڵ���ݲ��֡�
this.GetYear = function(){ 
return d.getFullYear(); 
};
// ָʾ��ʵ���Ƿ���DateTime����
this.IsDateTime = function(){} 
// ����ǰ DateTime �����ֵת��Ϊ���Ч�Ķ������ַ�����ʾ��ʽ��
this.ToShortDateString = function(){ 
var result = ""; 
result = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate(); 
return result; 
};
// ����ǰ DateTime �����ֵת��Ϊ���Ч�Ķ�ʱ���ַ�����ʾ��ʽ��
this.ToShortTimeString = function(){ 
var result = ""; 
result = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds(); 
return result; 
};
// ����ǰ DateTime �����ֵת��Ϊ���Ч���ַ�����ʾ��ʽ��
this.ToString = function(format){ 
if(typeof(format) == "string"){ 

} 
return this.ToShortDateString() + " " + this.ToShortTimeString(); 
};
// ��֤Addϵ�еķ��������Ƿ�Ϸ�
function ValidateAddMethodParam(param){ 
if(typeof(param) != "number"){ 
return false; 
} 
return true; 
} 
// �̳���Date�ķ���
this.getTime = function(){ 
return d.getTime(); 
};
} 

// �Ƚ� DateTime ������ʵ�����������������ֵ��ָʾ��
DateTime.Compare = function(d1, d2){ 
return d1.CompareTo(d2); 
};
// ����ָ��������е�������
DateTime.DaysInMonth = function(year, month){ 
if ((month < 1) || (month > 12)) 
{ 
return "�·�[" + month + "]������Χ"; 
} 
var numArray = DateTime.IsLeapYear(year) ? DateTime.DaysToMonth366 : DateTime.DaysToMonth365; 
return (numArray[month] - numArray[month - 1]); 
};
// ����һ��ֵ����ֵָʾ DateTime ������ʵ���Ƿ���ȡ�
DateTime.Equals = function(d1, d2){ 
return d1.CompareTo(d2) == 0; 
};
// ����ָ��������Ƿ�Ϊ�����ָʾ��
DateTime.IsLeapYear = function(year) 
{ 
if ((year < 1) || (year > 0x270f)) 
{ 
return "���[" + year + "]������Χ"; 
} 
if ((year % 4) != 0) 
{ 
return false; 
} 
if ((year % 100) == 0) 
{ 
return ((year % 400) == 0); 
} 
return true; 
};
// ��ȡһ�� DateTime ���󣬸ö�������Ϊ�˼�����ϵĵ�ǰ���ں�ʱ�䣬��ʾΪ����ʱ�䡣
DateTime.Now = new DateTime(); 
// �����ں�ʱ���ָ���ַ�����ʾ��ʽת��Ϊ���Ч�� DateTime��
DateTime.Parse = function(s){ 
var result = new DateTime(); 
var value = result.GetValue(); 
value.setHours(0,0,0,0); 
var dateRex = /\b[1-2][0-9][0-9][0-9][-]\d{1,2}[-]\d{1,2}\b/i; 
if(dateRex.test(s)){ 
var dateStr = s.match(dateRex)[0]; 
try{ 
var dateParts = dateStr.split("-"); 
var year = dateParts[0] - 0; 
var month = dateParts[1] - 1; 
var day = dateParts[2] - 0; 
value.setFullYear(year,month,day); 
}catch(ex){ 
return null; 
} 
var timeRex = /\b\d{1,2}[:]\d{1,2}[:]\d{1,2}\b/i; 
if(timeRex.test(s)){ 
var timeStr = s.match(timeRex)[0]; 
try{ 
var timeParts = timeStr.split(":"); 
var hour = timeParts[0] - 0; 
var min = timeParts[1] - 0; 
var sec = timeParts[2] - 0; 
value.setHours(hour,min,sec); 
}catch(ex){ 

} 
} 
}else{ 
return null; 
} 
return result; 
};
// ��ȡ��ǰ���ڣ���ʱ����ɲ�������Ϊ 00:00:00��
DateTime.Today = new DateTime(null, null, null, 0, 0, 0, 0); 

// ��̬�ֶ�
DateTime.DaysToMonth365 = [ 0, 0x1f, 0x3b, 90, 120, 0x97, 0xb5, 0xd4, 0xf3, 0x111, 0x130, 0x14e, 0x16d ]; 
DateTime.DaysToMonth366 = [ 0, 0x1f, 60, 0x5b, 0x79, 0x98, 0xb6, 0xd5, 0xf4, 0x112, 0x131, 0x14f, 0x16e ]; 
