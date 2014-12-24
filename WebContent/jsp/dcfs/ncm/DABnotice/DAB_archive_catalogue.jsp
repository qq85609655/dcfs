<%
/**   
 * @Title: DAB_archive_catalogue.jsp
 * @Description: 档案目录
 * @author xugy
 * @date 2014-11-2下午7:00:22
 * @version V1.0   
 * @add function web print by kings
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");

String CHILD_IDENTITY = data.getString("CHILD_IDENTITY");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>档案目录</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	_check_one();
});
//
function _check_one(){
	var inputElement = $(".fileNum");
	var total = 0;
	for(var i=0;i<inputElement.length;i++){
		var num = inputElement[i].value;
		total = total + Number(num);
	}
	$("#total").text(total);
}
//
function _print(){
	$("#PrintArea").jqprint(); 
}
//
function _save(){
	//页面表单校验
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"notice/saveDABCatalog.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"notice/DABArchiveFilingList.action";
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
	#tab tr th {
		border: 1px black solid;
	}
	.center {
		text-align: center;
	}
</style>
<BZ:body property="data" codeNames="WJLX;ETSFLX;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
	<div id="PrintArea"> 
	<div class="bz-edit clearfix" style="text-align: center;" desc="编辑区域">
		<div style="text-align: center;"><b><font size="4"><p class="title3">涉外收养档案卷内目录（一）</p></font></b></div>
	</div>
	<table style="width: 90%;margin-top: 10px;" align="center">
		<tr style="height: 30px;">
			<td style="width: 30%;">档案号：<BZ:dataValue field="ARCHIVE_NO" defaultValue="" /></td>
			<td style="text-align: right;">被收养人姓名：<BZ:dataValue field="NAME" defaultValue="" /></td>
		</tr>
		<tr style="height: 30px;">
			<td>文件类型：<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
			<td  style="text-align: right;">儿童身份：<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/></td>
		</tr>
	</table>
	<table style="width: 90%;margin-top: 10px;" align="center" id="tab" class="table-print">
		<thead>
			<tr>
				<th >序号</th>
				<th >文件名称</th>
				<th >件数</th>
			</tr>
		</thead>
		<%
		if("10".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>《涉外送养通知》（副本） </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>《来华收养子女通知书》（副本）</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>《征求收养意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>《征求收养人意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>《涉外送养审查意见表》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>送养人居民身份证复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>被收养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>《捡拾弃婴登记表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>《社会福利机构接收弃婴入院登记表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>查找弃婴儿童生父母公告复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>被送养儿童成长情况报告复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>《被送养儿童成长状况表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>收养人基本情况表</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>跨国收养申请书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>出生证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>婚姻状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>职业证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>经济收入和财产状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>身体健康检查证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>有无受过刑事处罚的证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>家庭情况报告及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>收养人护照复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>收养人申请文件原件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>照片</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>张</td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>其他</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>文件总数</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY) || "20".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>《涉外送养通知》（副本） </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>《来华收养子女通知书》（副本）</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>《征求收养意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>《征求收养人意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>《涉外送养审查意见表》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>被收养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>《社会福利机构接收孤儿入院登记表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>其他有抚养孤儿义务的人放弃监护权及同意送养的书面意见</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>被送养儿童生父母死亡或宣告死亡证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>孤儿原家庭住址所在地村民委员会或居民委员会意见</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>被送养儿童成长情况报告复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>《被送养儿童成长状况表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>被收养人同意被收养的声明及公证</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>收养人基本情况表</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>跨国收养申请书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>出生证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>婚姻状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>职业证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>经济收入和财产状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>身体健康检查证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>有无受过刑事处罚的证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>家庭情况报告及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>收养人护照复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>收养人申请文件原件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>照片</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>张</td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>文件总数</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY) || "30".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>《涉外送养通知》（副本） </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>《来华收养子女通知书》（副本）</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>《征求收养意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>《征求收养人意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>《涉外送养审查意见表》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>转移监护权协议</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>生父母或其他监护人同意送养的书面意见</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>死亡或下落不明一方生父母的父母不行使优先抚养权的声明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>其他有抚养义务的人同意送养的书面意见</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>被收养人生父或生母死亡或宣告死亡证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>被收养人生父母有特殊困难无力抚养的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>被收养人同意被收养的声明及公证书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>《被收养儿童体格检查表》及化验检查报告单复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>被收养儿童成长情况报告复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>《被送养儿童成长状况表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>收养人基本情况表</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>跨国收养申请书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>出生证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>婚姻状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>职业证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>经济收入和财产状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>身体健康检查证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>有无受过刑事处罚的证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>家庭情况报告及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>收养人护照复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>收养人申请文件原件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>照片</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE29_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>张</td>
		</tr>
		<tr>
			<td class="center">30</td>
			<td>文件总数</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("40".equals(CHILD_IDENTITY) || "50".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>《涉外送养通知》（副本） </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>《来华收养子女通知书》（副本）</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>《征求收养意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>《征求收养人意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>《涉外送养审查意见表》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="3" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>《被收养人体格检查表》及化验检查报告单复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>送养人与当地计划生育部门签订的不违反计划生育规定的协议</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>送养人与被收养人的亲属关系证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>送养人与收养人的亲属关系证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>被收养人是收养人三代以内旁系血亲的子女亲属关系证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>送养人同意送养的声明及公证</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>送养人结婚证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>收养人与被收养人生父或生母结婚的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>被收养人自愿被收养的声明及公证书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>生父母死亡证明及监护人同意送养的声明及公证书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>收养人基本情况表</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>跨国收养申请书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>出生证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>婚姻状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>职业证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>经济收入和财产状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>身体健康检查证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>有无受过刑事处罚的证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>家庭情况报告及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>收养人护照复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>收养人申请文件原件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>照片</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE29_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>张</td>
		</tr>
		<tr>
			<td class="center">30</td>
			<td>文件总数</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("60".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>《涉外送养通知》（副本） </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>《来华收养子女通知书》（副本）</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>《征求收养意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>《征求收养人意见书》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>《涉外送养审查意见表》</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>送养人居民身份证复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>被收养人户籍证明复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>撤消被送养儿童生父母监护资格判决书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>《社会福利机构接收弃婴入院登记表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>其他有抚养义务的人放弃监护权及同意送养的书面意见</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>被送养儿童成长情况报告复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>《被送养儿童成长状况表》复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>被送养儿童同意被收养的声明及公证</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>收养人基本情况表</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>跨国收养申请书</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>出生证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>婚姻状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>职业证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>经济收入和财产状况证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>身体健康检查证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>有无受过刑事处罚的证明及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>家庭情况报告及附件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>收养人申请文件原件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>收养人护照复印件</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>照片</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>张</td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>文件总数</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<table style="width: 90%;" align="center">
		<tr>
			<td>立卷日期：<BZ:input prefix="AI_" field="FILING_DATE" defaultValue="" type="date" /></td>
			<td style="text-align: right;">立卷人：<BZ:input prefix="AI_" field="FILING_USERNAME" defaultValue="" /></td>
		</tr>
	</table>
	</div>
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
