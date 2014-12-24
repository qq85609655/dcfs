<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>

<%
  /**   
 * @Description: ���Ϸ���鿴
 * @author wangzheng   
 * @date 2014-10-20
 * @version V1.0   
 */
String path = request.getContextPath();

Data d = (Data)request.getAttribute("data");
String ciId = d.getString("CI_ID","");
String fciId = "F_"+ciId;
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
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<title>������Ϣ����</title>
        
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
 
	//�ر�
	function _close(){
		window.close();
	}

	//��ӡ
	function _print(){
		window.print();
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;BCZL;CHILD_TYPE">
<BZ:form name="srcForm" method="post">
<!-- ��������begin -->
<BZ:input type="hidden" prefix="P_" field="CI_ID"			id="P_CI_ID"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_NO"		id="P_CHILD_NO"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_TYPE"		id="P_CHILD_TYPE"/>
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="CHILD_NO"		id="P_CHILD_NO"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<BZ:input type="hidden" prefix="P_" field="NAME"			id="P_NAME"/>
<BZ:input type="hidden" prefix="P_" field="NAME_PINYIN"		id="P_NAME_PINYIN"/>
<BZ:input type="hidden" prefix="P_" field="SEX"				id="P_SEX"/>
<BZ:input type="hidden" prefix="P_" field="BIRTHDAY"		id="P_BIRTHDAY"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_IDENTITY"	id="P_CHILD_IDENTITY"/>
<BZ:input type="hidden" prefix="P_" field="FILE_CODE"		id="P_FILE_CODE"/>
<BZ:input type="hidden" prefix="P_" field="FILE_CODE_EN"	id="P_FILE_CODE_EN"/>

<BZ:input type="hidden" prefix="T_" field="CT_ID"	id="T_CT_ID"/>
<input type="hidden" name="T_TRANSLATION_STATE" id="T_TRANSLATION_STATE" value="">
<!-- ��������end -->		

<!--������Ϣ:start-->
<br>
<table class="specialtable" align="center" style='width:98%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center"><b>��ͯ������Ϣ</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="15%">��ͯ���</td>
		<td class="edit-data-value" width="30%"> 
		<BZ:dataValue field="CHILD_NO" defaultValue=""/>
		</td>
		<td class="edit-data-title" width="15%">��ͯ����</td>
		<td class="edit-data-value" width="30%">
		<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/>
		</td>
		<td class="edit-data-value" width="10%" rowspan="6" style="text-align:center">
		<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=ciId%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:150px;">		 
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
		<td class="edit-data-value"><BZ:dataValue field="BIRTHDAY" type="date" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�������</td>
		<td class="edit-data-value"><BZ:dataValue field="CHECKUP_DATE" type="date" defaultValue="" onlyValue="true"/>
		</td>
		<td class="edit-data-title">˫��̥</td>
		<td class="edit-data-value">
		<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>		
		</td>
	</tr>
	
	<tr>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value">
		<BZ:dataValue field="ANNOUNCEMENT_DATE" type="date" defaultValue="" onlyValue="true"/>
		</td>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value" colspan="2">
		<BZ:dataValue field="NEWS_NAME" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<%if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)){%>
	<tr>
		<td class="edit-data-title">��������</td>
		<td class="edit-data-value">
		<BZ:dataValue codeName="BCZL" field="SN_TYPE" defaultValue="" onlyValue="true"/>		
		</td>
		<td class="edit-data-title">����</td>
		<td class="edit-data-value" colspan="2">
			<BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=����ƻ�"/>
			<BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=ϣ��֮��"/>			
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">������ϣ��У�</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/>
		<textarea name="P_DISEASE_CN" id="P_DISEASE_CN" rows="5" cols="100" maxlength="1000" readonly="true"><BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/></textarea>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">������ϣ�Ӣ��</td>
		<td class="edit-data-value" colspan="4">
		<textarea name="P_DISEASE_EN" id="P_DISEASE_EN" rows="5" cols="100" maxlength="1000" readonly="true"><BZ:dataValue field="DISEASE_EN" defaultValue="" onlyValue="true"/></textarea>
		</td>
	</tr>
	<%}%>
	<tr>
		<td class="edit-data-title">��ע</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<!--���������ģ���start-->
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center">
		<b>������Ϣ���У�</b></td>		
	</tr>
	<tr>
		<td colspan="5"><IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=CI&packID=<%=packId%>&packageID=<BZ:dataValue field="CI_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
		</td>
	</tr>
	<!--������end-->
	<!--������Ӣ�ģ���start-->
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center">
		<b>������Ϣ��Ӣ��</b></td>		
	</tr>
	<tr>
		<td colspan="5">
		<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=CI&packID=<%=packId%>&packageID=<%=fciId%>" frameborder=0 width="100%" height="100%"></IFRAME> 
		</td>
	</tr>
	<!--������end-->
</table>

<!--������Ϣ��start-->
		<div id="tab-translation">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>������Ϣ</b></td>
                </tr>
				<tr>
					<td  class="edit-data-title" width="15%">����֪ͨ��</td>
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">֪ͨ����</td>
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_DATE" type="date" defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">��������</td>
					<td  class="edit-data-value"><BZ:dataValue field="RECEIVE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">���뵥λ</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_UNITNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">������</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">�������</td>
					<td  class="edit-data-value"><BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">����״̬</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
				</tr>
                <tr>
					<td  class="edit-data-title" width="15%">����˵��</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_DESC"  defaultValue="" /></td>
				</tr>
			</table>
		</div>
		<!--������Ϣ��end-->
<br>
<!-- ��ť����:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="��ť��">
	<!-- input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;&nbsp; -->
	<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>
	</div>
</div>
<!-- ��ť����:end -->

</BZ:form>
<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--����ʹ�ã�start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value='<BZ:dataValue field="CI_ID" defaultValue="" onlyValue="true"/>'/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=uploadParameter%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_CI"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="CI"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar%>'/>
		
		<!--����ʹ�ã�end-->
	</form>
</BZ:body>
</BZ:html>
