<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	/**   
	 * @Title: childAddition_list_fromAZB.jsp
	 * @Description:  ��ͯ���ϲ����ѯ(���ò�)
	 * @author furx   
	 * @date 2014-9-11  17:50:34 
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
	Data da = (Data)request.getAttribute("data");
    String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���ϲ����ѯ(���ò�)</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"cms/childaddition/findListFromAZB.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_CA_STATUS").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
		}	
		//�鿴���������ϸ��Ϣ
		function _showDetail(){
			var num = 0;
			var CA_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					 CA_ID =arrays[i].value.split("#")[0];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴�Ĳ��ϣ�");
				return;
			}else{
				var url = path + "cms/childaddition/getShowData.action?UUID="+CA_ID;
				//window.open(url,"window",'height=450,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				_open(url, "window", 1000, 500);
			}
		}

		//����Ժ��ͯ���ϲ����б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//ʡ������Ժ��ѯ�����������跽��
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=WELFARE_ID%>';
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
			}
		}
		//ʡ������Ժ��ѯ�����������跽��
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
		
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;PROVINCE;CHILD_TYPE;">
		<BZ:form name="srcForm" method="post" action="cms/childaddition/findListFromAZB.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
							    <td class="bz-search-title" style="width: 10%">ʡ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
								   	<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								 </td>
								
								<td class="bz-search-title" style="width: 12%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
								</td>
								
	                            <td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >��&nbsp;��&nbsp;Ժ</td>
								<td >
									<BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					               </BZ:select>
								</td>	
								
							    <td class="bz-search-title">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td >
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>

								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">��ͯ����</td>
								<td>
								   <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="" width="100%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="CA_STATUS" id="S_CA_STATUS" formTitle="" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�Ѳ���</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">֪ͨ����</td>
								<td >
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ����֪ͨ����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ����֪ͨ����" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_showDetail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="NOTICE_DATE">֪ͨ����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEEDBACK_DATE">��������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="CA_STATUS">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CA_ID" onlyValue="true"/>#<BZ:data field="CA_STATUS" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
							    <td><BZ:data field="WELFARE_NAME_CN" defaultValue=""  onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CA_STATUS" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="��ͯ���ϲ����ѯ" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;CA_STATUS=FLAG,0:������&1:������&2:�Ѳ���;" exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,20;NAME=����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;CHILD_TYPE=��ͯ����,15;SN_TYPE=��������,15;NOTICE_DATE=֪ͨ����,15;FEEDBACK_DATE=��������,15;CA_STATUS=����״̬,15;"/></td>
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