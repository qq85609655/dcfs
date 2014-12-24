<%
/**   
 * @Title: PP_feedback_record_detail.jsp
 * @Description: 安置后报告查看
 * @author xugy
 * @date 2014-11-5上午11:24:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
DataList dataList = (DataList)request.getAttribute("dataList");
boolean num1 = false;
boolean num2 = false;
boolean num3 = false;
boolean num4 = false;
boolean num5 = false;
boolean num6 = false;
String CI_ID = "";
String AF_ID = "";
String FEEDBACK_ID = "";
String BIRTHDAY = "";
if(dataList.size()>0){
    for(int i=0;i<dataList.size();i++){
        int num = dataList.getData(i).getInt("NUM");
        if(num == 1){
            num1 = true;
        }
        if(num == 2){
            num2 = true;
        }
        if(num == 3){
            num3 = true;
        }
        if(num == 4){
            num4 = true;
        }
        if(num == 5){
            num5 = true;
        }
        if(num == 6){
            num6 = true;
        }
    }
    CI_ID = dataList.getData(0).getString("CI_ID");
    AF_ID = dataList.getData(0).getString("AF_ID");
    FEEDBACK_ID = dataList.getData(0).getString("FEEDBACK_ID");
    BIRTHDAY = dataList.getData(0).getString("BIRTHDAY");
}

String type = (String)request.getAttribute("type");

%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>历次安置后报告查看</title>
	<BZ:webScript edit="true" tree="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});

//
function _showPhoto(path){
	$("#layer_show .preview_img").prop("src", path);
	var obj = document.createElement('img');
	obj.src = document.getElementById('preview_img').src;
	obj.onload = function(){
		var w = this.width;
		var h = this.height;
		var x = w > h ? w : h;
		document.getElementById('img_tab').style.width = x+'px';
		document.getElementById('img_tab').style.height = x+'px';
		document.getElementById('img').style.transform="none";
		$.layer({
			type : 1,
			shadeClose: true,
			fix : true,
			title: '图片查看',
			moveOut :true,
			bgcolor: '',
			area : ['auto', 'auto'],
			page : {dom : '#layer_show'},
			closeBtn : [1 , true]
		});
	};

}
var path = "<%=path%>/";
var type = "<%=type%>";
//
function _goback(){
	if(type == "FLY"){
		document.srcForm.action=path+"feedback/FLYPPFeedbackList.action";
	}
	if(type == "ST"){
		document.srcForm.action=path+"feedback/STPPFeedbackList.action";
	}
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="SYLX;WJLX;">
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	$('#tab-container').easytabs();
});
</script>
<BZ:form name="srcForm" method="post">
	<%
	if(!num1 && !num2 && !num3 && !num4 && !num5 && !num5){
	%>
	<div style="text-align: center;font-size: 40px;color: red;">没有该安置后报告信息或您无权限查看该报告</div>
	<%
	}
	%>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<%
			if(num1){
			%>
			<li class="tab"><a href="#tab1">第一次匹配</a></li>
			<%
			}
			if(num2){
			%>
			<li class="tab"><a href="#tab2">第二次匹配</a></li>
			<%
			}
			if(num3){
			%>
			<li class="tab"><a href="#tab3">第三次匹配</a></li>
			<%
			}
			if(num4){
			%>
			<li class="tab"><a href="#tab4">第四次匹配</a></li>
			<%
			}
			if(num5){
			%>
			<li class="tab"><a href="#tab5">第五次匹配</a></li>
			<%
			}
			if(num6){
			%>
			<li class="tab"><a href="#tab6">第六次匹配</a></li>
			<%
			}
			%>
		</ul>
		<div class='panel-container'>
			<%
			if(dataList.size()>0){
			%>
			<table class="specialtable">
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>审核录入信息</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<tr>
									<td class="edit-data-title" width="15%">国家</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="COUNTRY_CN" defaultValue=""/>
									</td>
									<td class="edit-data-title" width="15%">收养组织</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="NAME_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收文编号</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FILE_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">收文日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">来华领养通知书编号</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">签发日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养登记日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ADREG_DATE" defaultValue="" type="date"/>
									</td>
									<td class="edit-data-title">文件类型</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FILE_TYPE" defaultValue=""  codeName="WJLX"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">档案编号</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ARCHIVE_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">收养类型</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX"/>
									</td>
								</tr>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>收养人信息</b></td>
				</tr>
				<tr>
					<td>
						<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/feedback/AFInfoShow.action?AF_ID=<%=AF_ID%>"></iframe>
					</td>
				</tr>
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>儿童信息</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<tr>
									<td class="edit-data-title" width="15%">入籍姓名</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="CHILD_NAME_EN" defaultValue=""/>
									</td>
									<td class="edit-data-title" width="15%"></td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="" defaultValue=""/>
									</td>
								</tr>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/feedback/CIInfoShow.action?CI_ID=<%=CI_ID%>"></iframe>
					</td>
				</tr>
			</table>
			<%
			}
			if(num1){
			%>
			<div id="tab1">
				<iframe id="FRFrame1" name="FRFrame1" class="FRFrame1" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=1&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			if(num2){
			%>
			<div id="tab2">
				<iframe id="FRFrame2" name="FRFrame2" class="FRFrame2" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=2&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			if(num3){
			%>
			<div id="tab3">
				<iframe id="FRFrame3" name="FRFrame3" class="FRFrame3" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=3&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			if(num4){
			%>
			<div id="tab4">
				<iframe id="FRFrame4" name="FRFrame4" class="FRFrame4" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=4&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			if(num5){
			%>
			<div id="tab5">
				<iframe id="FRFrame5" name="FRFrame5" class="FRFrame5" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=5&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			if(num6){
			%>
			<div id="tab6">
				<iframe id="FRFrame6" name="FRFrame6" class="FRFrame6" frameborder=0 style="width: 100%;height: 800px;" src="<%=path%>/feedback/getFeedbackRecordDetail.action?FEEDBACK_ID=<%=FEEDBACK_ID%>&NUM=6&BIRTHDAY=<%=BIRTHDAY%>"></iframe>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<div style="text-align: center;">
		<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
	</div>
<div id="layer_show" style="display:none;">
	<table border="0" id="img_tab" style="text-align: center;">
		<tr>
			<td id="img">
				<img class="preview_img" id="preview_img" src=''>
			</td>
		</tr>
	</table>
	<table width="400px">
		<tr>
			<td align="center">
				<input type="button" value="左旋转" onclick="_rotate(-90)">
				<input type="button" value="右旋转" onclick="_rotate(90)">
			</td>
		</tr>
	</table>
	<script type="text/javascript">
	var ttt = 0;
	function _rotate(s){
		ttt += s;
		var s = "rotate("+ttt+"deg)";
		document.getElementById('img').style.transform=s;
	}
	</script>
</div>
</BZ:form>
</BZ:body>
</BZ:html>
