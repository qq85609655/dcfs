<%
/**   
 * @Title: preapproveapply_view.jsp
 * @Description:  Ԥ��������Ϣ�鿴ҳ��
 * @author yangrt   
 * @date 2014-9-16 ����19:23:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String ri_id = (String)request.getAttribute("RI_ID");
	String af_id = (String)request.getAttribute("AF_ID");
	String flag = (String)request.getAttribute("Flag");
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ��������Ϣ�鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
		});
		
		 
		
		//Tabҳjs
		function change(flag){
			if(flag==1){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoEN&type=show";
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").show();
			}	
			if(flag==2){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planEN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="active";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==3){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planCN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="active";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==4){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionEN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="active";
				document.getElementById("act5").className="";
				$("#topinfo").hide();
			}
			if(flag==5){
				document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionCN&type=show";
				document.getElementById("act1").className="";
				document.getElementById("act2").className="";
				document.getElementById("act3").className="";
				document.getElementById("act4").className="";
				document.getElementById("act5").className="active";
				$("#topinfo").hide();
			}
		}
		
		//�����б�ҳ
		function _goback(){
			window.close();
		}
	</script>
	<BZ:body property="applydata" codeNames="SYLX;WJLX;GJSY;SDFS;PROVINCE;ETXB;BCZL;">
		<!-- Tab��ǩҳbegin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">�����˻������</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">�����ƻ�(��)</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">�����ƻ�(��)</a>
					</li>
					<li id="act4" class="">
						<a href="javascript:change(4);">��֯���(��)</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">��֯���(��)</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab��ǩҳend -->
		<!-- ������ʾ����begin -->
		<%
		if(!"".equals(af_id)){
		%>
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%" id="topinfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">������֯(CN)<br>Agency (CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������֯(EN)<br>Agency (EN)</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">���ı��<br>Log-in No.</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FILE_NO" property="filedata" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%">��������<br>Log-in date</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="REGISTER_DATE" property="filedata" defaultValue="" type="date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��������<br>Adoption type</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
							</td>
							<%-- <td class="bz-edit-data-title">�ļ�����<br>FILE TYPE</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
							</td> --%>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������ʽ<br>Locking type</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="LOCK_MODE" codeName="SDFS" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ǰ���ı��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">��ǰԤ����������<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<%-- <tr>
							<td class="bz-edit-data-title">����״̬<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_STATE" checkValue="0=��ȷ��;1=��ȷ��;" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">����ԭ��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr> --%>
					</table>
				</div>
			</div>
		</div>
		<%} %>
		<!-- ������ʾ����end -->
		<!-- iframe��ʾ����begin -->
		<div class="widget-box no-margin">
			<iframe id="iframe" onload="adjustIFramesHeightOnLoad(this)" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoEN&type=show" style="width:100%; height:px; frameborder="0"></iframe>
		</div>
		<!-- iframe��ʾ����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>