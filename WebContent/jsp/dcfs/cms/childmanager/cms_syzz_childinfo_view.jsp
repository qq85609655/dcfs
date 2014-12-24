<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>

<%
String path = request.getContextPath();

Data d = (Data)request.getAttribute("data");
String ciId = d.getString("CI_ID","");
String CHILD_TYPE = d.getString("CHILD_TYPE","");
String CHILD_IDENTITY=d.getString("CHILD_IDENTITY","");
String uploadParameter = (String)request.getAttribute("uploadParameter");
%>

<BZ:html>
	<BZ:head>
		<title>��ͯ������Ϣ�鿴</title>
        <BZ:webScript edit="true"/>
        <up:uploadResource isImage="true" cancelJquerySupport="true"/>
        <!--���������ϴ���start-->
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<!--���������ϴ���end-->	
        <script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>	
	</BZ:head>	
<script type="text/javascript">
	//iFrame�߶��Զ�����
	$(document).ready( function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		//var obj = parent.document.getElementById("iframe");
		//var doc = obj.contentWindow.document || obj.contentDocument;
		//obj.style.height =	doc.body.offsetHeight +'px';
		
		//obj.style.height =	obj.contentWindow.document.body.offsetHeight +'px';
	});
	function _close(){
		window.close();
	}
	function _toipload(fn,obj){
		if("EN"==fn){
			document.getElementById("IS_EN").value ="true";
		}else if("CN"==fn){
		   document.getElementById("IS_EN").value ="false";
		}
		var y = obj.offsetTop;
		var ch = document.body.clientHeight;
		while(obj=obj.offsetParent) 
		{ 
			y   +=   obj.offsetTop;			
		}

		if((ch-y)<271){
			y = y - (ch-y); 
		}
		document.uploadForm.action="<%=path%>/uploadManager?type=show";
		popWin.showWinIframe("900","400","fileframe","��������","iframe","#",y);
		document.uploadForm.submit();
	}
	function _showPhoto(path){
		$("#layer_show .preview_img").prop("src", path);
		$.layer({
			type : 1,
			title : false,
			fix : false,
			area : ['auto','auto'],
			page : {dom : '#layer_show'},
			closeBtn : [1 , true]
		});
	}
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;BCZL;CHILD_TYPE;BCCD">

<!--������Ϣ:start-->
<br>
<div id="layer_show" style="display:none;">
	<img class="preview_img" src='' height="400px">
</div>
<table class="specialtable" align="center" style='width:98%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center"><b>��ͯ������Ϣ��Child information��</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="20%">�� ��<br/>No.</td>
		<td class="edit-data-value" width="24%"> 
		<BZ:dataValue field="CHILD_NO" defaultValue=""/>
		</td>
		<td class="edit-data-title" width="20%">����<br/>Type of children</td>
		<td class="edit-data-value" width="26%">
		<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" isShowEN="true" onlyValue="true"/>
		</td>
		<td class="edit-data-value" width="10%" rowspan="3">
		<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=ciId%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:175px;"/>					 
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">�� ��<br/>Name��CN��</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">����ƴ��<br/>Name��EN��</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�� ��<br/>Sex</td>
		<td class="edit-data-value"><BZ:dataValue codeName="ETXB" isShowEN="true" field="SEX" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">��������<br/>D.O.B</td>
		<td class="edit-data-value"><BZ:dataValue field="BIRTHDAY" type="date" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">ʡ ��<br/>Province</td>
		<td class="edit-data-value"><BZ:dataValue codeName="PROVINCE" isShowEN="true" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">�� �� Ժ<br/>SWI</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�������<br/>Date of physical exam</td>
		<td class="edit-data-value"><BZ:dataValue field="CHECKUP_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">˫��̥<br/>Multiple birth</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="IS_TWINS" defaultValue="0" onlyValue="true" checkValue="0=no;1=yes"/>
		</td>
	</tr>
	<%if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)) {%>
	<tr>
		<td class="edit-data-title">����������<br/>Last updated</td>
		<td class="edit-data-value"><BZ:dataValue field="LAST_UPDATE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">���´���<br/>Updated times</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="UPDATE_NUM" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��������<br/>Released date</td>
		<td class="edit-data-value"><BZ:dataValue field="PUB_LASTDATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">��������<br/>Deadline of placement</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="SETTLE_DATE" type="date" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">�ر��ע<br/>Special focus</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="0" onlyValue="true" checkValue="0=no;1=yes"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">�ļ��ݽ�����<br/>Document submission deadline</td>
		<td class="edit-data-value" colspan="4"><BZ:dataValue field="SUBMIT_DATE" type="date" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">��������<br/>SN type</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="SN_TYPE" codeName="BCZL" isShowEN="true" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">������ϣ��У�<br/>Diagnosis(CN)</td>
		<td class="edit-data-value" colspan="4"><BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">������ϣ��⣩<br/>Diagnosis(EN)</td>
		<td class="edit-data-value" colspan="4"><BZ:dataValue field="DISEASE_EN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<%} %>
	<tr>
		<td class="edit-data-title" ><br/>��ע<br/>Remarks<br/>&nbsp;</td>
		<td class="edit-data-value" colspan="4" >
		<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center">
			<b>������Ϣ(Attachment)</b>
			<span><input type="button" value="���ظ��������ģ�" class="btn btn-sm btn-primary" onclick="_toipload('CN',this)" /></span>
			<span><input type="button" value="���ظ�����Ӣ�ģ�" class="btn btn-sm btn-primary" onclick="_toipload('EN',this)" /></span>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;"  src="<%=path%>/cms/childManager/childAttShowList.action?CI_ID=<%=ciId%>&CHILD_TYPE=<%=CHILD_TYPE%>&CHILD_IDENTITY=<%=CHILD_IDENTITY%>"></iframe>
		</td>
	</tr>
</table>			
<!--֪ͨ��Ϣ:end-->
<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<input type="hidden" id="PACKAGE_ID" name="PACKAGE_ID" value='<%=ciId%>'/>
	<input type="hidden" id="SMALL_TYPE" name="SMALL_TYPE" value='<%=uploadParameter%>'/>
	<input type="hidden" id="ENTITY_NAME" name="ENTITY_NAME" value="ATT_CI"/>
	<input type="hidden" id="BIG_TYPE" name="BIG_TYPE" value="CI"/>
	<input type="hidden" id="IS_EN" name="IS_EN" value="false"/>
	<input type="hidden" id="CREATE_USER" name="CREATE_USER" value=""/>
	<input type="hidden" id="PATH_ARGS" name="PATH_ARGS" value="ar_id=1212133,ar_class=1212232"/>
	<textarea rows="5" cols="" style="width:600px;display: none;" id="textareaid"></textarea>
</form>
</BZ:body>
</BZ:html>
