<%
/**   
 * @Title: DAB_PP_feedback_catalog.jsp
 * @Description: 涉外收养档案案卷内目录（二）
 * @author xugy
 * @date 2014-11-4上午10:16:22
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>涉外收养档案案卷内目录（二）</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//
function _print(){
	//页面表单校验
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
}
//
function _save(){
	//页面表单校验
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
	document.srcForm.action=path+"feedback/saveDABPPFeedbackCatalog.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"feedback/DABPPFeedbackAuditList.action";
	document.srcForm.submit();
}
</script>
<style type="text/css">
	#tab tr {
		height: 30px;
	}
	#tab tr td {
		border: 1px black solid;
	}
	.center {
		text-align: center;
	}
</style>
<BZ:body property="data" codeNames="WJLX;ETSFLX;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="FI_" field="FEEDBACK_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" style="text-align: center;" desc="编辑区域">
		<div style="text-align: center;"><b><font size="4">涉外收养档案案卷内目录（二）</font></b></div>
	</div>
	<table style="width: 50%;margin-top: 10px;" align="center">
		<tr style="height: 30px;">
			<td style="width: 30%;">档案号：<BZ:dataValue field="ARCHIVE_NO" defaultValue="" /></td>
			<td style="text-align: right;">被收养人姓名：<BZ:dataValue field="NAME" defaultValue="" /></td>
		</tr>
		<tr style="height: 30px;">
			<td>文件类型：<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
			<td  style="text-align: right;">儿童身份：<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/></td>
		</tr>
	</table>
	<table style="width: 50%;margin-top: 10px;" align="center" id="tab">
		<colgroup>
			<col width="10%"/>
			<col width="75%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<td class="center">序号</td>
			<td class="center">文件名称</td>
			<td class="center">件数</td>
		</tr>
		<tr>
			<td class="center">1</td>
			<td>第一次收养安置后报告 </td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE1_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE2_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE3_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE1" defaultValue="" type="date"/></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME1" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>第二次收养安置后报告</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE4_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE5_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE6_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE2" defaultValue="" type="date"/></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME2" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>第三次收养安置后报告</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE7_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE8_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE9_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE3" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME3" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>第四次收养安置后报告</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE10_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE11_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE12_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE4" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME4" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>第五次收养安置后报告</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE13_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE14_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE15_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE5" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME5" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>第六次收养安置后报告</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE16_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>十岁以上被收养人自己撰写的短文</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE17_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>照片</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE18_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">立卷日期：<BZ:input prefix="FI_" field="FILING_DATE6" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">立卷人：<BZ:input prefix="FI_" field="FILING_USERNAME6" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="保&nbsp;&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()" />
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
