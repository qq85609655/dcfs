opCard = function()
{
	this.bind = new Array();
	this.index = 0;		//Ĭ����ʾ�ĸ�ѡ�����0��ʼ
	
	this.style = new Array();		//["","",""]
	this.overStyle = false;		//ѡ���Ƿ���over, out�任��ʽ�¼�����ʽΪthis.style[2]
	this.overChange = false;		//�����Ƿ���over, outֱ�Ӽ���
	this.menu = false;				//�˵�����
	this.nesting = [false,false,"",""];		//�Ƿ�Ƕ�ף�����2��������ָ��menu,info���Ӽ��������id
	
	this.auto = [false, 1000];		//�Զ�����[true,2000]
	this.timerID = null;			//�Զ����ŵ�
	this.menutimerID = null;		//�˵���ʱ��
	
	this.creat = function(func)
	{
		var _arrMenu = document.getElementById(this.bind[0]).getElementsByTagName(this.bind[1]);
		var _arrInfo = document.getElementById(this.bind[2]).getElementsByTagName(this.bind[3]);
		var my = this, i;
		var argLen = arguments.length;
		var arrM = new Array();
		
		if(this.nesting[0] || this.nesting[1])	// ��ѡ�Ƕ��
		{	// ���˳���Ҫ������
			var arrMenu = this.nesting[0]?getChilds(_arrMenu,this.bind[0],2):_arrMenu;
			var arrInfo = this.nesting[1]?getChilds(_arrInfo,this.bind[2],3):_arrInfo;
		}
		else
		{
			var arrMenu = _arrMenu;
			var arrInfo = _arrInfo;
		}
		
		var l = arrMenu.length;
		if(l!=arrInfo.length){alert("�˵������ݱ���ӵ����ͬ������\n�����Ҫ������Է�һ���յ�����ռλ��")}
		
		// ����
		if(this.menu){this.auto=false;this.overChange=true;} //����ǲ˵�����û���Զ����У���over, outֱ�Ӽ���
		
		// ѭ����Ӹ����¼���
		for(i=0;i<l;i++)
		{
			arrMenu[i].cName = arrMenu[i].className;
			arrMenu[i].className = (i!=this.index || this.menu)?getClass(arrMenu[i],this.style[0]):getClass(arrMenu[i],this.style[1]);		//������ʽ���˵��Ļ�ͳһ��ʽ
			
			if(arrMenu[i].getAttribute("skip")) // ��Ҫ����������
			{
				if(this.overStyle || this.overChange)	// ��over, out �ı���ʽ ���� ����
				{
					arrMenu[i].onmouseover = function(){changeTitle(this, 2);autoStop(this, 0);}
					arrMenu[i].onmouseout = function(){changeTitle(this, 0);autoStop(this, 1);}
				}
				arrMenu[i].onclick = function(){if(argLen==1){func()}}
				arrInfo[i].style.display = "none";
				continue;
			}
			
			if(i!=this.index || this.menu){arrInfo[i].style.display="none"};	//���س�ʼ�����˵��Ļ�ȫ������
			arrMenu[i].index = i;	//��¼�Լ�����ֵ[���]
			arrInfo[i].index = i;
			
			
			if(this.overChange)	//�����over, out�¼�
			{
				arrMenu[i].onmouseover = function(){changeOption(this);my.menu?changeMenu(1):autoStop(this, 0);}
				arrMenu[i].onmouseout = function(){changeOption(this);my.menu?changeMenu(0):autoStop(this, 1);}
			}
			else	//onclick����
			{
				arrMenu[i].onclick = function(){changeOption(this);autoStop(this, 0);if(argLen==1){func()}}
				if(this.overStyle)	// ��over, out �ı���ʽ
				{
					arrMenu[i].onmouseover = function(){changeTitle(this, 2);autoStop(this, 0);}
					arrMenu[i].onmouseout = function(){changeTitle(this, 0);autoStop(this, 1);}
				}
				else	// û��over, out �ı���ʽ
				{
					if(this.auto[0])	// ���Զ�����
					{
						arrMenu[i].onmouseover = function(){autoStop(this, 0);}
						arrMenu[i].onmouseout = function(){autoStop(this, 1);}
					}
				}
			}
			
			if(this.auto[0] || this.menu)	//arrinfo �����Զ�����
			{
				arrInfo[i].onmouseover = function(){my.menu?changeMenu(1):autoStop(this, 0);}
				arrInfo[i].onmouseout = function(){my.menu?changeMenu(0):autoStop(this, 1);}
			}
		}	//for����
		
		if(this.auto[0])
		{
			this.timerID = setTimeout(autoMove,this.auto[1])
		}
		
		// �Զ�����
		function autoMove()
		{
			var n;
			n = my.index + 1;
			if(n==l){n=0};
			while(arrMenu[n].getAttribute("skip"))		// ��Ҫ����������
			{
				n += 1;
				if(n==l){n=0};
			}
			changeOption(arrMenu[n]);
			my.timerID = setTimeout(autoMove,my.auto[1]);
		}
		
		// onmouseoverʱ���Զ�����ֹͣ��num��0Ϊover��1Ϊout�� obj��ʱ���á� -_-!!
		function autoStop(obj, num)
		{
			if(!my.auto[0]){return;}
			//if(obj.index==my.index)
			num == 0 ? clearTimeout(my.timerID) : my.timerID = setTimeout(autoMove,my.auto[1]);
		}
		
		// �ı�ѡ�
		function changeOption(obj)
		{
			arrMenu[my.index].className = getClass(arrMenu[my.index],my.style[0]);	//�޸ľ�����
			arrInfo[my.index].style.display = "none";	//���ؾ�����
			
			obj.className = getClass(obj,my.style[1]);		//�޸�Ϊ����ʽ
			arrInfo[obj.index].style.display = "";	//��ʾ������
			
			my.index = obj.index;	//���µ�ǰѡ���index
		}
		
		/*		
			ֻ��onclickʱ��overStyle��onmouseover,onmouseout�¼�������Ԥ����
			obj��Ŀ�����	num��1Ϊover��0Ϊout
		*/
		function changeTitle(obj, num)
		{
			if(!my.overStyle){return;};
			if(obj.index!=my.index){obj.className = getClass(obj,my.style[num])}
		}
		
		/*		
			�˵�����ʱ��
			obj��Ŀ�����	num��1Ϊover��0Ϊout
		*/
		function changeMenu(num)
		{
			if(!my.menu){return;}
			num==0?my.menutimerID = setTimeout(menuClose,1000):clearTimeout(my.menutimerID)
		}
		
		//�رղ˵�
		function menuClose()
		{
			arrInfo[my.index].style.display = "none";
			arrMenu[my.index].className = getClass(arrMenu[my.index],my.style[0]);
		}
		
		// �õ�className����ֹ��ԭ����ʽ���ǣ�
		function getClass(o, s)
		{
			if(o.cName==""){return s}
			else{return o.cName + " " + s}
		}
		
		//Ƕ������µõ��������Ӽ�
		function getChilds(arrObj, id, num)
		{
			var depth = 0;
			var firstObj = my.nesting[num]==""?arrObj[0]:document.getElementById(my.nesting[num]);		//�õ���һ���Ӽ�
			do	//�������
			{
				if(firstObj.parentNode.getAttribute("id")==id){break}else{depth+=1}
				firstObj = firstObj.parentNode;
			}
			while(firstObj.tagName.toLowerCase()!="body")	// bodyǿ���˳���
			
			var t;
			var arr = new Array();
			for(i=0;i<arrObj.length;i++)	//���˳���Ҫ������
			{
				t = arrObj[i], d = 0;
				do
				{
					if(t.parentNode.getAttribute("id")==id && d == depth)
					{	
						arr.push(arrObj[i]);break;		//�õ�����
					}
					else
					{
						if(d==depth){break};d+=1;
					}
					t = t.parentNode;
				}
				while(t.tagName.toLowerCase()!="body")	// bodyǿ���˳�
			}
			return arr;
		}
	}
}
