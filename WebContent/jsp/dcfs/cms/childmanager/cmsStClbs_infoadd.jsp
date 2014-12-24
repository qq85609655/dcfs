<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>

<%
  /**   
 * @Description: ��ͯ������ϸ��Ϣ¼��
 * @author wangzheng   
 * @date 2014-9-10
 * @version V1.0   
 */
TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
String path = request.getContextPath();

Data d = (Data)request.getAttribute("data");
String ciId = d.getString("CI_ID","");
String orgId = d.getString("WELFARE_ID","");
String strPar ="org_id="+orgId + ",ci_id=" + ciId;
String strPar1 ="org_id="+orgId + ";ci_id=" + ciId;
String CHILD_TYPE = d.getString("CHILD_TYPE","");
String CHILD_NO = d.getString("CHILD_NO");

String CHILD_IDENTITY = d.getString("CHILD_IDENTITY","");
String packId = "";
String uploadParameter = (String)request.getAttribute("uploadParameter");
//���ݶ�ͯ���ѡ�񸽼�����
ChildCommonManager ccm = new ChildCommonManager();
packId = ccm.getChildPackIdByChildIdentity(CHILD_IDENTITY, CHILD_TYPE, false);
%>

<BZ:html>
	<BZ:head>
		<up:uploadResource isImage="true"/>
		<title>��ͯ������ϸ��Ϣ¼��</title>
        <BZ:webScript edit="true"/>
		<!--���������ϴ���start-->
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<!--���������ϴ���end-->
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>	
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
 
	//����
	function _save(){		
		if (_check(document.srcForm)) {
			if(confirm('ȷ��Ҫ���浱ǰ��д������ô?')){
				if(document.getElementById("P_IS_HOPE").checked)
					document.getElementById("P_IS_HOPE").value = "1";
				if(document.getElementById("P_IS_PLAN").checked)
					document.getElementById("P_IS_PLAN").value = "1";
				document.getElementById("state").value = "0";
				document.srcForm.action=path+"/cms/childManager/save.action";
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//�ύ
	function _submit(){
		if (_check(document.srcForm)) {
			if(confirm('ȷ��Ҫ�ύ��ǰ��д������ô?')){
				if(document.getElementById("P_IS_HOPE").checked)
					document.getElementById("P_IS_HOPE").value = "1";
				if(document.getElementById("P_IS_PLAN").checked)
					document.getElementById("P_IS_PLAN").value = "1";
				document.getElementById("state").value = "1";
				document.srcForm.action=path+"/cms/childManager/save.action";
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//ȡ��
	function _cancle(){
		if(confirm('ȷ��Ҫȡ����ǰ��д������ô?')){
			document.srcForm.action=path+"/cms/childManager/findList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}

	//����˫��̥
	function _setTwins(){
		$.layer({
			type : 2,
			title : "ͬ������",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/cms/childManager/twinslist.action?CHILD_NO=<%=CHILD_NO%>&CI_ID=<%=ciId%>&WELFARE_ID=<%=orgId%>'},
			area: ['800px','400px'],
			offset: ['0px' , '0px']
		});
	
	}

	function getIframeVal(val)  
	{
		//document.getElementById("textareaid").value=urlDecode(val);
		//alert(document.getElementById("frmUpload"));
		//document.getElementById("frmUpload").location.reload();
		if(p=="0"){
			frmUpload.window.location.reload();
		}else{
			frmUpload1.window.location.reload();
		}
	}	
	
	var p = "0";
	//�����ϴ�
	function _toipload(fn){
		p = fn;		
		var packageId,isEn;
		//p=0���ϴ�ԭ��
		if(p=="0"){
			packageId = "<BZ:dataValue field="FILE_CODE" onlyValue="true"/>";
			isEn = "false";
		}else{//p=0���ϴ������
			packageId = "<BZ:dataValue field="FILE_CODE_EN" onlyValue="true"/>";
			isEn = "true";
		}
		document.uploadForm.PACKAGE_ID.value = packageId;
		document.uploadForm.IS_EN.value = isEn;
		document.uploadForm.action="<%=path%>/uploadManager";
		popWin.showWinIframe("1000","600","fileframe","��������","iframe","#");
		document.uploadForm.submit();
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;BCZL;CHILD_TYPE">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<!-- ��������begin -->
<BZ:input type="hidden" prefix="P_" field="CI_ID"			id="P_CI_ID"/>
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="CHILD_NO"		id="P_CHILD_NO"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_IDENTITY"	id="P_CHILD_IDENTITY"/>
<input type="hidden" name="CHILD_NO" id="CHILD_NO" value="<%=CHILD_NO%>"/>
<input type="hidden" name="listType" value="CMS_FLY_CLBS_LIST">
<input type="hidden" name="state" id="state" value="">
<!-- ��������end -->		

<!--������Ϣ:start-->
<br>
<!-- ������begin -->
<div class="stepflex" style="margin-right: 100px;">
       <dl id="payStepFrist" class="done">
           <dt class="s-num">1</dt>
           <dd class="s-text" style="margin-left:0px">��д��ͯ������Ϣ</dd>
       </dl>
       <dl id="payStepNormal" class="normal doing">
           <dt class="s-num">2</dt>
           <dd class="s-text" style="margin-left:0px">��д��ͯ��ϸ��Ϣ<s></s>
               <b></b>
           </dd>
       </dl>	        
</div>
<!-- ������end -->
<table class="specialtable" align="center" style='width:98%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center"><b>��ͯ��Ϣ¼��</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="15%">��ͯ���</td>
		<td class="edit-data-value" width="35%"> 
		<BZ:dataValue field="CHILD_NO" defaultValue=""/>
		</td>
		<td class="edit-data-title" width="15%">��ͯ����</td>
		<td class="edit-data-value" width="35%">
		<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/>
		</td>
		<td class="edit-data-value" width="10%" rowspan="6">
			<up:uploadImage attTypeCode="CI" id="P_PHOTO_CARD" packageId="<%=ciId%>" name="P_PHOTO_CARD" imageStyle="width:150px;height:150px;" autoUpload="true" hiddenSelectTitle="true"
			hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.CI_IMAGE %>" bigType="CI"  diskStoreRuleParamValues="<%=strPar1%>"/> 
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">ʡ��</td>
		<td class="edit-data-value"><BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">����Ժ</td>
		<td class="edit-data-value"><BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">����</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">����ƴ��</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�Ա�</td>
		<td class="edit-data-value"><BZ:dataValue codeName="ETXB" field="SEX" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value"><BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�������<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="CHECKUP_DATE" id="P_CHECKUP_DATE" type="date" notnull="������ڲ���Ϊ�գ�" />
		</td>
		<td class="edit-data-title">˫��̥</td>
		<td class="edit-data-value">
			<input type="button" value="ͬ������" class="btn btn-sm btn-primary" onclick="_setTwins()"/>			
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">���֤��<font color="red">*</font></td>
		<td class="edit-data-value"><BZ:input prefix="P_" field="ID_CARD" id="P_ID_CARD" defaultValue="" notnull="���֤�Ų���Ϊ�գ�"  maxlength="20" size="25"/></td>
		<td class="edit-data-title">��ͯ���<font color="red">*</font></td>
		<td class="edit-data-value"><BZ:dataValue field="CHILD_IDENTITY" codeName="ETSFLX" defaultValue=""/>		
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">������<font color="red">*</font></td>
		<td class="edit-data-value"><BZ:input prefix="P_" field="SENDER" id="P_SENDER" defaultValue="" notnull="�����˲���Ϊ�գ�" maxlength="25" size="25"/></td>
		<td class="edit-data-title">�����˵�ַ<font color="red">*</font></td>
		<td class="edit-data-value" colspan="2"><BZ:input prefix="P_" field="SENDER_ADDR" id="P_SENDER_ADDR" defaultValue="" notnull="�����˵�ַ����Ϊ�գ�" size="60" maxlength="100"/>		
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��ʰ����</td>
		<td class="edit-data-value"><BZ:input type="date" prefix="P_" field="PICKUP_DATE" id="P_PICKUP_DATE" defaultValue=""/></td>
		<td class="edit-data-title">��Ժ����</td>
		<td class="edit-data-value" colspan="2"><BZ:input type="date" prefix="P_" field="ENTER_DATE" id="P_ENTER_DATE" defaultValue=""/></td>
	</tr>
	<tr>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value"><BZ:input type="date" prefix="P_" field="SEND_DATE" id="P_SEND_DATE" defaultValue=""/></td>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value" colspan="2">
		<BZ:select prefix="P_" field="IS_ANNOUNCEMENT" id="P_IS_ANNOUNCEMENT" formTitle="��������" defaultValue="1" width="135px">
			<BZ:option value="0">��</BZ:option>
			<BZ:option value="1">��</BZ:option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value"><BZ:input type="date" prefix="P_" field="ANNOUNCEMENT_DATE" id="P_ANNOUNCEMENT_DATE" defaultValue=""/></td>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value" colspan="2"><BZ:input prefix="P_" field="NEWS_NAME" id="P_NEWS_NAME" defaultValue="" maxlength="100" size="60"/></td>
	</tr>
	<%if("1".equals(CHILD_TYPE)){%>
	<tr>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="SN_TYPE" id="P_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="245px">
			<BZ:option value="">--��ѡ��--</BZ:option>
		</BZ:select>
		</td>
		<td class="edit-data-title">����</td>
		<td class="edit-data-value" colspan="2">
			<input type="checkbox" name="P_IS_PLAN" id="P_IS_PLAN" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>����ƻ�
			<input type="checkbox" name="P_IS_HOPE" id="P_IS_HOPE" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>ϣ��֮��
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">�������</td>
		<td class="edit-data-value" colspan="4">
		<textarea name="P_DISEASE_CN" id="P_DISEASE_CN" rows="5" cols="100" maxlength="1000"><BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/></textarea>
		</td>
	</tr>
	<%}%>
	<tr>
		<td class="edit-data-title">��ע</td>
		<td class="edit-data-value" colspan="4">
		<textarea name="P_REMARKS" id="P_REMARKS" rows="3" cols="100" maxlength="1000"><BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></textarea></td>
	</tr>
	<!--������start-->
	<tr>
		<td class="edit-data-title" colspan="1" style="text-align:center"></td>
		<td class="edit-data-title" colspan="3" style="text-align:center">
		<b>������Ϣ</b></td>
		<td class="edit-data-title" colspan="1" style="text-align:center">
		<input type="button" class="btn btn-sm btn-primary" value="�����ϴ�" onclick="_toipload('0')" />
		</td>
	</tr>
	<tr>
		<td colspan="5">
		<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=CI&packID=<%=packId%>&packageID=<BZ:dataValue field="FILE_CODE" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
		</td>
	</tr>
	<!--������end-->
</table>			
<!--֪ͨ��Ϣ:end-->
<br>
<!-- ��ť����:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
		<input type="button" value="ȡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_cancle();"/>
	</div>
</div>
<!-- ��ť����:end -->

</BZ:form>
<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--����ʹ�ã�start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=uploadParameter%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='org_id=<BZ:dataValue field="ADOPT_ORG_ID" onlyValue="true"/>;af_id=<BZ:dataValue field="AF_ID" onlyValue="true"/>'/>
		
		<!--����ʹ�ã�end-->
	</form>
</BZ:body>
</BZ:html>
