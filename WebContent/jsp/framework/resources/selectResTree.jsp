
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��Դ��</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	var hasChild=true;
	var reValue = new Array();;
	var flag=false;
	function L(id,isSelNode,node,tree){
	    reValue = new Array();
		if(isSelNode || !tree.currentNode.hasChild){
			//�ж��Ƿ���Ҫ��ʾ�ϼ�������
			var show_parent = document.getElementsByName("showParent");
			var showName ="";
			if (show_parent!=null && show_parent.length>0){
				show_parent=show_parent[0];
				if (show_parent!=null){
					var showP = show_parent.value;
					alert(showP);
					if (showP.toUpperCase()=="TRUE"){
						showName=_show_all_name(tree.currentNode);
					}
				}
			}
			if (showName==""){
				showName=node.text;
			}
			
		}
		reValue["name"]=showName;
		reValue["value"]=id;
		if(!tree.currentNode.hasChild){
			hasChild=false;	
		}
		document.getElementById("clickFlag").value="true";
		var r=executeRequest("com.hx.framework.resource.resources.ResourceAjax","ID="+id);
		if(r==0){
			flag=false;
		}else{
			flag=true;
		}
	}
	function ok_(){
		if(flag){
			if(confirm("ȷ��ѡ�����Դ��")){
				window.returnValue=reValue;
				window.close();
			}
		}else{
			alert("ѡ��Ľڵ㲻����Դ");	
		}
	}
	function reset_(){		
		window.returnValue={'name':'','value':''};
	    window.close();
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="">
		<input type="hidden" id="clickFlag" value="false"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����Դ</div>
		<!-- ��Դ�� -->
		<table width="100%">
			<tr>
				<td align="right" style="padding-right:0px">
				    <input type="button" value="ȷ��" class="button_add" onclick="ok_()"/>
				    <input type="button" value="���" class="button_back" onclick="reset_()"/>
				</td>
			</tr>
			<tr>
				<td><BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" selectvalue="selectValue"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>