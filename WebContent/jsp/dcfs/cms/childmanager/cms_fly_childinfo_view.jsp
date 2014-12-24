<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>

<%
  /**   
 * @Description: 儿童材料信息查看（福利院、省厅）
 * @author wangzheng   
 * @date 2014-9-15
 * @version V1.0   
 */
String path = request.getContextPath();

Data d = (Data)request.getAttribute("data");
DataList twinsList = (DataList)request.getAttribute("twinsList");
//根据onlyOne参数判断在该页面最下面是否显示"关闭"按钮
String onlyOne=(String)request.getAttribute("onlyOne");
String ciId = d.getString("CI_ID","");
String orgId = d.getString("WELFARE_ID","");
String strPar ="org_id="+orgId + ";ci_id=" + ciId;
String CHILD_TYPE = d.getString("CHILD_TYPE","");
String CHILD_NO = d.getString("CHILD_NO");
String IS_TWINS = d.getString("IS_TWINS","0");
String CHILD_IDENTITY = d.getString("CHILD_IDENTITY","");
String IS_ANNOUNCEMENT=d.getString("IS_ANNOUNCEMENT","");
String uploadParameter = (String)request.getAttribute("uploadParameter");
//根据儿童身份选择附件集合
ChildCommonManager ccm = new ChildCommonManager();
String packId = ccm.getChildPackIdByChildIdentity(CHILD_IDENTITY, CHILD_TYPE, false);
%>

<BZ:html>
	<BZ:head>
		<title>材料信息查看</title>
        <BZ:webScript edit="true"/>
        <up:uploadResource isImage="true" cancelJquerySupport="true"/>	
        <!--批量附件上传：start-->
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<!--批量附件上传：end-->	
        <script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>		
	</BZ:head>	
<script type="text/javascript">
	//iFrame高度自动调整
	$(document).ready(function() {
		//dyniframesize(['mainFrame']);
		//页面加载时如果是报刊公告则显示"公告日期"和"报刊名称"的填写行
		var isannounce ="<%=IS_ANNOUNCEMENT %>";//是否报刊公告
		if(isannounce=="1"){
			$("#announcementInfo").show();
		}
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
		popWin.showWinIframe("900","400","fileframe","附件管理","iframe","#",y);
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
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;BCZL;CHILD_TYPE;">

<!--基本信息:start-->
<br>
<div id="layer_show" style="display:none;">
	<img class="preview_img" src='' height="400px">
</div>
<table class="specialtable" align="center" style='width:98%;text-align:center'>
    <%if(!"0".equals(onlyOne)){ %>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center"><b>儿童材料信息查看</b></td>
	</tr>
	<%} %>
	<tr>
		<td class="edit-data-title" width="15%">儿童编号</td>
		<td class="edit-data-value" width="30%"> 
		<BZ:dataValue field="CHILD_NO" defaultValue=""/>
		</td>
		<td class="edit-data-title" width="15%">儿童类型</td>
		<td class="edit-data-value" width="30%">
		<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/>
		</td>
		<td class="edit-data-value" width="10%" rowspan="6">
		<input type="image" src='<up:attDownload attTypeCode="CI" packageId="<%=ciId%>" smallType="<%=AttConstants.CI_IMAGE %>"/>' style="width:150px;height:175px;"/>					 
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">省份</td>
		<td class="edit-data-value"><BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">福利院</td>
		<td class="edit-data-value"><BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">姓名</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">姓名拼音</td>
		<td class="edit-data-value"><BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">性别</td>
		<td class="edit-data-value"><BZ:dataValue codeName="ETXB" field="SEX" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">出生日期</td>
		<td class="edit-data-value"><BZ:dataValue field="BIRTHDAY" type="date" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">体检日期</td>
		<td class="edit-data-value"><BZ:dataValue field="CHECKUP_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">双胞胎</td>
		<td class="edit-data-value">
		<% if("1".equals(IS_TWINS)){
			for(int i=0;i<twinsList.size();i++){
				Data cdata = twinsList.getData(i);
		%>
				<a href="<%=path%>/cms/childManager/show.action?UUID=<%=cdata.getString("CI_ID") %>&type=show"><%=cdata.getString("NAME") %></a>&nbsp;
		<%
			}
		%>
		
		
		<%} %>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">身份证号</td>
		<td class="edit-data-value"><BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">儿童身份</td>
		<td class="edit-data-value"><BZ:dataValue field="CHILD_IDENTITY" codeName="ETSFLX" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">送养人（中）</td>
		<td class="edit-data-value"><BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">送养人（英）</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="SENDER_EN" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">送养人地址</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>	
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">捡拾日期</td>
		<td class="edit-data-value"><BZ:dataValue field="PICKUP_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">入院日期</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="ENTER_DATE" type="date" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title">报送日期</td>
		<td class="edit-data-value"><BZ:dataValue field="SEND_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">报刊公告</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="IS_ANNOUNCEMENT" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
		</td>
	</tr>
	<tr id="announcementInfo" style="display:none">
		<td class="edit-data-title">公告日期</td>
		<td class="edit-data-value"><BZ:dataValue field="ANNOUNCEMENT_DATE" type="date" defaultValue="" onlyValue="true"/></td>
		<td class="edit-data-title">报刊名称</td>
		<td class="edit-data-value" colspan="2"><BZ:dataValue field="NEWS_NAME" defaultValue="" onlyValue="true"/></td>
	</tr>
	<%if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)){%>
	<tr>
		<td class="edit-data-title">病残种类</td>
		<td class="edit-data-value">
		<BZ:dataValue field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/>
		</td>
		<td class="edit-data-title">特殊活动</td>
		<td class="edit-data-value" colspan="2">
			<BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=明天计划"/>&nbsp;&nbsp;
			<BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=希望之旅"/>			
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">病残诊断（中）</td>
		<td class="edit-data-value" colspan="4"><BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">病残诊断（英）</td>
		<td class="edit-data-value" colspan="4"><BZ:dataValue field="DISEASE_EN" defaultValue="" onlyValue="true"/>
		</td>
	</tr>
	<%}%>
	<tr>
		<td class="edit-data-title">备注</td>
		<td class="edit-data-value" colspan="4">
		<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></td>
	</tr>
	<tr>
		<td class="edit-data-title" colspan="5" style="text-align:center">
			<b>附件信息</b>
			<span><input type="button" value="下载附件（中文）" class="btn btn-sm btn-primary" onclick="_toipload('CN',this)" /></span>
			<span><input type="button" value="下载附件（英文）" class="btn btn-sm btn-primary" onclick="_toipload('EN',this)" /></span>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<iframe id="attFrame" name="attFrame" class="attFrame" frameborder=0 style="width: 100%;"  src="<%=path%>/cms/childManager/childAttShowListCN.action?CI_ID=<%=ciId%>&CHILD_TYPE=<%=CHILD_TYPE%>&CHILD_IDENTITY=<%=CHILD_IDENTITY%>"></iframe>
		</td>
	</tr>
</table>		
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
<!--通知信息:end-->
<br>
<%if(!"0".equals(onlyOne)){ %>
<!-- 按钮区域:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="按钮区">		
		<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
	</div>
</div>
<!-- 按钮区域:end -->
<%} %>
</BZ:body>
</BZ:html>
