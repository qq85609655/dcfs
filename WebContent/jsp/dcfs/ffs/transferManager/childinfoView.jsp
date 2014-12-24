<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: ��ͯ������ϸ��ѯҳ��
 * @author wty   
 * @date 2014-7-29 10:44:22
 * @version V1.0  
 * modify by kings 2014-10-31
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
  
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>���Ͻ�����ϸ��ѯ</title>
        <BZ:webScript list="true" isAjax="true" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/child.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
  $(document).ready(function() {
  	//dyniframesize(['mainFrame']);
	  initProvOrg("<%=WELFARE_ID%>");
  	});
 
 //��ʾ��ѯ����
	function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','200px'],
				offset: ['40px' , '10px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"transferManager/detailViewChildinfo.action";
	 document.srcForm.submit();
  }
  
  //���ò�ѯ
  function _reset(){
    $("#S_PROVINCE_ID").val("");
    $("#S_WELFARE_ID").val("");
    $("#S_CHILD_NO").val("");
    $("#S_NAME").val("");
    $("#S_SEX").val("");
    $("#S_BIRTHDAY_START").val("");
    $("#S_BIRTHDAY_END").val("");
    $("#S_CHILD_TYPE").val("");
    $("#S_SPECIAL_FOCUS").val("");
    $("#S_TRANSFER_DATE_START").val("");
    $("#S_TRANSFER_DATE_END").val("");
    $("#S_CONNECT_NO").val("");
    $("#S_TRANSFER_STATE").val("");
    $("#S_RECEIVER_DATE_START").val("");
    $("#S_RECEIVER_DATE_END").val("");
  } 

  
  //����
	function _export(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			_exportFile(document.srcForm,'xls')
		}else{
			return;
		}
	}	
  </script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;JJMXZT;JSMXZT">
     <BZ:form name="srcForm" method="post" action="transferManager/detailViewChildinfo.action">
     <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <input type="hidden" name="OPER_TYPE" id="OPER_TYPE" value="<%=OPER_TYPE%>"/>
	 <div class="page-content">
	 <!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td class="bz-search-title" style="width: 10%">ʡ��</td>
				<td style="width: 15%">
					<BZ:select prefix="S_" id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="150px"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
	 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title" style="width: 10%">����Ժ</td>
				<td style="width: 15%">
				    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="200px">
		              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title" style="width: 10%">��ͯ���</td>
				<td style="width: 40%">
					<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
				</td>
			</tr> 
			<tr>						
				<td class="bz-search-title">����</td>
				<td>
					<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
				</td>
				<td class="bz-search-title">�Ա�</td>
				<td>
					<BZ:select prefix="S_" id="S_SEX" field="SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="">
		              <BZ:option value="">--��ѡ��--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title">��������</td>
				<td>
					<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" formTitle="��ʼ�ύ����" />~ 
					<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" formTitle="��ֹ�ύ����" />
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">��ͯ����</td>
				<td>
					<BZ:select prefix="S_" id="S_CHILD_TYPE" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
		              <BZ:option value="">--��ѡ��--</BZ:option>
	                </BZ:select>
				</td>
				<td class="bz-search-title">�ر��ע</td>
				<td>
					<BZ:select prefix="S_" id="S_SPECIAL_FOCUS" field="SPECIAL_FOCUS" formTitle="�ر��ע" defaultValue="">
		              <BZ:option value="">--��ѡ��--</BZ:option>
		              <BZ:option value="0">��</BZ:option>
		              <BZ:option value="1">��</BZ:option>				              
	                </BZ:select>
				</td>
				<td class="bz-search-title">�ƽ�����</td>
				<td>
					<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
					<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
				</td>
			</tr>
			<tr>
				<td class="bz-search-title">���ӵ����</td>
				<td>
					<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="���ӵ����" restriction="hasSpecialChar" maxlength="256"/>
				</td>
				<td class="bz-search-title" style="width: 10%"><span title="�ƽ�״̬">�ƽ�״̬</span></td>
				<td>
					<%if("1".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" id="S_TRANSFER_STATE" field="TRANSFER_STATE" isCode="true" codeName="JJMXZT" formTitle="�ƽ�״̬" defaultValue="">
		              <BZ:option value="">--��ѡ��--</BZ:option>
	                </BZ:select>
						
					<%} else if("2".equals(OPER_TYPE)){ %>
					<BZ:select prefix="S_" id="S_TRANSFER_STATE" field="TRANSFER_STATE" isCode="true" codeName="JSMXZT" formTitle="�ƽ�״̬" defaultValue="">
		              <BZ:option value="">--��ѡ��--</BZ:option>
	                </BZ:select>
					<%} %>
				</td>
				<td class="bz-search-title">��������</td>
				<td>
					<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
					<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
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
     <div class="wrapper">
     <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <!-- ���ܰ�ť������Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="window.close()"/>&nbsp;			
	</div>
	<div class="blue-hr"></div>
	<!-- ���ܰ�ť������End -->
	
		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th style="width:3%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="CHILD_NO">��ͯ���</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="PROVINCE_ID">ʡ��</div>
						</th>
						<th style="width:15%;">
							<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NAME">����</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="SEX">�Ա�</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="BIRTHDAY">��������</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
						</th>								
						<th style="width:5%;">
							<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
						</th>
						<th>
							<div class="sorting" id="CONNECT_NO">���ӵ����</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="TRANSFER_DATE">�ƽ�����</div>
						</th>
						<th style="width:8%;">
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
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="CHILD_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX"  defaultValue="" onlyValue="true"/></td>								
								<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS"  defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
								<td style="text-align:center"><BZ:data field="CONNECT_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="JJMXZT" field="TRANSFER_STATE" defaultValue="" onlyValue="true"/></td>								
							</tr>
						</BZ:for>
						<%}else { %>
							<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="CHILD_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="ETXB" field="SEX"  defaultValue="" onlyValue="true"/></td>								
								<td style="text-align:center"><BZ:data field="BIRTHDAY" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data codeName="CHILD_TYPE" field="CHILD_TYPE" defaultValue="" onlyValue="true"/></td>
								<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS"  defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
								<td style="text-align:center"><BZ:data field="CONNECT_NO" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="���Ͻ�����ϸ" 
					exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SPECIAL_FOCUS=FLAG,0:��&1:��;TRANSFER_DATE=DATE;RECEIVER_DATE=DATE;TRANSFER_STATE=CODE,JJMXZT;" 
					exportField="CHILD_NO=��ͯ���,15,20;PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,30;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,10;CHILD_TYPE=��ͯ����,10;SPECIAL_FOCUS=�ر��ע,15;CONNECT_NO=���ӵ����,15;TRANSFER_DATE=�ƽ�����,15;RECEIVER_DATE=��������,15;TRANSFER_STATE=�ƽ�״̬,10"/></td>				
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
