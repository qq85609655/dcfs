<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_lockhistory_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>����������Ϣ</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
	</BZ:head>
	<script>
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		function _showYPInfo(ypid){
			var url = path+"sce/preapproveapply/PreApproveApplyShowForFBGL.action?type=show&RI_ID="+ypid;
			window.open(url,"Ԥ��������Ϣ","");
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG">
		<BZ:form name="srcForm" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		
		
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width:5%;">
									<div class="sorting_disabled" id="COUNTRY_CODE">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="ADOPT_ORG_NAME_CN">������֯</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled" id="LOCK_DATE">����ʱ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="UNLOCKER_DATE">�����������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="UNLOCKER_TYPE">�����������</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="UNLOCKER_REASON">�������ԭ��</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="UNLOCKER_NAME">�����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="REQ_NO">Ԥ�����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="RI_STATE">Ԥ��״̬</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FEMALE_NAME">Ů������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY" /></td>
								<td><BZ:data field="ADOPT_ORG_ID" defaultValue="" codeName="SYS_ADOPT_ORG" onlyValue="true"/></td>
								<td><BZ:data field="LOCK_DATE" defaultValue="" type="DateTime" onlyValue="true"/></td>
								<td><BZ:data field="UNLOCKER_DATE" defaultValue=""  type="DateTime"  onlyValue="true" /></td>
								<td><BZ:data field="UNLOCKER_TYPE" defaultValue="" checkValue="0=���ڽ���;1=��֯����;2=���Ľ���" onlyValue="true"/></td>
								<td><BZ:data field="UNLOCKER_REASON" defaultValue="" length="20" /></td>
								<td><BZ:data field="UNLOCKER_NAME" defaultValue="" onlyValue="true"/></td>
								<td><a href="#" onclick="_showYPInfo('<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>');return false;" > <BZ:data field="REQ_NO" defaultValue=""  onlyValue="true"/></a></td>
								<td><BZ:data field="RI_STATE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"  /></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>