<%
/**   
 * @Title: recordStateOrganList.jsp
 * @Description:���������б�
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 // ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
	DataList countryList = (DataList)request.getAttribute("countryList");
%>

<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%><BZ:html>
	<BZ:head>
		<title>���������б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		
		//�鿴
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.srcForm.action=path+"mkr/organSupp/organRecordStateDetail.action?ID="+ids;
			    document.srcForm.submit();
			}
		}
		
		//�������
		function record_confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
			   document.srcForm.action=path+"mkr/organSupp/organRecordConfirm.action?ID="+ids;
			   document.srcForm.submit();
			}
		}
		
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"mkr/organSupp/organRecordStateList.action?page=1";
			document.srcForm.submit();
		}
		
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("MKR_COUNTY_NAME").value = "";
			document.getElementById("MKR_NAME_CN").value = "";
			document.getElementById("MKR_NAME_EN").value = "";
			document.getElementById("MKR_ORG_CODE").value = "";
			document.getElementById("MKR_IS_VALID").value = "";
			document.getElementById("MKR_FOUNDED_DATE_BEGIN").value = "";
			document.getElementById("MKR_FOUNDED_DATE_END").value = "";
			document.getElementById("MKR_RECORD_STATE").value = "";
		}
	</script>
	<BZ:body property="data" codeNames="ZZBASHZT">
		<BZ:form name="srcForm"  method="post" action="mkr/organSupp/organRecordStateList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">����</td>
								<td style="width: 18%;">
									<select id="MKR_COUNTY_NAME" name="MKR_COUNTY_NAME">
										<option value="">--��ѡ��--</option>
										<%
											if(countryList!=null && countryList.size()!=0){
												for(int i=0;i<countryList.size();i++){
													Data data = countryList.getData(i);
												%>
													<option value="<%=data.getString("NAME_CN")%>"><%=data.getString("NAME_CN")%></option>
												<%
												}
											}
										%>
									</select>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">��֯����</td>
								<td style="width: 28%;">
									<BZ:input prefix="MKR_" field="NAME_CN" id="MKR_NAME_CN" defaultValue="" formTitle="��֯����"  />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">Ӣ������</td>
								<td style="width: 28%;">
									<BZ:input prefix="MKR_" field="NAME_EN" id="MKR_NAME_EN" defaultValue="" formTitle="Ӣ������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="MKR_" field="ORG_CODE" id="MKR_ORG_CODE" defaultValue="" formTitle="��������" />
								</td>
								<td class="bz-search-title">�Ƿ���Ч</td>
								<td>
									<BZ:select prefix="MKR_" field="IS_VALID" id="MKR_IS_VALID"  formTitle="�Ƿ���Ч" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��Ч</BZ:option>
										<BZ:option value="1">��Ч</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����ʱ��</td>
								<td>
									<BZ:input prefix="MKR_" field="FOUNDED_DATE_BEGIN" id="MKR_FOUNDED_DATE_BEGIN" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'MKR_FOUNDED_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="MKR_" field="FOUNDED_DATE_END" id="MKR_FOUNDED_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'MKR_FOUNDED_DATE_BEGIN\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td colspan="5">
									<BZ:select field="RECORD_STATE" prefix="MKR_" id="MKR_RECORD_STATE" codeName="ZZBASHZT" isCode="true" formTitle="����״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="�������" class="btn btn-sm btn-primary" onclick="record_confirm()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<!-- <input type="checkbox" class="ace"> -->
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_NAME">����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="CNAME">��֯����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting" id="ENNAME">Ӣ������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ORG_CODE">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="RECORD_STATE">�Ƿ���Ч</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FOUNDED_DATE">����ʱ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="RECORD_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<BZ:for property="List">
								<tr class="emptyData">
									<td class="center">
										<input name="xuanze" type="radio" value="<BZ:data field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>" class="ace">
									</td>
									<td class="center">
										<BZ:i/>
									</td>
									<td><BZ:data field="COUNTRY_NAME" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="ENNAME" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="ORG_CODE" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="RECORD_STATE" defaultValue="" checkValue="0=��;1=��;2=��;3=��;4=��;" onlyValue="true"/></td>
									<td><BZ:data field="FOUNDED_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
									<td><BZ:data field="RECORD_STATE" defaultValue="" codeName="ZZBASHZT" onlyValue="true"/></td>
								</tr>
							</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td>
								<BZ:page form="srcForm" property="List" type="EN" />
							</td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>