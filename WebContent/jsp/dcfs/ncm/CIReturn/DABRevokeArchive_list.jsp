<%
/**   
 * @Title: DABRevokeArchive_list.jsp
 * @Description: ���������������б�
 * @author xugy
 * @date 2014-12-17����1:57:32
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
		<title>���������������б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1900,1900);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
				area: ['1050px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"childInfoReturn/DABRevokeArchiveList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_ARCHIVE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_ARCHIVE_STATE").value = "";
			document.getElementById("S_CONFIRM_USER").value = "";
			document.getElementById("S_CONFIRM_DATE_START").value = "";
			document.getElementById("S_CONFIRM_DATE_END").value = "";
			document.getElementById("S_APPLY_STATE").value = "";
			document.getElementById("S_NAME").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
		//
		function _confirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var APPLY_STATE = ids.split(",")[2];
					if(APPLY_STATE != "1"){
						page.alert("��ѡ���ȷ�ϵ�����");
						return;
					}
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ����ȷ�ϵ�����');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"childInfoReturn/toDABRevokeArchiveAdd.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="childInfoReturn/DABRevokeArchiveList.action">
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
								<td class="bz-search-title">������</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="������" maxlength="" />
								</td>
								
								<td class="bz-search-title">ǩ����</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="ǩ����" maxlength="" />
								</td>
								
								<td class="bz-search-title">ǩ������</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼǩ������" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹǩ������" />
								</td>
							</tr>
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
								
								<td class="bz-search-title">��ͯ����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�ļ����</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="�ļ����" maxlength="" />
								</td>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
								
								<td class="bz-search-title">�鵵״̬</td>
								<td>
									<BZ:select prefix="S_" field="ARCHIVE_STATE" id="S_ARCHIVE_STATE" formTitle="�鵵״̬" width="148px" defaultValue="">
										<option value="">--��ѡ��--</option>
										<option value="0">δ�鵵</option>
										<option value="1">�ѹ鵵</option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ȷ����</td>
								<td>
									<BZ:input prefix="S_" field="CONFIRM_USER" id="S_CONFIRM_USER" defaultValue="" formTitle="ȷ����" maxlength="" />
								</td>
								
								<td class="bz-search-title">ȷ������</td>
								<td>
									<BZ:input prefix="S_" field="CONFIRM_DATE_START" id="S_CONFIRM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼȷ������" />~
									<BZ:input prefix="S_" field="CONFIRM_DATE_END" id="S_CONFIRM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CONFIRM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹȷ������" />
								</td>
								
								<td class="bz-search-title">ȷ��״̬</td>
								<td>
									<BZ:select prefix="S_" field="APPLY_STATE" id="S_APPLY_STATE" defaultValue="" width="148px" formTitle="ȷ��״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
										<BZ:option value="2">��ȷ��</BZ:option>
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
					<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_NO">������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SIGN_NO">ǩ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">ǩ������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">�ļ����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ARCHIVE_STATE">�鵵״̬</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="CONFIRM_USER">ȷ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="CONFIRM_DATE">ȷ������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="APPLY_STATE">ȷ��״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="NAR_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="APPLY_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center"><BZ:i/></td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue=""/></td>
								<td><BZ:data field="SIGN_NO" defaultValue=""/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="ARCHIVE_STATE" defaultValue="" checkValue="0=δ�鵵;1=�ѹ鵵;"/></td>
								<td><BZ:data field="CONFIRM_USER" defaultValue=""/></td>
								<td><BZ:data field="CONFIRM_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="APPLY_STATE" defaultValue="" checkValue="1=��ȷ��;2=��ȷ��;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
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