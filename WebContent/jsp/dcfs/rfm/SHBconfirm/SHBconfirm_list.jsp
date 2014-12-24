<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: SHBconfirm_list.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-9-28 ����11:01:09 
 * @version V1.0   
 */
 //1 ��ȡ�����ֶΡ���������(ASC DESC)
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}
%>
<BZ:html>
	<BZ:head>
		<title>����ȷ���б�</title>
		<BZ:webScript list="true"/>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"rfm/SHBconfirm/SHBconfirmList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_APPLE_DATE_START").value = "";
			document.getElementById("S_APPLE_DATE_END").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_RETREAT_DATE_START").value = "";
			document.getElementById("S_RETREAT_DATE_END").value = "";
			document.getElementById("S_RETURN_STATE").value = "";
			document.getElementById("S_HANDLE_TYPE").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
		}
		
		//����ȷ��ҳ��
		function _confirm(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[2];
				if(arrays[i].checked){
					if(state != "0"){
						alert("��ѡ���ȷ�ϵ�������Ϣ��");
						return;
					}else{
						showuuid = arrays[i].value.split("#")[0];
						num ++;
					}
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				document.srcForm.action=path+"rfm/SHBconfirm/confirmShow.action?showuuid="+showuuid;
				document.srcForm.submit();
			}
		}
		
		//�鿴������ϸ��Ϣ
		function _show(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴���ļ���");
				return;
			}else{
				window.open(path + "rfm/SHBconfirm/showReturnFile.action?showuuid=" + showuuid,"newwindow","height=460,width=1000,top=70,left=180,scrollbars=yes");
			}
		}
		
		//ȡ��������Ϣ����
		function _cancel(){
			var num = 0;
			var deleteuuid = [];
			var fileuuid = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].value.split("#")[2];
				if(arrays[i].checked){
					if(state == "0"){
						deleteuuid[num++] = arrays[i].value.split("#")[0];
						fileuuid[num++] = arrays[i].value.split("#")[1];
					}else{
						page.alert("ֻ��ȡ����ȷ�ϵ�������Ϣ��");
						return;
					}
				}
			}
			if(num < 1){
				page.alert('��ѡ��Ҫȡ����������Ϣ��');
				return;
			}else{
				if (confirm("ȷ��ȡ��ѡ���������Ϣ��")){
					document.getElementById("deleteuuid").value = deleteuuid.join("#");
					document.getElementById("fileuuid").value = fileuuid.join("#");
					document.srcForm.action=path+"rfm/SHBconfirm/returnFileDelete.action";
					document.srcForm.submit();
				}
			}
		}
		
		//����ȷ���б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		
	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;TWCZFS_ALL;WJWZ">
		<BZ:form name="srcForm" method="post" action="rfm/SHBconfirm/SHBconfirmList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="fileuuid" name="fileuuid" value=""/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">���ı��</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">�ļ�����</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" />
								</td>
								
								<td class="bz-search-title">����ʽ</td>
								<td>
									<BZ:select prefix="S_" field="HANDLE_TYPE" id="S_HANDLE_TYPE" isCode="true" codeName="TWCZFS_ALL" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="APPLE_DATE_START" id="S_APPLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="APPLE_DATE_END" id="S_APPLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="93%"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="89%"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="RETURN_STATE" id="S_RETURN_STATE" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��ȷ��</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
										<BZ:option value="2">������</BZ:option>
										<BZ:option value="3">�Ѵ���</BZ:option>
										<BZ:option value="9">ȡ������</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">ȷ������</td>
								<td>
									<BZ:input prefix="S_" field="RETREAT_DATE_START" id="S_RETREAT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_RETREAT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="RETREAT_DATE_END" id="S_RETREAT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_RETREAT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
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
					<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_confirm()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="ȡ������" class="btn btn-sm btn-primary" onclick="_cancel()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADOPT_ORG_ID">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="APPLE_DATE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="HANDLE_TYPE">����ʽ</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="RETREAT_DATE">ȷ������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AR_ID" onlyValue="true"/>#<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="RETURN_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="APPLE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" codeName="TWCZFS_ALL" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="RETREAT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" onlyValue="true" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���;9=ȡ������"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="����ȷ����Ϣ" exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;APPLE_DATE=DATE;HANDLE_TYPE=CODE,TWCZFS_ALL;RETREAT_DATE=DATE;RETURN_STATE=FLAG,0:��ȷ��&1:��ȷ��&2:������&3:�Ѵ���&9:ȡ������;" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;FILE_TYPE=�ļ�����,15;APPLE_DATE=��������,15;HANDLE_TYPE=���Ĵ��÷�ʽ,15;RETREAT_DATE=ȷ������,15;RETURN_STATE=����״̬,15;"/></td>
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