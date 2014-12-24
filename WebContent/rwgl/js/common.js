// ��һ������ת��Ϊ����
function var_to_obj(val)
{
	this.value=val;
}
// �ж��Ƿ����ĳ����
function is_greater(field,crit,limit)
{
	var Ret = (is_numeric(field,-1) ) ? (field.value > limit )  : false;
	if (!Ret)
		doCritCode(field,crit,"Value must be greater than "+limit);
	return(Ret);
}
// �ж��Ƿ�С��ĳ����
function is_less(field,crit,limit)
{
	var Ret = (is_numeric(field,-1) ) ? (field.value < limit )  : false;
	if (!Ret)
		doCritCode(field,crit,"Value must be less than "+limit);
	return(Ret);
}
//�Ƚ��������ڵĴ�С��Num1>Num2 return:true;Num1<=Num2 return:false
function Compare_Date(Num1,Num2)
{
		var pos1,pos2,end;
		var para1,para2,para3,para4,para5,para6;

		//para1:��
		//para2:��
		//para3:��
		end=Num1.length;
		pos1=Num1.indexOf("-",0);
		pos2=Num1.indexOf("-",pos1+1);
		para1=Num1.substring(0,pos1);
		para2=Num1.substring(pos1+1,pos2);
		para3=Num1.substring(pos2+1,end);
		para1=parseFloat(para1);
		para2=parseFloat(para2);
		para3=parseFloat(para3);
		end=Num2.length;
		pos1=Num2.indexOf("-",0);
		pos2=Num2.indexOf("-",pos1+1);
		para4=Num2.substring(0,pos1);
		para5=Num2.substring(pos1+1,pos2);
		para6=Num2.substring(pos2+1,end);
		para4=parseFloat(para4);
		para5=parseFloat(para5);
		para6=parseFloat(para6);
		if(para1>para4)
		{
			return true;
		}
		else if(para1==para4)
		{
			if(para2>para5)
			{
				return true;
			}
			else if(para2==para5)
			{
				if(para3>para6)
				{
					return true;
				}
			}
		}
		return false;

}
//format float data as:*****.**
//decplaces:С��λ��
function FloatFormat(expr,decplaces)
{
        var str = "" + Math.round(eval(expr)*Math.pow(10,decplaces));
        while(str.length <= decplaces)
        {
                str = "0" + str;
        }

        var decpoint = str.length - decplaces;
        return str.substring(0,decpoint) + "." + str.substring(decpoint,str.length);
}
function is_numeric(field,crit,msg)
{
	var Ret = true;
	var NumStr="0123456789";
	var decUsed=false;
	var chr;
	for (i=0;i<field.value.length;++i)
	{
		chr=field.value.charAt(i);
		if (NumStr.indexOf(chr,0)==-1)
		{
			if ( (!decUsed) && chr==".")
			{
				decUsed=true;
			}
			else
			{
				Ret=false;
			}
		}
	}
	if (!Ret)
		doCritCode(field,crit,msg);
	return(Ret);
}
 // �ж��Ƿ��Ǽ۸�
function is_price(field,crit,msg)
{
	var Ret = true;
	var NumStr="0123456789";
	var decUsed=false;
	var chr;
	for (i=0;i<field.value.length;++i)
	{
		chr=field.value.charAt(i);
		if (NumStr.indexOf(chr,0)==-1)
		{
			if ( (!decUsed) && chr==".")
			{
				decUsed=true;
			}
			else
			{
				Ret=false;
			}
		}
	}
	if(Ret)
	{
		if(decUsed&&(field.value.length-field.value.indexOf('.')<4))
		;
		else if(decUsed)
			Ret=false;
	}
	if (!Ret)
		doCritCode(field,crit,msg);
	return(Ret);
}
 // �ж��Ƿ��ǿ� true:�� false:�ǿ�
function Is_Null(field,crit,msg)
{
	Text=""+Trim(field.value);

	if(Text.length)
	{
		for(var i=0;i<Text.length;i++)
		if(Text.charAt(i)!=" ")
		break;
		if(i>=Text.length)
			Ret=true;
		else
			Ret=false;
	}
	else
		Ret=true;
	if (Ret)
		doCritCode(field,crit,msg);
	return(Ret);
}
//ȷ���Ƿ����Ϊ��true:����false��������
function Null_Ok(field,crit,msg1,msg2)
{
	Text=""+Trim(field.value);

	if(Text.length)
	{
		for(var i=0;i < Text.length;i++)
			if(Text.charAt(i)!=" ")
				break;
		if(i>=Text.length)

			Ret=true;
		else
			Ret=false;
	}else{
		Ret=true;
	}
	if(Ret)
	{
		if(!confirm(msg2))
			doCritCode(field,crit,msg1);
		else
			Ret = false;
	}
	return(Ret);
}

function IsSpace(field)
{
	var Text=""+field.value;
	if(Text.length)
	{
		for(var i=0;i<Text.length;i++)
			if(Text.charAt(i)!=" ")
				break;
		if(i>=Text.length)
			field.value="";
	}
}

function doCritCode(field,crit,msg)
{
	if ( (-1!=crit) )
	{
		//alert(msg)
		if (crit==1)
		{
			field.focus();  // focus does not work on certain netscape versions
			field.select();
		}
	}
}
// �ж��Ƿ�������true:��������false:��������
function Is_Int(field,crit,msg){
	var Ret = true;
	var NumStr="0123456789";
	var chr;

	for (i=0;i<field.value.length;i++)
	{
		chr=field.value.charAt(i);
		if (NumStr.indexOf(chr,0)==-1)
		{
			Ret=false;
		}
	}
	if (!Ret)
		doCritCode(field,crit,msg);
	return(Ret);
}
// �ж��Ƿ������� ����date����false ��date����true
function is_date(field,crit,msg){
	var Ret = false;
	var mark1;
	var mark2;
	var days

	if(field.value=="")
		return true;
	cd=new Date();

	if ( (mark1 = field.value.indexOf('-'))==-1)
		mark1=field.value.indexOf('-')
	if (mark1>-1)
	{
		if ( (mark2 = field.value.indexOf('-',mark1+1)) ==-1)
			mark2=field.value.indexOf('-',mark1+1);
		if ((mark2>-1)&&(mark2+1<field.value.length) )
		{
			year = new var_to_obj(field.value.substring(0,mark1));
			month = new var_to_obj(field.value.substring(mark1+1,mark2));
			day = new var_to_obj(field.value.substring(mark2+1,field.value.length));
			days = getDaysInMonth(month.value,year.value) + 1

			if (
				(is_greater(day,-1,0))&&(is_less(day,-1,days))&&
				(is_greater(month,-1,0))&&(is_less(month,-1,13))&&
				(is_greater(year,-1,1900))&&(is_less(year,-1,2500))
				)
				Ret=true;
		}
	}
	if (!Ret) doCritCode(field,crit,msg);

	return(Ret);
}

function is_date2(tmpy,tmpm,tmpd)
{
	year=new String (tmpy);
	month=new String (tmpm);
	day=new String (tmpd)
	if ((tmpy.length!=4) || (tmpm.length>2) || (tmpd.length>2))
	{
		return false;
	}
	if (!((1<=month) && (12>=month) && (31>=day) && (1<=day)) )
	{
		return false;
	}
	if (!( ((year % 4)==0) && ((year % 400)==0) ) && (month==2) && (day==29))
	{
		return false;
	}
	if ((month<=7) && ((month % 2)==0) && (day>=31))
	{
		return false;

	}
	if ((month>=8) && ((month % 2)==1) && (day>=31))
	{
		return false;
	}
	if ((month==2) && (day==30))
	{
		return false;
	}

	return true;
}


function doCrit(field,crit,msg)
{
	if ( (-1!=crit) )
	{
		alert(msg);
		if (crit==1)
		{
			field.focus();  // focus does not work on certain netscape versions
		}
	}
}
// �ж��Ƿ�����Ч���ݱ�ѡ��
function IsSelected(field,crit,msg)
{
	value=""+field.options[field.selectedIndex].value;
	if(value=="0")
		Ret=true;
	else
		Ret=false;
	if (Ret)
		doCrit(field,crit,msg);
	return(Ret);
}
//����Ƿ���radio��ѡ�� field:form1.appid
function IsChecked(field,msg)
{
	l = field.length;
	if(l==undefined){
		if(!field.checked){
			alert(msg);
			return false
		}else{
			return true
		}
	}else{
		flag=0;
		for(i=0;i<l;i++){
			if(field[i].checked==true){
				flag++;
			}
		}

		if(flag==0){
			alert(msg);
			return false
		}else{
			return true
		}
	}
}



// ����Ƿ����ַ�
// cCharacter������ֵ
function isCharacter( cCharacter )
{
	var sFormat = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	if( sFormat.indexOf( cCharacter, 0 ) == -1 )
	{
		return false;
	}

	return true;
}

// ����Ƿ����������������Ƶ��ַ�
// cCharacter������ֵ
function isOtherNameCharacter( cCharacter )
{
	var sFormat = "_";

	if( sFormat.indexOf( cCharacter, 0 ) == -1 )
	{
		return false;
	}

	return true;
}

// ����Ƿ��ǿ��������Ƶ��ַ�
// sValue������ֵ
function isNameCharacter( sValue )
{
	if( sValue == null )
	{
		return false;
	}

	for( i = 0; i < sValue.length; i ++ )
	{
		var cCharacter = sValue.charAt( i );
		if( isDigital( cCharacter ) == false && isCharacter( cCharacter ) == false && isOtherNameCharacter( cCharacter ) == false )
		{
			return false;
		}
	}

	return true;
}

// ����Ƿ���Email
// sValue������ֵ���Ϸ���ʽΪa@b.c.d������ʽ
function isEmail( sValue )
{
	var iFirstIndex = 0;
	var iSecondIndex = sValue.indexOf( '@' );
	if( iSecondIndex == -1 )
	{
		return false;
	}

	var sTemp = sValue.substring( iFirstIndex, iSecondIndex );
	if( isNameCharacter( sTemp ) == false )
	{
		return false;
	}

	iSecondIndex = sValue.indexOf( '.' );
	if( iSecondIndex == -1 || sValue.substring( sValue.length-1, sValue.length ) == '.' )
	{
		return false;
	}
	else if(  sTemp.length == sValue.length - 2 )	// The last two characters are '@' and '.'
	{
		return false;
	}
	else
	{
		var sTempValue = sValue;
		iSecondIndex = sValue.indexOf( '@' );
		while( iSecondIndex != -1 )
		{
			iFirstIndex = iSecondIndex + 1;
			sTempValue = sTempValue.substring( iFirstIndex, sTempValue.length );	// The right section of value
			iSecondIndex = sTempValue.indexOf( '.' );
			//document.write( "sTempValue=" + sTempValue + "<br>" );
			sTemp = sTempValue.substring( 0, iSecondIndex );
			//document.write( "sTemp=" + sTemp + "<br>" );
			if( isNameCharacter( sTemp ) == false )
			{
				return false;
			}
		}

		if( isNameCharacter( sTempValue ) == false )
		{
			return false;
		}
	}

	return true;
}

// ����Ƿ����ʱ�
// sValue������ֵ���Ϸ���ʽΪ��λ����
function isZIP( sValue )
{
	if( sValue == null )
	{
		return false;
	}

	if( sValue.length != 6 )
	{
		return false;
	}
	else
	{
		for( i = 0; i < 6; i ++ )
		{
			if( isDigital( sValue.charAt( i ) ) == false )
			{
				return false;
			}
		}
	}

	return true;
}

// ����Ƿ��������ַ���
// sValue������ֵ
function isDigitalString( sValue )
{
	if( sValue == null )
	{
		return false;
	}

	for( i = 0; i < sValue.length; i ++ )
	{
		if( isDigital( sValue.charAt( i ) ) == false )
		{
			return false;
		}
	}
}


//IsEmpty�����ж�һ���ַ����Ƿ�Ϊ��
function IsEmpty(his)
{
   flag = true;
   for(var i=0;i<his.length;i++)
   {
      if(his.charAt(i)!=" ")
      {
         flag = false;
         break;
      }
   }
   return flag;
}
//Trim����ȥ��һ�ַ������ߵĿո�
function Trim(his)
{
   //�ҵ��ַ�����ʼλ��
   Pos_Start = -1;
   for(var i=0;i<his.length;i++)
   {
     if(his.charAt(i)!=" ")
      {
         Pos_Start = i;
         break;
      }
   }
   //�ҵ��ַ�������λ��
   Pos_End = -1;
   for(var i=his.length-1;i>=0;i--)
   {
     if(his.charAt(i)!=" ")
      {
         Pos_End = i;
         break;
      }
   }
   //���ص��ַ���
   Str_Return = ""
   if(Pos_Start!=-1 && Pos_End!=-1)
   {
		for(var i=Pos_Start;i<=Pos_End;i++)
		{
			   Str_Return = Str_Return + his.charAt(i);
		}
   }
   return Str_Return;
}
//IsDigital�����ж�һ���ַ����Ƿ�������(int or long)���
function isDigital(str)
{
  for(ilen=0;ilen<str.length;ilen++)
  {
    if(str.charAt(ilen) < '0' || str.charAt(ilen) > '9' )
    {
       return false;
    }
  }
  return true;
}
//IsFloat�����ж�һ���ַ����Ƿ�������(int or long or float)���
function IsFloat(str)
{
  flag_Dec = 0
  for(ilen=0;ilen<str.length;ilen++)
  {
    if(str.charAt(ilen) == '.')
    {
       flag_Dec++;
	   if(flag_Dec > 1)
          return false;
       else
          continue;
    }
    if(str.charAt(ilen) == '-')
    {
	   if(ilen == 0)
	      continue;
	   else
	   	  return false;
    }
    if(str.charAt(ilen) < '0' || str.charAt(ilen) > '9' )
    {
       return false;
    }
  }
  return true;
}
//IsTelephone�����ж�һ���ַ����Ƿ������ֻ�'-','*','()'���
function IsTelephone(str)
{
  for(ilen=0;ilen<str.length;ilen++)
  {
    if(str.charAt(ilen) < '0' || str.charAt(ilen) > '9' )
    {
		if((str.charAt(ilen)!='-')&&(str.charAt(ilen)!='*')&&(str.charAt(ilen)!=';')&&(str.charAt(ilen)!='(')&&(str.charAt(ilen)!=')'))
        return false;
    }
  }
  return true;
}
//���ڸ�ʽת��2/18/2000 ----2000-2-18
	function dateTransfer(strdate)
	{

		var pos1,pos2,end;
		var para1,para2,para3;
		var newdate;
		newdate="";
		//para1:��
		//para2:��
		//para3:��
		if(Trim(strdate)=="")
		{
			return(newdate);
		}
		end=strdate.length;
		pos1=strdate.indexOf("/",0);
		pos2=strdate.indexOf("/",pos1+1);
		para1=strdate.substring(0,pos1);
		para2=strdate.substring(pos1+1,pos2);
		para3=strdate.substring(pos2+1,end);
		newdate=para3+"-"+para1+"-"+para2;
		return(newdate);
	}
//ת������2000-10-20 ---->10/20/2000
function transferDate(str)
{
  var m=4;
  var strlen=str.length
  var n=strlen-1;
  if(Trim(str)=="")
  {
		return(str);
  }
  while (n>=strlen-2)
  {
   if(str.charAt(n)=="-")
    {
      break;
    }
   n=n-1
  }
  trimstr=str.substring(m+1,n)+"/"+ str.substring(n+1,strlen)+"/"+str.substring(0,m)
  return(trimstr);
}

//����Ƿ�������
function ispassword( sValue )
{
	if( sValue == null )
	{
		return false;
	}

	for( i = 0; i < sValue.length; i ++ )
	{
		var cCharacter = sValue.charAt( i );
		if( isDigital( cCharacter ) == false && isCharacter( cCharacter ) == false && isOtherNameCharacter( cCharacter ) == false)
		{
			return false;
		}
	}

	return true;
}

//�ж��Ƿ�Ϊ����ĺ���
//����˵����Year--���
//          ����ֵ:��������꣬����true�����򷵻�false.

function isLeapYear (Year) {
if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0)) {
return (true);
} else { return (false); }
}

//ȡ��ÿ�������ĺ���
//����˵����month--��;year--��
//          ����ֵ��days--����
function getDaysInMonth(month,year)  {
var days;
if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)  days=31;
else if (month==4 || month==6 || month==9 || month==11) days=30;
else if (month==2)  {
if (isLeapYear(year)) { days=29; }
else { days=28; }
}
return (days);
}




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



		//ʱ��Ƚϴ�С�������ȷ���0�����ڷ���1��С�ڷ���2
		function compareTime(str1,str2){
		  var phour1;
		  var pmin1;
		  var psec1;

		  var phour2;
		  var pmin2;
		  var psec2;

		  phour1=parseFloat(str1.value.substring(2,0));//Сʱ
		  pmin1=parseFloat(str1.value.substring(5,3));//����
		  psec1=parseFloat(str1.value.substring(8,6));//��


		  phour2=parseFloat(str2.value.substring(2,0));//Сʱ
		  pmin2=parseFloat(str2.value.substring(5,3));//����
		  psec2=parseFloat(str2.value.substring(8,6));//��

		  if(phour1==phour2)
		  {
		    if(pmin1==pmin2)
			{
			  if(psec1==psec2)
			  {
			    return(0);
			  }
			  else
			  {
			    if(psec1>psec2)
				{
			      return(1);
                }
				else
				{
				  return(2);
				};
			  };
			}
			else
			{
			  if(pmin1>pmin2)
			  {
			    return(1);
			  }
			  else
			  {
			    return(2);
			  };
			};
		  }
		  else
		  {
		    if(phour1>phour2)
			{
			  return(1);
			}
			else
			{
			  return(2);
			};
		  };
		}
//ѡ��select��ѡ����
function selectItem(formItem,itemValue)
{
	n = parseFloat(formItem.length);
	for(i=0;i<n;i++){
		if(formItem.options[i].value == itemValue){
			formItem.options[i].selected = true;
			formItem.options[i].defaultSelected = true;
		}
	}
}
//ѡ��radio��ѡ��
function radioItem(formItem,itemValue)
{
	n = parseFloat(formItem.length);
	for(i=0;i<n;i++){
		if(formItem[i].value == itemValue){
			formItem[i].checked = true;
		}
	}
}
//formid��ʾ:���form�ǵڼ���form����form���� from��ʾ:������ѡ����Ŀ��select��������
//to��ʾ:�г���ѡ����Ŀ��select�������� limit��ʾ:����ѡ��ֵ,NotremoveFrom�Ƿ�ɾ��from��
//��ֵ,NotAddTo����ֵ�ӵ�to��
//��ѡ��Ԫ�ص�textname��������
function copyToList(formid,from,to,limit,NotRemoveFrom,NotAddTo)
{

	fromList = eval('document.forms[' + formid + '].' + from);
	toList = eval('document.forms[' + formid + '].' + to);
//	if(toList.options.length > 0 && toList.options[0].value == '0')
//	{
//		toList.options.length = 0;
//	}
	var sel = false;
	for (i=0;i<fromList.options.length;i++)
	{
		var current = fromList.options[i];
		if(current.selected)
		{
			sel = true;
			if(current.value == '0' || current.value == limit)
			{
				alert (current.text+"����ѡ��");
//				return;
			}
			else
			{
				txt = current.text;
				val = current.value;
        addFlag = true;
        for(m=0;m<toList.options.length;m++)
        {
          if(txt == toList.options[m].text)
          {
            addFlag = false;
            break;
          }
        }
        if(addFlag)
  				if(!NotAddTo) toList.options[toList.length] = new Option(txt,val);
  				if(!NotRemoveFrom){
  					fromList.options[i] = null;
					i--;
				}
			}
		}
	}
	if(!sel) alert ('��ѡ�����Ԫ�أ�');
}
//formid��ʾ:form���ƻ�˳�� from��ʾ:��ҪɾԪ�صĶ���
//to��ʾ:ɾ������Ļ���վ limit��ʾ:ɾ��Ԫ��value���������
function deleteFromList(formid,from,to,limit)
{
	fromList = eval('document.forms[' + formid + '].' + from);
	toList = eval('document.forms[' + formid + '].' + to);
	for (i=0;i<fromList.options.length;i++)
	{
		if(fromList.options[i].value == limit){
			var current = fromList.options[i];
			sel = true;
			txt = current.text;
			val = current.value;
			toList.options[toList.length] = new Option(txt,val);
			fromList.options[i] = null;
			i--;
		}
	}
}
//���ǵ��û������ύ��ťʱ�����г�ѡ���select����ִ��ȫѡ�������õݽ����ĺ�̨������ȡ���������
//formid��ʾ:form����; item��ʾ:selectԪ������; pro��ʾ:���ص��ַ���ֵ����Դvalue��text;
function allSelect(formid,item,pro,sign)
{
	List = eval('document.forms[' + formid + '].' + item);
	str = "";
//	if (List.length && List.options[0].value == '0') return;
	for (i=0;i<List.length;i++)
	{
		if(List.options[i].value!=0)
		{
			List.options[i].selected = true;
			str += sign + eval('List.options[i].' + pro) + sign + ',';
		}
		else
		{
			List.options[i].selected = false;
		}
	}
	if(str.length > 0)
		str = str.substring(0,str.length-1);
	return str;
}
//ѡ������ѡ�е�Ԫ��
function allSelected(formid,item,pro,sign)
{
	List = eval('document.forms[' + formid + '].' + item);
	str = "";
	for (i=0;i<List.length;i++)
	{
		if(List.options[i].value != 0 & List.options[i].selected)
		{
			List.options[i].selected = true;
			str += sign + eval('List.options[i].' + pro) + sign + ',';
		}
		else
		{
			List.options[i].selected = false;
		}
	}
	if(str.length > 0)
		str = str.substring(0,str.length-1);
	return str;
}
//for layers found object
function findObj(n, d) { //v3.0
	var p,i,x;
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length){
		d=parent.frames[n.substring(p+1)].document;
		n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all) x=d.all[n];
	for(i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	return x;
}
//hide or show layers
function showHideLayers() { //v3.0
	var i,p,v,obj,args=showHideLayers.arguments;
	for (i=0; i<(args.length-2); i+=3){
		if((obj=findObj(args[i]))!=null){
			v=args[i+2];
			if (obj.style) {
				obj=obj.style;
				v=(v=='show')?'visible':(v='hide')?'hidden':v;
			}
		obj.visibility=v;
		}
	}
}
//send value from child windows to parent windows without reload
//parentform��ʾ:form���� par1��ʾ:parentҪ��ֵ��form��������
//childform��ʾ:form����  par2��ʾ:child�ṩֵ��form��������
//function childToParent(parentform,par1,childform,par2){
//	var parentitem = "window.opener.document." + parentform + "." + par1;
//	var childitem = eval("window.document." + childform + "." + par2);
//	eval(parentitem) = eval(childitem);
//	alert(eval(parentitem));
//}
function datecheck(dates){
//alert(dates)
    ymd1=dates.value.split("-");
    month1=ymd1[1]-1
    var Date1 = new Date(ymd1[0],month1,ymd1[2]);
if (Date1.getMonth()+1!=ymd1[1]||Date1.getDate()!=ymd1[2]||Date1.getFullYear()!=ymd1[0]||ymd1[0].length!=4){
  //  alert(Date1);
       alert("�Ƿ�����,������YYYY-MM-DD����ʽ����");
       return false;
    }
return true;
}
//length:С��λ��
function checkDiscount(obj,length,msg)
{
	var val=obj.value;
	var par=parseFloat(val);
	var len=0;
	if(val.indexOf(".")!=-1)
		len=parseInt(val.length)-parseInt(val.indexOf("."))-1;
	if(par==val&par<=1&len<=length)
	{
		return true;
	}
	else
	{
		alert(msg);
		obj.focus();
		return false;
	}
}
function checkFluctuate(obj,length,msg)
{
	var val=obj.value;
	var par=parseFloat(val);
	var len=0;
	if(val.indexOf(".")!=-1)
		len=parseInt(val.length)-parseInt(val.indexOf("."))-1;
	if(par==val&par<=8.9&len<=length)
	{
		return true;
	}
	else
	{
		alert(msg);
		obj.focus();
		return false;
	}
}
function checkHour(obj,msg)
{
	var val=obj.value;
	var par=parseInt(val);
	if(par==val&par<=24)
	{
		return true;
	}
	else
	{
		alert(msg);
		obj.focus();
		return false;
	}
}
function checkMinute(obj,msg)
{
	var val=obj.value;
	var par=parseInt(val);
	if(par==val&par<60)
	{
		return true;
	}
	else
	{
		alert(msg);
		obj.focus();
		return false;
	}
}
function checkURL(obj,msg)
{
	var val=obj.value;
	if(parseInt(val.length) > 7)
	{
		sub=val.substring(0,7);
		if(sub=="http://" & val.indexOf(".")!=-1)
		{
			return true;
		}
		else
		{
			alert(msg);
			obj.focus();
			return false;
		}
	}
	else
	{
		alert(msg);
		obj.focus();
		return false;
	}
}
//����ѡ�б���е�Ԫ�ؽ�������,formidΪҳ���е�id����,movenameΪ�б��������ַ���
function upmove(formid,movename)
{
 movelist = eval('document.forms[' + formid + '].' + movename);
 var sel = false;
	for (i=0;i<movelist.options.length;i++)
	{
		var current = movelist.options[i];
		if(current.selected)
		{
		sel = true;
		if(i==1 || movelist.options[i].value=="0")
		{
			alert ('���������ƶ���');
			return;
		}
		txt = current.text;
		val = current.value;
		uptxt=movelist.options[i-1].text;
		upval=movelist.options[i-1].value;
		movelist.options[i-1].value = val;
		movelist.options[i-1].text=txt;
		movelist.options[i].value=upval;
		movelist.options[i].text=uptxt;
		movelist.options[i-1].selected=true;
		movelist.options[i].selected=false;

		}
	}
	if(!sel) alert ('��ѡ��Ҫ�ƶ���Ԫ�أ�');
}
//����ѡ�б���е�Ԫ�ؽ�������,formidΪҳ���е�id����,movenameΪ�б��������ַ���
function downmove(formid,movename)
{
 movelist = eval('document.forms[' + formid + '].' + movename);
 var sel = false;
	for (i=(movelist.options.length-1);i>=0;i--)
	{
		var current = movelist.options[i];
		if(current.selected)
		{
		sel = true;
		if(i==(movelist.options.length-1) || movelist.options[i].value=="0")
		{
			alert ('���������ƶ���');
			return;
		}
		txt = current.text;
		val = current.value;
		downtxt=movelist.options[i+1].text;
		downval=movelist.options[i+1].value;
		movelist.options[i+1].value = val;
		movelist.options[i+1].text=txt;
		movelist.options[i].value=downval;
		movelist.options[i].text=downtxt;
		movelist.options[i+1].selected=true;
		movelist.options[i].selected=false;
		}
	}
	if(!sel) alert ('��ѡ��Ҫ�ƶ���Ԫ�أ�');
}

//���ҳ������Ӣ�Ļ���ַ�����ʵ�ʳ��ȣ�strΪ�ַ�����ֵ
function getLength(str)
{
	l=str.length
	all=0;
	for(i=0;i<l;i++){
	  aim=str.charAt(i);
	  aim=escape(aim);
	  if ((aim.length==3)||(aim.length==1)){
	   all=all+1;
	  }
	  if (aim.length==6){
	   all=all+2;
	  }
	}
	return all
} 
/**
 * lizb ��鵥ѡ���Ƿ�ѡ��
 */
function IsRadioChecked(field,msg){
	var l;
	try{
		l = field.length;
	}catch(e){
		outputOtherMsg(msg);
		return false
	}
	if(l==undefined){
		if(!field.checked){
			outputOtherMsg(msg);
			return false
		}else{
			return true
		}
	}else{
		flag=0;
		for(i=0;i<l;i++){
			if(field[i].checked==true){
				flag++;
			}
		}
		if(flag==0){
			outputOtherMsg(msg);
			return false
		}else{
			return true
		}
	}
}
/**
 * wangsu ���һ����ѡ���Ƿ�ѡ��
 */
function IsOneRadioChecked(field,msg){
	var l;
	try{
		l = field.length;
	}catch(e){
		outputOtherMsg(msg);
		return false
	}
	if(l==undefined){
		if(!field.checked){
			outputOtherMsg(msg);
			return false
		}else{
			return true
		}
	}else{
		flag=0;
		for(i=0;i<l;i++){
			if(field[i].checked==true){
				flag++;
			}
		}
		if(flag==0){
			outputOtherMsg(msg);
			return false
		}else if(flag!=1){
			outputOtherMsg("��ѡ��һ��Ŀ���б༭");
			return false
		}else{
			return true
		}
		
	}
}
/**
 * wangsu ���ڼ���ѡ��
 */
function IsWhichChecked(field){
	var l;
	try{
		l = field.length;
	}catch(e){
		return false
	}
	if(l==undefined){
		if(!field.checked){
			return false
		}else{
			return 0;
		}
	}else{
		flag=0;
		for(i=0;i<l;i++){
			if(field[i].checked==true){
				flag=i;
			}
		}
		return flag;
		
	}
}

/**
 * �õ�ʱ��lizb
 * @param ctrlobj Ҫ����ʱ������������
 * @param contextPath ��Ŀ·��
 * @return �����ַ���
 */
function getDateValue(ctrlobj,contextPath){
	showx = event.screenX - event.offsetX +4 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;
	retval = window.showModalDialog(contextPath + "/include/date.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	if( retval != null ){
		ctrlobj.value = retval;
		return retval;
	}
}
/**
 * ȫѡ/��ѡ lizb
 */
function selectAll(checkname,selectobj) {
	try{
		var els = document.getElementsByName(checkname);
	
		if (selectobj==null){
			var checked = true;
			for (var i = 0; i < els.length; i++) {
				if (els[i].checked) {
					checked = false;
				}
			}
			if (checked){
				for (var i = 0; i < els.length; i++) {
					els[i].checked = false;
				}
			}else{
				for (var i = 0; i < els.length; i++) {
					els[i].checked = true;
				}
			}
		}else{
			if (selectobj.checked){
				for (var i = 0; i < els.length; i++) {
					els[i].checked = true;
				}
			}else{
				for (var i = 0; i < els.length; i++) {
					els[i].checked = false;
				}
			}
		}
	}catch(e){
	}
}
function checkMe(selName,checkobj){
	var isNotChecked = false;
	var selElements = document.getElementsByName(checkobj.name);
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (!selElements[i].checked) {
					isNotChecked = true;
				}
			}
		}
	}
	
	//ȫѡ
	try{
		if (!isNotChecked){
			document.getElementsByName(selName)[0].checked = true;
		}else{
			document.getElementsByName(selName)[0].checked = false;
		}
	}catch(e){}
}
/**
 * �ж��û��Ƿ���ҳ����ѡ��ָ�����Ƶĸ�(��)ѡ��
 * @param name checkbox����radio��name
 * @return ��ѡ�񷵻�true,���򷵻�false
 */
function hasSelected(name) {
	var selElements = document.getElementsByName(name);
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].checked) {
					return true;
				}
			}
		}
	}
	return false;
}

/**
 * �ж��û��Ƿ���ҳ����ѡ����һ���ҽ���һ��ָ�����Ƶĸ�(��)ѡ��
 * @param name checkbox����radio��name
 * @return ����ֻ��һ��ѡ�񷵻�true,���򷵻�false
 */
function hasSelectedOne(name) {
	var selElements = document.getElementsByName(name);
	var selected = false;
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].checked) {
					if (selected == false) {
						selected = true;
					}
					else {
						return false;
					}
				}
			}
		}
	}
	return selected;
}
//������˫����д������Ϣ�Ĵ���
function showDesc(objName,readonly){
	var cObj = null;
	try{
		cObj = event.srcElement;
	}catch(e){}
    var x=0,y=0;
	if (cObj != null){
		var tempObj = cObj.parentElement;
		var tx = tempObj.offsetLeft;
		var ty = tempObj.offsetTop;
		var tcx = tempObj.offsetWidth;
		
		x+=tx;
		x += (tcx/2);
		y+=ty;
		x = x-120;
		var hMax = document.body.scrollHeight;
		
		var max = document.body.scrollWidth;
		if (x>(max-258)){
			x = max - 258;
		}
		if (x<0){
			x = 0;
		}
		if (y>(hMax-256)){
			y = hMax-256;
		}
		if (y<0){
			y = 0;
		}
	}
		var desc = document.getElementById("descDiv");
		if (desc == null){
			loadWin();
			desc = document.getElementById("descDiv");
		}else{
			var oName = document.all("descName").value;
			if (oName != "" && !(readonly!=null && readonly)){
				document.all(oName).value = document.all("desc").value;
			}
		}
		
		desc.style.left = x;
		desc.style.top = y + 120;
		desc.style.display = "";
		document.all("desc").value = document.all(objName).value;
		document.all("descName").value = objName;
		if (readonly!=null && readonly){
			document.all("desc").readOnly = true;
			document.getElementById("edit_button").style.display = "none";
			document.getElementById("view_button").style.display = "";
		}else{
			document.all("desc").focus();
		}
}
function loadWin(){
	var str = "<div id=\"descDiv\" style=\"position: absolute; width: 258px; height: 135px;left: 0px; top: 0px; border: 1px solid #000000; background-color: #FFFFE6; display:none\" >\n	<table border=\"0\" height=\"100%\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#FFFFEE\" >\n		<tr>\n			<td height=\"100%\" valign=\"top\">\n			<input type=\"hidden\" name=\"descName\">\n			<textarea name=\"desc\" class=\"desc\"></textarea></td>\n		</tr>\n		<tr>\n			<td align=\"center\">\n			<div id = \"view_button\" style=\"display:none\"><a href=\"javascript:_cancelDesc()\">�ر�</a></div><div id = \"edit_button\"><a href=\"javascript:_okDesc()\">ȷ��</a>&nbsp;&nbsp; <a href=\"javascript:_cancelDesc()\">ȡ��</a></div></td>\n		</tr>\n	</table>\n</div>";
	document.body.innerHTML +=str;
}
function _setDesc(objName,readonly){
	showDesc(objName,readonly);
}
function _okDesc(){
	document.all(document.all("descName").value).value = document.all("desc").value;
	_cancelDesc();
}
function _cancelDesc(){
	document.all("descDiv").style.display = "none";
	document.all("desc").value = "";
	document.all("descName").value = "";
}