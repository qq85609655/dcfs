
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>������</title>
<base target="_self"/>
<BZ:script isList="true" tree="true"/>
<script type="text/javascript">
var requiredType="<%=request.getParameter("type")%>"; //ǰһҳ����ѡ�������[����/��Դ];1 ����

function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	
	if(isSelNode || !tree.currentNode.hasChild){
		//�ж��Ƿ���Ҫ��ʾ�ϼ�������
		var show_parent = document.getElementsByName("showParent");
		var showName ="";
		if (show_parent!=null && show_parent.length>0){
			show_parent=show_parent[0];
			if (show_parent!=null){
				var showP = show_parent.value;
				if (showP.toUpperCase()=="TRUE"){
					showName=_show_all_name(tree.currentNode);
				}
			}
		}
		if (showName==""){
			showName=tree.currentNode.T;
		}
		
	}
	//����
	
	reValue["name"]=showName;
	reValue["value"]=id;
	

	if(("0"==requiredType && id.indexOf("0_")==0)
			||("1"==requiredType && id.indexOf("1_")==0)){
		
		var str="����";
		if("0"==requiredType){
			str="ҳ�� ";
		}
		
		if(confirm('ȷ��ѡ���'+str+'��?')){
			reValue["name"]=showName;
			reValue["value"]=id;
			if(id.length>2){
				reValue["value"]=id.substring(2,id.length);//////////////////////////////ȥ��ǰ׺ 
			}
			window.returnValue = reValue;
			window.close();
		}
		return;
	}
	
}

function L2(id,selNode){
	//alert("clicked");
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	
	//isSelNode=true;
	//alert(isSelNode);
	if(isSelNode || !tree.currentNode.hasChild){
		//�ж��Ƿ���Ҫ��ʾ�ϼ�������
		var show_parent = document.getElementsByName("showParent");
		var showName ="";
		if (show_parent!=null && show_parent.length>0){
			show_parent=show_parent[0];
			if (show_parent!=null){
				var showP = show_parent.value;
				if (showP.toUpperCase()=="TRUE"){
					showName=_show_all_name(tree.currentNode);
				}
			}
		}
		if (showName==""){
			showName=tree.currentNode.T;
		}
		if("0"==requiredType && id.indexOf("1$")==0){
			alert("��ѡ��ҳ�棡");
			return;
		}
		reValue["name"]=showName;
		reValue["value"]=id;
	}
	//����
	//if(confirm('ȷ��ѡ����֯������?')){
	//	window.returnValue = reValue;
	//	window.close();
	//}else{
	//  return;
	//}
}

function confirmSelect_(){
	
	//if(_sel()){
	if(isSelNode){
		
		alert(reValue["value"]);
		alert(reValue["name"]);
		if("0"==requiredType && reValue["value"].indexOf("1_")==0){
			alert("��ѡ��ҳ�棡");
			return;
		}
	    window.returnValue=reValue ;//|| {name:"",value:""}
		window.close();
	}else{
		if(requiredType==1){
			alert("��ѡ��һ������");
		}else{
			alert("��ѡ��һ��ҳ��");
		}
	}
}
function indexOf(str,chr) {
	for(var i=0;i<str.length;i++){
        if(str.charCodeAt(i)==chr) {
	        return true;
        }
   }
   return false;
}


function closeWin_(){    
    window.returnValue=null;
	window.close();
}

function reset_(){		
	window.returnValue={name:"",value:""};
    window.close();
}
</script>
</BZ:head>
<BZ:body codeNames="codeList" >
	   <div class="kuangjia">
			<div class="list">
				<!-- ��֯�������� -->
				<div class="heading">ѡ��ҳ�����</div>
				<table>
					<tr>
						<td>
						<% if("1".equals(request.getParameter("type"))){%>
							<BZ:tree property="codeList" type="0" iconPath="/images/tree_org/"/>
						<%}else{ %>
							<BZ:tree property="codeList" type="0"  />
						<%} %>
						
						</td>
					</tr>
				</table>
			</div>
	   </div>	
</BZ:body>
</BZ:html>