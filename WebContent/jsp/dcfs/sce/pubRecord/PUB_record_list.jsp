<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: ���ò��㷢�˻��б�
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
%>
<BZ:html>
	<BZ:head>
		<title>�㷢�˻��б�</title>
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
		//����
		function _export(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//�鿴
		function _detail(){
			var num = 0;
			var ids="";
			var id ="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
			   document.srcForm.action=path+"record/PUBCheck.action?id="+id;
			   document.srcForm.submit();
			}
		}
		//ȷ��
		function _confirm(){
			var num = 0;
			var ids="";
			var id = "" ;
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					id+= ids.split(",")[0]+",";
					state = ids.split(",")[1];
					if(state!=0){
						num+=1;
						page.alert('��ѡ���ȷ�ϵ�����');
						return ;
					}
				}
			}
			if(num!=0){
				return ;
			}else{
			    document.srcForm.action=path+"record/PUBConfirm.action?id="+id;
			    document.srcForm.submit();
			}
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"record/PUBRecordList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("C_PROVINCE_ID").value = "";
			document.getElementById("C_WELFARE_NAME_CN").value = "";
			document.getElementById("C_NAME").value = "";
			document.getElementById("C_SEX").value = "";
			document.getElementById("C_BIRTHDAY_START").value = "";
			document.getElementById("C_BIRTHDAY_END").value = "";
			document.getElementById("C_SN_TYPE").value = "";
			document.getElementById("C_SPECIAL_FOCUS").value = "";
			document.getElementById("C_PUB_DATE_START").value = "";
			document.getElementById("C_PUB_DATE_END").value = "";
			document.getElementById("C_PUB_MODE").value = "";
			document.getElementById("C_RETURN_TYPE").value = "";
			document.getElementById("C_PUB_ORGID").value = "";
			document.getElementById("C_RETURN_DATE_START").value = "";
			document.getElementById("C_RETURN_DATE_END").value = "";
			document.getElementById("C_RETURN_CFM_DATE_START").value = "";
			document.getElementById("C_RETURN_CFM_DATE_END").value = "";
			document.getElementById("C_RETURN_STATE").value = "";
			document.getElementById("C_PUB_TYPE").value = "";
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;">
		<BZ:form name="srcForm"  method="post" action="record/PUBRecordList.action">
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
								<td class="bz-search-title" style="width: 8%;">ʡ��</td>
								<td style="width: 18%;">
									<BZ:select prefix="C_" field="PROVINCE_ID" id="C_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">����Ժ</td>
								<td style="width: 28%;">
									<BZ:input prefix="C_" field="WELFARE_NAME_CN" id="C_WELFARE_NAME_CN" defaultValue="" formTitle="����Ժ" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">����</td>
								<td style="width: 28%;">
									<BZ:input prefix="C_" field="NAME" id="C_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="C_" field="SEX" id="C_SEX" isCode="true" codeName="ADOPTER_CHILDREN_SEX" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="C_" field="SN_TYPE" id="C_SN_TYPE" isCode="true" codeName="BCZL"  formTitle="��������" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�ر��ע</td>
								<td>
									<BZ:select prefix="C_" field="SPECIAL_FOCUS" id="C_SPECIAL_FOCUS"  formTitle="�ر��ע" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�㷢����</td>
								<td>
									<BZ:select prefix="C_" field="PUB_MODE" id="C_PUB_MODE" isCode="true" codeName="DFLX"  formTitle="�㷢����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�˻�����</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_TYPE" id="C_RETURN_TYPE" isCode="true" codeName="TXRTFBTHLX"  formTitle="�˻�����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�˻���֯</td>
								<td>
									<BZ:input prefix="C_" field="PUB_ORGID" id="C_PUB_ORGID" defaultValue="" formTitle="�˻���֯" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="BIRTHDAY_START" id="C_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="C_" field="BIRTHDAY_END" id="C_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="C_" field="PUB_DATE_START" id="C_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_PUB_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="C_" field="PUB_DATE_END" id="C_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_PUB_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�˻�����</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="RETURN_DATE_START" id="C_RETURN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�˻�����" />~
									<BZ:input prefix="C_" field="RETURN_DATE_END" id="C_RETURN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�˻�����" />
								</td>
								<td class="bz-search-title">ȷ������</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_START" id="C_RETURN_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼȷ������" />~
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_END" id="C_RETURN_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹȷ������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�˻�״̬</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_STATE" id="C_RETURN_STATE" formTitle="�˻�״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��ȷ��</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="C_" field="PUB_TYPE" id="C_PUB_TYPE" formTitle="��������" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">�㷢</BZ:option>
										<BZ:option value="2">Ⱥ��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"></td>
								<td></td>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" style="word-break:break-all; overflow:auto;"  adsorb="both" init="true" id="sample-table">
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
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PUB_DATE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PUB_MODE">�㷢����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="RETURN_TYPE">�˻�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="RETURN_USERNAME">�˻���֯</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_DATE">�˻�����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_CFM_DATE">ȷ������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">�˻�״̬</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PUB_TYPE">��������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="PUB_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="RETURN_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��;" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_MODE" defaultValue="" codeName="DFLX" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_TYPE" defaultValue="" codeName="TXRTFBTHLX" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_CFM_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=��ȷ��;1=��ȷ��;" onlyValue="true"/></td>
								<td><BZ:data field="PUB_TYPE" defaultValue="" checkValue="1=�㷢;2=Ⱥ��;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�㷢�˻ؼ�¼" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;SPECIAL_FOCUS=FLAG,0:��&1:��;PUB_DATE=DATE;PUB_MODE=CODE,DFLX;RETURN_TYPE=CODE,TXRTFBTHLX;PUB_ORGID=CODE,SYZZ;RETURN_DATE=DATE;RETURN_CFM_DATE=DATE;RETURN_STATE=FLAG,0:��ȷ��&1:��ȷ��;" exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,15;NAME=����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;SN_TYPE=��������,15;SPECIAL_FOCUS=�ر��ע,15;PUB_DATE=��������,15;PUB_MODE=�㷢����,15;RETURN_TYPE=�˻�����,15;PUB_ORGID=�˻���֯,15;RETURN_DATE=�˻�����,15;RETURN_CFM_DATE=ȷ������,15;RETURN_STATE=�˻�״̬,15;"/>
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