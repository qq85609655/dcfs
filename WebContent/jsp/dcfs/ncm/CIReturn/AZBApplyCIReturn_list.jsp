<%
/**   
 * @Title: AZBApplyCIReturn_list.jsp
 * @Description: ���ò����������˻��б�
 * @author xugy
 * @date 2014-12-16����8:00:32
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head>
		<title>���������˻��б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"childInfoReturn/AZBApplyCIReturnList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_APPLY_USER").value = "";
			document.getElementById("S_APPLY_DATE_START").value = "";
			document.getElementById("S_APPLY_DATE_END").value = "";
			document.getElementById("S_CONFIRM_DATE_START").value = "";
			document.getElementById("S_CONFIRM_DATE_END").value = "";
			document.getElementById("S_APPLY_STATE").value = "";
			document.getElementById("S_CONFIRM_STATE").value = "";
		}
		
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
			}
		}
		//����
		function _apply(){
			window.open(path + "childInfoReturn/AZBSelectDABCIList.action","",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
		//
		function _addApply(ids){
			document.getElementById("ids").value = ids;
			document.srcForm.action=path+"childInfoReturn/toAZBApplyCIReturnAdd.action";
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;BCZL;">
		<BZ:form name="srcForm" method="post" action="childInfoReturn/AZBApplyCIReturnList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">ʡ��</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����Ժ</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" defaultValue="" width="148px" formTitle="�Ա�">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							
								<td class="bz-search-title">��ͯ����</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" defaultValue="" width="148px" formTitle="��ͯ����">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" defaultValue="" width="148px" formTitle="��������">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">������</td>
								<td>
									<BZ:input prefix="S_" field="APPLY_USER" id="S_APPLY_USER" defaultValue="" formTitle="������" maxlength="" />
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="APPLY_DATE_START" id="S_APPLY_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLY_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="APPLY_DATE_END" id="S_APPLY_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLY_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ȷ������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="CONFIRM_DATE_START" id="S_CONFIRM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼȷ������" />~
									<BZ:input prefix="S_" field="CONFIRM_DATE_END" id="S_CONFIRM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹȷ������" />
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="APPLY_STATE" id="S_APPLY_STATE" defaultValue="" width="148px" formTitle="����״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
										<BZ:option value="2">��ȷ��</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ȷ�Ͻ��</td>
								<td>
									<BZ:select prefix="S_" field="CONFIRM_STATE" id="S_CONFIRM_STATE" width="148px" formTitle="ȷ�Ͻ��" defaultValue="0">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">ͬ��</BZ:option>
										<BZ:option value="2">��ͬ��</BZ:option>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_apply()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<!-- <th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th> -->
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="APPLY_USER">������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="APPLY_DATE">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CONFIRM_DATE">ȷ������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="APPLY_STATE">����״̬</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CONFIRM_STATE">ȷ�Ͻ��</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<%-- <td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="" defaultValue="" onlyValue="true"/>" class="ace">
								</td> --%>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL"/></td>
								<td><BZ:data field="APPLY_USER" defaultValue=""/></td>
								<td><BZ:data field="APPLY_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="CONFIRM_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="APPLY_STATE" defaultValue="" checkValue="1=��ȷ��;2=��ȷ��;"/></td>
								<td><BZ:data field="CONFIRM_STATE" defaultValue="" checkValue="1=ͬ��;2=��ͬ��;"/></td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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