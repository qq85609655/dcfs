//�ж��Ƿ��Ѿ������һҳ�ı�־,0��ʾ��δ�������һҳ��1��ʾ�Ѿ��������һҳ
var pageBool = '0';

//��ǰ��ҳ
function previousPage(formAction, curPageNum ){
	toPage(formAction,  curPageNum );
}

//��ǰ��ҳ
function nextPage(formAction,  curPageNum  ){
	//����Ѿ��������һҳ�ˣ�����ִ�С�
	if(pageBool=='1'){
		return false;
	}
	toPage(formAction,  curPageNum);
}

//��ת���ڼ�ҳ
function toPage(formAction,  curPageNum ){
	if( !checkPage() ){
		return;
	}
	document.all.curPageNum.value=curPageNum;
	if(formAction!=""){
		document.forms[0].action=formAction;
	}
	document.forms[0].submit();
}
//�Է�ҳ��ѯ��������У�飬��Ҫ����ʵ�������д��Ĭ�Ϻ㷵��true
function checkPage(){
	return true;
}
//���б�ȫ
function initList( perPageSize ){
	var rowLength = listTable.rows.length-1;
	if( rowLength<=perPageSize*1 ){
		document.all.nextpage.disabled="true";
		document.all.endpage.disabled="true";
		//����Ҫ��ȫ�б�������Ѿ��������һҳ�ˡ�
		pageBool='1';
		for( var i=0 ; i<perPageSize*1-rowLength+1 ; i++ ){
			var rowObj = listTable.insertRow();
			rowObj.className="listdata";
			for( var j=0 ; j<listTable.rows[ 0 ].cells.length ; j++ ){
				var cellObj=rowObj.insertCell();
			}
		}
	}
	<!--��$per_Page_Size+1����¼��������ʾ-->
	var rowObj=listTable.rows;
	if(rowObj.length==12){
		rowObj[11].style.display="none";
	}
}

/**
 * ����ģʽ����
 * @param url ��ַ
 * @param obj ����
 * @param dialogWidth IE7���
 * @param dialogHeight IE7�߶�
 * @return ���ؽ��
 */
function modalDialog(url,obj,dialogWidth,dialogHeight){
	dialogWidth=ieX(dialogWidth);
	dialogHeight=ieY(dialogHeight);
	return window.showModalDialog(url,obj,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
}
/**
 * �������ڹ���
 * @param url �������ڵ�url
 * @param name �������ڵ�����
 * @return ���ص�ǰ������汾����Ҫ�Ŀ��
 */
function openWin(url,name,iWidth,iHeight){
	var url;
	var name;
    if (iWidth==null){
		iWidth=400;
	}
	if (iHeight==null){
		iHeight=300;
	}
	_open(url,name,iWidth,iHeight);
}

/*
alwaysLowered | yes/no | ָ���������������д���֮�� 
alwaysRaised | yes/no | ָ���������������д���֮�� 
depended | yes/no | �Ƿ�͸�����ͬʱ�ر� 
directories | yes/no | Nav2��3��Ŀ¼���Ƿ�ɼ� 
height | pixel value | ���ڸ߶� 
hotkeys | yes/no | ��û�˵����Ĵ������谲ȫ�˳��ȼ� 
innerHeight | pixel value | �������ĵ������ظ߶� 
innerWidth | pixel value | �������ĵ������ؿ�� 
location | yes/no | λ�����Ƿ�ɼ� 
menubar | yes/no | �˵����Ƿ�ɼ� 
outerHeight | pixel value | �趨����(����װ�α߿�)�����ظ߶� 
outerWidth | pixel value | �趨����(����װ�α߿�)�����ؿ�� 
resizable | yes/no | ���ڴ�С�Ƿ�ɵ��� 
screenX | pixel value | ���ھ���Ļ��߽�����س��� 
screenY | pixel value | ���ھ���Ļ�ϱ߽�����س��� 
scrollbars | yes/no | �����Ƿ���й����� 
titlebar | yes/no | ������Ŀ���Ƿ�ɼ� 
toolbar | yes/no | ���ڹ������Ƿ�ɼ� 
Width | pixel value | ���ڵ����ؿ�� 
z-look | yes/no | ���ڱ�������Ƿ�����������֮��
*/
function _open(url,name,iWidth,iHeight,iLeft,iTop){
  var url;                                 //ת����ҳ�ĵ�ַ;
  var name;                           //��ҳ���ƣ���Ϊ��;
  iWidth = ieX(iWidth);                          //�������ڵĿ��;
  iHeight = ieY(iHeight);                     //�������ڵĸ߶�;
  if (iTop==null)
  iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
  if (iLeft==null)
  iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
 }
/**
 * ���������ڵĿ��
 * @param n IE7���
 * @return ���ص�ǰ������汾����Ҫ�Ŀ��
 */
function ieX(n){
	/**if (ieVer<7){
		n = n+10
	}
	if (n<0){
		n=0;
	}**/
	return n;
}
/**
 * ���������ڵĸ߶�
 * @param n IE7�߶�
 * @return ���ص�ǰ������汾����Ҫ�ĸ߶�
 */
function ieY(n){
	/**if (ieVer<7){
		n = n+10
	}
	if (n<0){
		n=0;
	}**/
	return n;
}