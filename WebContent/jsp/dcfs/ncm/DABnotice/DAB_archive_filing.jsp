<%
/**   
 * @Title: DAB_archive_filing.jsp
 * @Description: 归档立卷
 * @author xugy
 * @date 2014-11-2上午11:27:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String CHILD_IDENTITY = data.getString("CHILD_IDENTITY");
String MALE_NAME = data.getString("MALE_NAME","");
String FEMALE_NAME = data.getString("FEMALE_NAME","");


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>儿童信息查看</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;ETSFLX;GJSY;ADOPTER_HEALTH;PROVINCE;BCZL;ETSFLX;ETXB;SYLX;GJ;">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	$('#tab-container').easytabs();
	
	var spanElement = $(".fileNum");
	var total = 0;
	for(var i=0;i<spanElement.length;i++){
		var num = spanElement[i].innerHTML;
		total = total + Number(num);
	}
	$("#total").text(total);
	
});
var path = "<%=path %>/";
//保存
function _saveFiling(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if (confirm('确定归档？')) {
		document.srcForm.action=path+"notice/saveDABArchiveFiling.action";
		document.srcForm.submit();
	}
}
//返回列表
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
	vertical-align: middle;
}
.center {
	text-align: center;
}
</style>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<li class="tab"><a href="#tab1">涉外收养档案卷内目录（一）</a></li>
			<li class="tab"><a href="#tab2">归档立卷表</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<div style="text-align: center;"><b><font size="4">涉外收养档案卷内目录（一）</font></b></div>
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
					<%
					if("10".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>《涉外送养通知》（副本） </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>《来华收养子女通知书》（副本）</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>《征求收养意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>《征求收养人意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>《涉外送养审查意见表》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>送养人居民身份证复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>被收养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>《捡拾弃婴登记表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>《社会福利机构接收弃婴入院登记表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>查找弃婴儿童生父母公告复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>被送养儿童成长情况报告复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>《被送养儿童成长状况表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>收养人基本情况表</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>跨国收养申请书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>出生证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>婚姻状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>职业证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>经济收入和财产状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>身体健康检查证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>有无受过刑事处罚的证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>家庭情况报告及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>收养人护照复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>收养人申请文件原件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>照片</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue=""/>张</td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>其他</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
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
					if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>《涉外送养通知》（副本） </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>《来华收养子女通知书》（副本）</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>《征求收养意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>《征求收养人意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>《涉外送养审查意见表》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>被收养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>《社会福利机构接收孤儿入院登记表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>其他有抚养孤儿义务的人放弃监护权及同意送养的书面意见</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>被送养儿童生父母死亡或宣告死亡证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>孤儿原家庭住址所在地村民委员会或居民委员会意见</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>被送养儿童成长情况报告复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>《被送养儿童成长状况表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>被收养人同意被收养的声明及公证</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>收养人基本情况表</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>跨国收养申请书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>出生证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>婚姻状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>职业证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>经济收入和财产状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>身体健康检查证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>有无受过刑事处罚的证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>家庭情况报告及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>收养人护照复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>收养人申请文件原件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>照片</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue=""/>张</td>
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
					if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>《涉外送养通知》（副本） </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>《来华收养子女通知书》（副本）</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>《征求收养意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>《征求收养人意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>《涉外送养审查意见表》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>转移监护权协议</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>生父母或其他监护人同意送养的书面意见</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>死亡或下落不明一方生父母的父母不行使优先抚养权的声明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>其他有抚养义务的人同意送养的书面意见</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>被收养人生父或生母死亡或宣告死亡证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>被收养人生父母有特殊困难无力抚养的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>被收养人同意被收养的声明及公证书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>《被收养儿童体格检查表》及化验检查报告单复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>被收养儿童成长情况报告复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>《被送养儿童成长状况表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>收养人基本情况表</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>跨国收养申请书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>出生证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>婚姻状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>职业证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>经济收入和财产状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>身体健康检查证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>有无受过刑事处罚的证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>家庭情况报告及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>收养人护照复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>收养人申请文件原件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">29</td>
						<td>照片</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE29_NUM" defaultValue=""/>张</td>
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
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>《来华收养子女通知书》（副本）</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>《征求收养意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>《征求收养人意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>《涉外送养审查意见表》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>送养人居民身份证复印件、送养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="3" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>《被收养人体格检查表》及化验检查报告单复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>送养人与当地计划生育部门签订的不违反计划生育规定的协议</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>送养人与被收养人的亲属关系证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>送养人与收养人的亲属关系证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>被收养人是收养人三代以内旁系血亲的子女亲属关系证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>送养人同意送养的声明及公证</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>送养人结婚证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>收养人与被收养人生父或生母结婚的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>被收养人自愿被收养的声明及公证书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>生父母死亡证明及监护人同意送养的声明及公证书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>收养人基本情况表</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>跨国收养申请书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>出生证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>婚姻状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>职业证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>经济收入和财产状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>身体健康检查证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>有无受过刑事处罚的证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>家庭情况报告及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>收养人护照复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>收养人申请文件原件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">29</td>
						<td>照片</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE29_NUM" defaultValue=""/>张</td>
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
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>《来华收养子女通知书》（副本）</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>《征求收养意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>《征求收养人意见书》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>《涉外送养审查意见表》</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>送养人居民身份证复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>被收养人户籍证明复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>撤消被送养儿童生父母监护资格判决书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>《社会福利机构接收弃婴入院登记表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>其他有抚养义务的人放弃监护权及同意送养的书面意见</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>《被送养儿童体格检查表》及化验检查报告单复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>被送养儿童成长情况报告复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>《被送养儿童成长状况表》复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>被送养儿童同意被收养的声明及公证</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>收养人基本情况表</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>跨国收养申请书</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>出生证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>婚姻状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>职业证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>经济收入和财产状况证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>身体健康检查证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>有无受过刑事处罚的证明及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>收养人所在国主管机关同意其跨国收养子女的证明</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>家庭情况报告及附件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>收养人申请文件原件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>收养人护照复印件</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>照片</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue=""/>张</td>
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
				<table style="width: 50%;margin-top: 10px;" align="center">
					<tr>
						<td>立卷日期：<BZ:dataValue field="FILING_DATE" defaultValue="" type="date"/></td>
						<td style="text-align: right;">立卷人：<BZ:dataValue field="FILING_USERNAME" defaultValue="" /></td>
					</tr>
				</table>
			</div>
			<div id="tab2">
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>文件基本信息</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">国家</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/>
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
									<td class="edit-data-title">文件类型</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/>
									</td>
									<td class="edit-data-title">收养类型</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">来华领养通知书编号</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">签批日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养登记状态</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ADREG_STATE" defaultValue="" checkValue="0=未登记;1=已登记;2=无效登记;3=注销;" />
									</td>
									<td class="edit-data-title">收养登记日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ADREG_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">档案号</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ARCHIVE_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title"></td>
									<td class="edit-data-value">
										<BZ:dataValue field="" defaultValue=""/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>收养人情况</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">男收养人</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="MALE_NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId='<BZ:dataValue field="MALE_PHOTO" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
										<%} %>
									</td>
									<td class="edit-data-title" width="15%">女收养人</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId='<BZ:dataValue field="FEMALE_PHOTO" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">国籍</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ"/>
										<%} %>
									</td>
									<td class="edit-data-title">国籍</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ"/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date"/>
										<%} %>
									</td>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date"/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">职业</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_JOB_CN" defaultValue=""/>
										<%} %>
									</td>
									<td class="edit-data-title">职业</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">健康状况</td>
									<td class="edit-data-value" colspan="2">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH"/>
										<%} %>
									</td>
									<td class="edit-data-title">健康状况</td>
									<td class="edit-data-value" colspan="2">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH"/>
										<%} %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>被收养人情况</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">儿童姓名</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId='<BZ:dataValue field="PHOTO_CARD" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
									</td>
									<td class="edit-data-title" width="15%">姓名拼音</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="NAME_PINYIN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">性别</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SEX" defaultValue="" codeName="ETXB"/>
									</td>
									<td class="edit-data-title">省份</td>
									<td class="edit-data-value">
										<BZ:dataValue field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
										<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date"/>
									</td>
									<td class="edit-data-title">福利院</td>
									<td class="edit-data-value">
										<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">病残种类</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
									</td>
									<td class="edit-data-title">儿童身份</td>
									<td class="edit-data-value">
										<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='panel-container'>
			<table class="specialtable">
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>归档立卷</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<td class="edit-data-title" width="15%">立卷人</td>
								<td class="edit-data-value" width="35%">
									<BZ:input prefix="AI_" field="FILING_USERNAME" defaultValue="" formTitle="立卷人"/>
								</td>
								<td class="edit-data-title" width="15%">立卷日期</td>
								<td class="edit-data-value" width="35%">
									<BZ:input prefix="AI_" field="FILING_DATE" defaultValue="" type="date" formTitle="立卷日期"/>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">备注</td>
								<td class="edit-data-value" colspan="3">
									<BZ:input prefix="AI_" field="FILING_REMARKS" defaultValue="" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<input type="button" value="归&nbsp;&nbsp;&nbsp;档" class="btn btn-sm btn-primary" onclick="_saveFiling()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>