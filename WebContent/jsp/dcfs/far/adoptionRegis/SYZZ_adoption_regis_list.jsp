<%
/**   
 * @Title: SYZZ_adoption_regis_list.jsp
 * @Description: ������֯�����Ǽ��б�
 * @author xugy
 * @date 2014-11-8����5:57:23
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
	<BZ:head language="EN">
		<title>������֯�����Ǽ��б�</title>
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
			_scroll(1500,1500);
			var str = document.getElementById("N_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����(Query condition)",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"adoptionRegis/SYZZAdoptionRegisList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("N_FILE_NO").value = "";
			document.getElementById("N_MALE_NAME").value = "";
			document.getElementById("N_FEMALE_NAME").value = "";
			document.getElementById("N_PROVINCE_ID").value = "";
			document.getElementById("N_WELFARE_ID").value = "";
			document.getElementById("N_NAME_PINYIN").value = "";
			document.getElementById("N_IS_CONVENTION_ADOPT").value = "";
			document.getElementById("N_SIGN_DATE_START").value = "";
			document.getElementById("N_SIGN_DATE_END").value = "";
			document.getElementById("N_SIGN_NO").value = "";
			document.getElementById("N_ADREG_DATE_START").value = "";
			document.getElementById("N_ADREG_DATE_END").value = "";
			document.getElementById("N_ADREG_STATE").value = "";
		}
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("N_WELFARE_ID").options.length=0;
				document.getElementById("N_WELFARE_ID").options.add(new Option("--Please select--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("N_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("N_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//���
				document.getElementById("N_WELFARE_ID").options.length=0;
				document.getElementById("N_WELFARE_ID").options.add(new Option("--Please select--",""));
			}
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
				alert('Please select one data ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"adoptionRegis/SYZZAdoptionRegisDetail.action";
				document.srcForm.submit();
			}
		}
		//����
		function _export(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;GJSY;SYZZ;">
		<BZ:form name="srcForm" method="post" action="adoptionRegis/SYZZAdoptionRegisList.action">
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
								<td class="bz-search-title">���ı��<br>Log-in No.</td>
								<td>
									<BZ:input prefix="N_" field="FILE_NO" id="N_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								<td class="bz-search-title">��������<br>Adoptive father</td>
								<td>
									<BZ:input prefix="N_" field="MALE_NAME" id="N_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
								<td class="bz-search-title">Ů������<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="N_" field="FEMALE_NAME" id="N_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">ʡ��<br>Province</td>
								<td>
									<BZ:select prefix="N_" field="PROVINCE_ID" id="N_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����Ժ<br>SWI</td>
								<td>
									<BZ:select prefix="N_" field="WELFARE_ID" id="N_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�Ǽ�����<br></td>
								<td>
									<BZ:input prefix="N_" field="ADREG_DATE_START" id="N_ADREG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'N_ADREG_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�Ǽ�����" />~
									<BZ:input prefix="N_" field="ADREG_DATE_END" id="N_ADREG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'N_ADREG_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�Ǽ�����" />
								</td>
							</tr>
							<tr>
								
							</tr>
							<tr>
								<td class="bz-search-title">����<br>Name</td>
								<td>
									<BZ:input prefix="N_" field="NAME_PINYIN" id="N_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ƿ�Լ����<br>Hague/Non-Hague adoption</td>
								<td>
									<BZ:select prefix="N_" field="IS_CONVENTION_ADOPT" id="N_IS_CONVENTION_ADOPT" width="148px" formTitle="��Լ����" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">no</BZ:option>
										<BZ:option value="1">yes</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">ǩ������<br>Date of approval</td>
								<td>
									<BZ:input prefix="N_" field="SIGN_DATE_START" id="N_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'N_SIGN_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼǩ������" />~
									<BZ:input prefix="N_" field="SIGN_DATE_END" id="N_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'N_SIGN_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹǩ������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">ǩ����<br>Application number</td>
								<td>
									<BZ:input prefix="N_" field="SIGN_NO" id="N_SIGN_NO" defaultValue="" formTitle="ǩ����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ǽ�״̬<br>Log-in status</td>
								<td>
									<BZ:select prefix="N_" field="ADREG_STATE" id="N_ADREG_STATE" width="148px" formTitle="�Ǽ�״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">δ�Ǽ�</BZ:option>
										<BZ:option value="1">�ѵǼ�</BZ:option>
										<BZ:option value="2">��Ч�Ǽ�</BZ:option>
										<BZ:option value="3">ע��</BZ:option>
										<BZ:option value="9">��Ч</BZ:option>
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
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
								<th style="width: 4%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width:5%;">
									<div class="sorting" id="FILE_NO">���ı��(Log-in No.)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">�з�(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů��(Adoptive mother)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��(Province)</div>
								</th>
								<th style="width: 18%;">
									<div class="sorting" id="WELFARE_NAME_EN">����Ժ(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">����(Name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="IS_CONVENTION_ADOPT">�Ƿ�Լ����(Hague/Non-Hague adoption)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SIGN_DATE">ǩ������(Date of approval)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="SIGN_NO">ǩ����(Application number)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="ADREG_DATE">�Ǽ�����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADREG_STATE">�Ǽ�״̬(Log-in status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" checkValue="0=No;1=Yes;"/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date" /></td>
								<td><BZ:data field="SIGN_NO" defaultValue=""/></td>
								<td><BZ:data field="ADREG_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ADREG_STATE" defaultValue="" checkValue="0=δ�Ǽ�;1=�ѵǼ�;2=��Ч�Ǽ�;3=ע��;9=��Ч;"/></td>
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
							<td>
								<BZ:page  isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="�����Ǽ�����" exportCode="PROVINCE_ID=CODE,PROVINCE;ADREG_STATE=FLAG,0:δ�Ǽ�&1:�ѵǼ�&2:��Ч�Ǽ�&3:ע��;SIGN_DATE=DATE;ADREG_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��(Log-in No.),15,20;MALE_NAME=�з�(Adoptive father),15;FEMALE_NAME=Ů��(Adoptive mother),15;PROVINCE_ID=ʡ��(Province),15;WELFARE_NAME_EN=����Ժ(SWI),20;NAME_PINYIN=����(Name),15;IS_CONVENTION_ADOPT=�Ƿ�Լ����(Hague/Non-Hague adoption),10;SIGN_DATE=ǩ������(Date of approval),15;SIGN_NO=ǩ����(Application number),15;ADREG_DATE=�Ǽ�����,15;ADREG_STATE=�Ǽ�״̬(Log-in status),15;"/>
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