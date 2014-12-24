<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: ����
 * @author xxx   
 * @date 2014-7-30 21:14:53
 * @version V1.0   
 */
  String compositor=(String)request.getAttribute("compositor");
  if(compositor==null){
      compositor="";
  }
  String ordertype=(String)request.getAttribute("ordertype");
  if(ordertype==null){
      ordertype="";
  }
  String TRANSFER_CODE=(String)request.getAttribute("TRANSFER_CODE");
  
  String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
  if("null".equals(mannualDeluuid) || mannualDeluuid == null){
	    mannualDeluuid = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>��ѯ�б�</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
  $(document).ready(function() {
  //			dyniframesize(['mainFrame']);
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
  });
 
 //��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1100px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function _search(){
     document.srcForm.action=path+"transferManager/MannualArchive.action?page=1";
	 document.srcForm.submit();
  }
  
  function _choice(){
  	
	var num = 0;
	var chioceuuid = [];
	var arrays = document.getElementsByName("abc");
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num] = arrays[i].value;
			num += 1;
		}
	}
	if(num < 1){
		page.alert('��ѡ��Ҫ����ƽ����ļ���');
		return;
	}else{
		if (confirm("ȷ���ƽ���Щ�ļ���")){
			var uuid = chioceuuid.join("#");
			//var TI_ID = document.getElementById("TI_ID").value;
			//var rv = getStr("com.dcfs.ffs.transferManager.TransferManagerAjax", "uuid="+uuid+"&TI_ID="+TI_ID);
			
			opener.refreshLocalList(uuid);
			window.close();
		}
	}
  }

  
  //���÷������ɶ���
  function _reset(){
	  document.getElementById("S_COUNTRY_CODE").value = "";
	  document.getElementById("S_ADOPT_ORG_ID").value = "";
	  document.getElementById("S_ARCHIVE_NO").value = "";
	  document.getElementById("S_MALE_NAME").value = "";
	  document.getElementById("S_FEMALE_NAME").value = "";
	  document.getElementById("S_SIGN_DATE_START").value = "";
	  document.getElementById("S_SIGN_DATE_END").value = "";
	  document.getElementById("S_REPORT_DATE_START").value = "";
	  document.getElementById("S_REPORT_DATE_END").value = "";
	  document.getElementById("S_NUM").value = "";
	  
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
  }
  

  </script>
<BZ:body property="data"  codeNames="WJLX;GJSY;SYZZ;AZBGFKCS;SYS_GJSY_CN;">
	<BZ:form name="srcForm" method="post" action="transferManager/MannualArchive.action">
	<input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
	<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
	<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	<BZ:frameDiv property="clueTo" className="kuangjia">
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								<td class="bz-search-title">������</td>
								<td>
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="������" restriction="hasSpecialChar" maxlength="50"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" restriction="hasSpecialChar" maxlength="50"/>
								</td>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" restriction="hasSpecialChar" maxlength="50"/>
								</td>
								<td class="bz-search-title"></td>
								<td></td>
							</tr>
							<tr>
								<td class="bz-search-title">ǩ������</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_SIGN_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" formTitle="��ʼǩ������"/>~
									<BZ:input prefix="S_" field="SIGN_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_SIGN_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" formTitle="��ֹǩ������"/>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="REPORT_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REPORT_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REPORT_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
									<BZ:input prefix="S_" field="REPORT_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REPORT_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REPORT_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="��������" restriction="plusInt" maxlength="50"/>
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
					<input type="button" value="ѡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_choice()"/>	
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width:5%;">
									<div class="sorting_disabled">
										<input name="abcd" type="checkbox" class="ace">
									</div>
								</th>
								<th style="width:5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="ARCHIVE_NO">������</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="SIGN_DATE">ǩ������</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="REPORT_DATE">�����������</div>
								</th>
								<th style="width:10%;">
									<div class="sorting" id="NUM">��������</div>
								</th>
							</tr>
						</thead>
						<tbody>	
							<BZ:for property="List">
								<tr class="emptyData">
									<td class="center"><input name="abc" type="checkbox" value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace"></td>
									<td class="center"><BZ:i /></td>
									<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"/></td>
									<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="ARCHIVE_NO" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data type="date" field="SIGN_DATE" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data type="date" field="REPORT_DATE" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
									<td><BZ:data field="NUM" defaultValue="" onlyValue="true" /></td>
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
