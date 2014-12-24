<%
/**   
 * @Title: DAB_PP_feedback_record_detail.jsp
 * @Description: 历次安置后报告查看
 * @author xugy
 * @date 2014-11-4下午6:05:23
 * @version V1.0
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data = (Data)request.getAttribute("data");
DataList dl = (DataList)request.getAttribute("dl");
Data photoData = (Data)request.getAttribute("photoData");

String ADUIT_STATE = data.getString("ADUIT_STATE","");
%>
<BZ:html>
<BZ:head>
	<title>历次安置后报告查看</title>
	<BZ:webScript edit="true" tree="true"/>
	
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});

function _show(path){
	parent._showPhoto(path);
}
</script>
<BZ:body property="data" codeNames="SYRGS;RHQK;JKZK_AZHBG;SGPJ;">
	<%
	if(!"".equals(ADUIT_STATE)){
	%>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告情况</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">安置反馈次数</td>
						<td class="bz-edit-data-value" width="35%">
							第<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>次
						</td>
						<td class="bz-edit-data-title" width="15%">上次安置反馈日期</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="LAST_REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">报告提交日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REPORT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">报告接收日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECEIVE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">制作报告组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">社工家访日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="VISIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养关系有无重大变故</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ACCIDENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=不融合;2=更换家庭;3=死亡;9=其他;"/>
						</td>
						<td class="bz-edit-data-title">报告完成日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FINISH_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">本报告可否用于宣传</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="IS_PUBLIC" defaultValue="" onlyValue="true" checkValue="0=是;1=否;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">报告翻译单位</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_COMPANY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">翻译日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TRANSLATION_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告附件</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="45%" />
						<col width="45%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-title" style="text-align: center;">原文</td>
						<td class="bz-edit-data-title" style="text-align: center;">中文</td>
					</tr>
					<%
					for(int i=0;i<dl.size();i++){
					    String CNAME = dl.getData(i).getString("CNAME");
					    DataList ATTDL = (DataList)dl.getData(i).get("ATTDL");
					%>
					<tr>
						<td class="bz-edit-data-title">
							<%=CNAME %>
						</td>
						<td class="bz-edit-data-value">
						<%
						if(ATTDL.size()>0){
						%>
							<table class="attlisttable">
						<%
						    for(int j=0;j<ATTDL.size();j++){
						        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
						        String ID = ATTDL.getData(j).getString("ID");
						        String ATT_TYPE = ATTDL.getData(j).getString("ATT_TYPE");
						        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
						%>
								<tr>
									<td width="5%"><%=j+1%>.</td>
									<td width="70%"><%=ATT_NAME%></td>
									<td width="25%">&nbsp;
										<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
										<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
									</td>
								</tr>
						<%
							}
						%>
							</table>
						<%
						}
						%>
						</td>
						<td class="bz-edit-data-value">
						<%
						    DataList ATTCNDL = (DataList)dl.getData(i).get("ATTCNDL");
						    if(ATTCNDL.size()>0){
						%>
								<table class="attlisttable">
						<%
							    for(int j=0;j<ATTCNDL.size();j++){
							        String ATT_NAME = ATTCNDL.getData(j).getString("ATT_NAME");
							        String ID = ATTCNDL.getData(j).getString("ID");
							        String ATT_TYPE = ATTCNDL.getData(j).getString("ATT_TYPE");
							        String viewUrl = path + "/jsp/dcfs/common/webofficeView.jsp?name="+ATT_NAME+"&attId="+ID+"&attTypeCode=AR&type="+ATT_TYPE;
						%>
								<tr>
									<td width="5%"><%=j+1%>.</td>
									<td width="70%"><%=ATT_NAME%></td>
									<td width="25%">&nbsp;
										<a href="<%=viewUrl%>" target="blank"><img src="<%=path%>/resource/images/bs_gray_icons/zoom-in.png" width="14"> </a>|
										<a href="<up:attDownload attTypeCode="AR" attId='<%=ID%>'/>"><img src="<%=path%>/resource/images/bs_gray_icons/download-alt.png" width="14"></img></a>
									</td>
								</tr>
						<%
							    }
						%>
							</table>
						<%
						    }
						%>
						</td>
					</tr>
					<%
					}
					if(!photoData.isEmpty()){
					    String CNAME = photoData.getString("CNAME");
					    DataList ATTDL = (DataList)photoData.get("ATTDL");
					%>
					<tr>
						<td class="bz-edit-data-title">
							<%=CNAME %>
						</td>
						<td class="bz-edit-data-value" colspan="2">
						<%
						if(ATTDL.size()>0){
						    for(int j=0;j<ATTDL.size();j++){
						        String ATT_NAME = ATTDL.getData(j).getString("ATT_NAME");
						        String ID = ATTDL.getData(j).getString("ID");
						        String DES_EN = ATTDL.getData(j).getString("DES_EN","");
						        String DES_CN = ATTDL.getData(j).getString("DES_CN","");
						        
						%>
							<div style="width: 275px;float: left;margin: 5px;text-align: center;">
								<img alt="<%= ATT_NAME %>" style="cursor: pointer;text-align: center;" src="<%= path %>/feedback/showThumbnail.action?ATT_TABLE=ATT_AR&ID=<%= ID %>" onclick="_show('<%= path %>/feedback/showPicture.action?ATT_TABLE=ATT_AR&ID=<%= ID %>')">
								<table class="bz-edit-data-table" style="border-right: 1px #ddd solid;">
									<tr>
										<td class="bz-edit-data-title" width="35%">照片描述</td>
										<td class="bz-edit-data-value" width="65%">
											<%= DES_EN %>
										</td>
									</tr>
									<tr>
										<td class="bz-edit-data-title">描述翻译</td>
										<td class="bz-edit-data-value">
											<%= DES_CN %>
										</td>
									</tr>
								</table>
							</div>
						<%
							}
						}
						%>
						</td>
					</tr>
					<%} %>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>被收养儿童国外生活成长状况评估</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收养人感受</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEELING_CN" defaultValue="" onlyValue="true" codeName="SYRGS"/>
						</td>
						<td class="bz-edit-data-title" width="15%">融合情况</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FUSION_CN" defaultValue="" onlyValue="true" codeName="RHQK"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">健康状况</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEALTHY_CN" defaultValue="" onlyValue="true" codeName="JKZK_AZHBG"/>
						</td>
						<td class="bz-edit-data-title">社工评价</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EVALUATION_CN" defaultValue="" onlyValue="true" codeName="SGPJ"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>安置后报告评价</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">审核意见</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=继续跟踪;1=重点跟踪;2=结束跟踪;3=补充文件;"/>
						</td>
						<td class="bz-edit-data-title" width="15%"></td>
						<td class="bz-edit-data-value" width="35%"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核意见</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<%-- <tr>
						<td class="bz-edit-data-title">审核意见（英文）</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_CONTENT_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr> --%>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="AUDIT_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">审核日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUDIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<%  
	}else{
	%>
	<div style="text-align: center;"><font size="20"><b>没有这次安置后报告的信息</b></font></div>
	<%} %>
</BZ:body>
</BZ:html>
