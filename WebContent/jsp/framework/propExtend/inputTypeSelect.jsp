<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true" isAjax="true"/>
	<script>
	function changeButton(obj,flag){
		parent.document.getElementById('INPUT_TYPE').value=obj.value;
		if(flag==1){
			document.getElementById("qddiv").style.display="";
			document.getElementById("xybdiv").style.display='none';
		}
		else{
			document.getElementById('xybdiv').style.display = "";
			document.getElementById('qddiv').style.display = 'none';
		}
	}
	function checkCode(){
		var flag = false;
		var ajax_url = "com.hx.framework.propExtend.CheckPropCodeAjax";
		var propCode = parent.document.getElementById('PROP_CODE').value;
		var str=getStr(ajax_url,"propCode="+propCode);
		if(str=='ok'){
			flag = true ;
		}
		return flag;
	}
	function tijiao()
	{
		if (!runFormVerify(parent.srcForm, false)) {
			return;
		}
		if(!checkCode()){
			alert("[���Դ���]�Ѵ��ڣ����������룡");
			return ;
		}
		parent.srcForm.action=path+"prop/propExtend!saveProp.action";
		parent.srcForm.submit();
	}
	function getInputType(){
		var inputTypes = document.getElementsByName("INPUT_TYPE");
		var val='';
		for(var i=0;i<inputTypes.length;i++){
			if(inputTypes[i].checked){
				val=inputTypes[i].value;
				break;
			}
		}
		return val;
	}
	/*��һ����*/
	function next(){
			if (!runFormVerify(parent.srcForm, false)) {
				return;
			}
			if(!checkCode()){
				alert("[���Դ���]�Ѵ��ڣ����������룡");
				return ;
			}
			document.srcForm.action=path+"prop/propExtend!gotoInputTypeNext.action";
			document.srcForm.submit();
	}
	function _back(){
		parent.srcForm.action=path+"prop/propExtend!gotoMainPage.action";
		parent.srcForm.submit();
	}
	function preview(){
		if (!runFormVerify(parent.srcForm, false)) {
			return;
		}
		var propName = parent.document.getElementById("PROP_NAME").value;
		var inputType = parent.document.getElementById('INPUT_TYPE').value;
		var param = propName+"&"+inputType;
		
		var url = "<BZ:url/>/jsp/framework/propExtend/preview.jsp";
		var dialogWidth="400";
		var dialogHeight="200";
		modalDialog(url,param,dialogWidth,dialogHeight);
	}
	</script>
	<title>�������</title>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<table border="0" width="100%" class="contenttable" align="center">
			<tr><td colspan="2" align="left"><div class="heading">ѡ������</div></td></tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="text" onclick="changeButton(this,1)"/>�ı������ <span>(�ʺ����������ı�)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="textarea" onclick="changeButton(this,1)"/>�ı���  <span>(����������ı�������,���������ݽ϶���ı�)</span></td></tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="radio" onclick="changeButton(this,2)"/>��ѡ��ť <span>(��ѡ��ť ʹ�õ�ѡ��ťѡ��һ��ֵ)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="checkbox" onclick="changeButton(this,2)"/>��ѡ��ť <span>(ʹ�ø�ѡ��ťѡ����ֵ)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="selectSingle" onclick="changeButton(this,2)"/>��ѡ�б� <span>(ʹ�õ�ѡ�����б�,ѡ��һ��ֵ)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="selectMulti" onclick="changeButton(this,2)"/>��ѡ�б� <span>(ʹ�ö�ѡ�б��ѡ����ֵ,Ĭ��ֵΪ3)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="personTree" onclick="changeButton(this,1)"/>��Աѡ�� <span>(ʹ��Framework��Աѡ��ؼ�,����һ����Ա)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="organTree" onclick="changeButton(this,1)"/>��֯ѡ�� <span>(ʹ��Framework��֯ѡ��ؼ�,����һ����֯)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="dateWidget" onclick="changeButton(this,1)"/>����ѡ�� <span>(ʹ������ѡ��ؼ���������)</span></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">
					<div id="qddiv" style="display: none">
						<input id="yl" type="button" class="button_preview" value="Ԥ��" onclick="preview()"/>
						<input id="qd" type="button" class="button_add" value="����" onclick="tijiao()"/>
					</div>
					<div id="xybdiv" style="display: none">
						<input id="xyb" type="button" class="button_goto" value="��һ��" onclick="next()"/>
					</div>
				</td>
				<td align="left">
					<input type="button" class="button_back" onclick="_back();" value="����"/>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>