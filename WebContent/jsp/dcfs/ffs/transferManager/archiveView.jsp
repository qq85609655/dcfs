<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.ffs.transferManager.TransferConstant"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: �ļ���ϸ��ѯҳ��
 * @author xugaoyang
 * @date 2014-11-18 14:58:22
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
  String TRANSFER_TYPE =(String)request.getAttribute("TRANSFER_TYPE");
  if(TRANSFER_TYPE==null){
	  TRANSFER_TYPE="";
  }
  String TRANSFER_CODE =(String)request.getAttribute("TRANSFER_CODE");
  if(TRANSFER_CODE==null){
	  TRANSFER_CODE="";
  }
  String OPER_TYPE = (String)request.getAttribute("OPER_TYPE");
  if(OPER_TYPE==null){
      OPER_TYPE="1";
  }
%>
<BZ:html>
	<BZ:head>
		<title>�ļ�������ϸ��ѯ</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
  $(document).ready(function() {
  			//dyniframesize(['mainFrame']);
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
				area: ['1150px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"transferManager/detailViewArchive.action";
	 document.srcForm.submit();
  }
  
  //���÷������ɶ���
  function _reset(){
	  $("#S_COUNTRY_CODE").val("");
	  $("#S_ADOPT_ORG_ID").val("");
	  $("#S_ARCHIVE_NO").val("");
	  $("#S_MALE_NAME").val("");
	  $("#S_FEMALE_NAME").val("");
	  $("#S_NAME").val("");
	  $("#S_SIGN_DATE_START").val("");
	  $("#S_SIGN_DATE_END").val("");
	  $("#S_REPORT_DATE_START").val("");
	  $("#S_REPORT_DATE_END").val("");
	  $("#S_NUM").val("");
	  $("#S_CONNECT_NO").val("");
	  $("#S_TRANSFER_DATE_START").val("");
	  $("#S_TRANSFER_DATE_END").val("");
	  $("#S_RECEIVER_DATE_START").val("");
	  $("#S_RECEIVER_DATE_END").val("");
	  $("#S_TRANSFER_STATE").val("");
	  
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
  }
  
  </script>
<BZ:body property="data" codeNames="JJMXZT;WJLX;GJSY;JSMXZT;SYS_GJSY_CN;">
	<BZ:form name="srcForm" method="post" action="transferManager/detailViewArchive.action">
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <input type="hidden" name="OPER_TYPE" id="OPER_TYPE" value="<%=OPER_TYPE%>"/>
	<!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
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
					<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="������"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">��������</td>
				<td>
					<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������"/>
				</td>
				<td class="bz-search-title">Ů������</td>
				<td>
					<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������"/>
				</td>
				<td class="bz-search-title">��ͯ����</td>
				<td>
					<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="��ͯ����"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">ǩ������</td>
				<td>
					<BZ:input prefix="S_" field="SIGN_DATE_START" type="Date" defaultValue=""  id="S_SIGN_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" formTitle="��ʼǩ������"/>~
					<BZ:input prefix="S_" field="SIGN_DATE_END" type="Date" defaultValue=""  id="S_SIGN_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" formTitle="��ֹǩ������"/>
				</td>
				<td class="bz-search-title">�����������</td>
				<td>
					<BZ:input prefix="S_" field="REPORT_DATE_START" type="Date" defaultValue=""  id="S_REPORT_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REPORT_DATE_END\\')}',readonly:true" formTitle="��ʼ�����������"/>~
					<BZ:input prefix="S_" field="REPORT_DATE_END" type="Date" defaultValue=""  id="S_REPORT_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REPORT_DATE_START\\')}',readonly:true" formTitle="��ֹ�����������"/>
				</td>
				<td class="bz-search-title">��������</td>
				<td>
					<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" restriction="" formTitle="��������"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">�ƽ����</td>
				<td>
					<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="�ƽ����" restriction="hasSpecialChar" maxlength="256"/>
				</td>
				<td class="bz-search-title">�ƽ�����</td>
				<td>
					<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
					<BZ:input prefix="S_" field="TRANSFER_DATE_END" type="Date" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
				</td>
				<td class="bz-search-title">��������</td>
				<td>
					<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
					<BZ:input prefix="S_" field="RECEIVER_DATE_END" type="Date" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">�ƽ�״̬</td>
				<td>
					<%if("1".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" field="TRANSFER_STATE" formTitle="�ƽ�״̬" isCode="true" codeName="JJMXZT" width="148px" defaultValue="" id="S_TRANSFER_STATE">
						<BZ:option value="">--��ѡ��--</BZ:option>
					</BZ:select>
					<%} else if("2".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" field="TRANSFER_STATE" formTitle="�ƽ�״̬" isCode="true" codeName="JSMXZT" width="148px" defaultValue="" id="S_TRANSFER_STATE">
						<BZ:option value="">--��ѡ��--</BZ:option>
					</BZ:select>
					<%} %>
				</td>
			</tr>
			<tr style="height: 5px;"></tr>
			<tr>
				<td style="text-align: center;" colspan="6">
					<div class="bz-search-button">
						<input type="button" value="��&nbsp;&nbsp;��" onclick="search();" class="btn btn-sm btn-primary">
						<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- ��ѯ������End -->
	<div class="page-content">
		<div class="wrapper">
			<!-- ���ܰ�ť������Start -->
			<div class="table-row table-btns" style="text-align: left">
				<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="window.close()"/>&nbsp;			
			</div>
			<div class="blue-hr"></div>
			<!-- ���ܰ�ť������End -->
			<!--��ѯ����б���Start -->
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
					<thead>
						<tr>
							<th style="width:5%;">
								<div class="sorting_disabled">���</div>
							</th>
							<th style="width:5%;">
								<div class="sorting" id="COUNTRY_CODE">����</div>
							</th>
							<th style="width:10%;">
								<div class="sorting" id="NAME_CN">������֯</div>
							</th>
							<th style="width:7%;">
								<div class="sorting" id="ARCHIVE_NO">������</div>
							</th>
							<th style="width:10%;">
								<div class="sorting" id="MALE_NAME">��������</div>
							</th>
							<th style="width:10%;">
								<div class="sorting" id="FEMALE_NAME">Ů������</div>
							</th>
							<th style="width:5%;">
								<div class="sorting" id="NAME">��ͯ����</div>
							</th>
							<th style="width:6%;">
								<div class="sorting" id="SIGN_DATE">ǩ������</div>
							</th>
							<th style="width:7%;">
								<div class="sorting" id="REPORT_DATE">�����������</div>
							</th>
							<th style="width:5%;">
								<div class="sorting" id="NUM">��������</div>
							</th>
							<th style="width:10%;">
								<div class="sorting" id="CONNECT_NO">���ӵ����</div>
							</th>
							<th style="width:7%;">
								<div class="sorting" id="TRANSFER_DATE">�ƽ�����</div>
							</th>
							<th style="width:7%;">
								<div class="sorting" id="RECEIVER_DATE">��������</div>
							</th>
							<th style="width:5%;">
								<div class="sorting" id="TRANSFER_STATE">�ƽ�״̬</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<%if("1".equals(OPER_TYPE)){ %>	
						<BZ:for property="List">
						<tr class="emptyData">
							<td class="center"><BZ:i/></td>
							<td><BZ:data field="COUNTRY_CODE"  defaultValue="" onlyValue="true" codeName="GJSY"/></td>
							<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="ARCHIVE_NO"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="SIGN_DATE"  defaultValue="" onlyValue="true" type="date"/></td>
							<td><BZ:data field="REPORT_DATE"  defaultValue="" onlyValue="true" type="date"/></td>
							<td><BZ:data field="NUM"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="TRANSFER_STATE" codeName="JJMXZT" defaultValue="" onlyValue="true"/></td>
						</tr>
						</BZ:for>
						<%}else { %>
						<BZ:for property="List">
						<tr class="emptyData">
							<td class="center"><BZ:i/></td>
							<td><BZ:data field="COUNTRY_CODE"  defaultValue="" onlyValue="true" codeName="GJSY"/></td>
							<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="ARCHIVE_NO"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="SIGN_DATE"  defaultValue="" onlyValue="true" type="date"/></td>
							<td><BZ:data field="REPORT_DATE"  defaultValue="" onlyValue="true" type="date"/></td>
							<td><BZ:data field="NUM"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="TRANSFER_STATE" codeName="JSMXZT" defaultValue="" onlyValue="true"/></td>
						</tr>
						</BZ:for>
						<%} %>
					</tbody>
				</table>
			</div>
			<!--��ѯ����б���End -->
			<!--��ҳ������Start -->
			<div class="footer-frame">
				<table border="0" cellpadding="0" cellspacing="0" class="operation">
					<tr>
						<td><BZ:page form="srcForm" property="List" /></td>
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
