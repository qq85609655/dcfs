<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: �ļ���ϸ��ѯҳ��
 * @author xxx   
 * @date 2014-7-29 10:44:22
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
  String oper_type = (String)request.getAttribute("OPER_TYPE");
  if(oper_type==null){
	  oper_type="1";
  }

	String sbcode = TRANSFER_CODE.substring(0,1);
	boolean tw_flag = false ;
	if(sbcode!=null&&"5".equals(sbcode)){
		tw_flag = true;
	}
%>
<BZ:html>
	<BZ:head>
		<title>�ļ�������ϸ��ѯ</title>
        <BZ:webScript list="true"/>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
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
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"transferManager/detailView.action";
	 document.srcForm.submit();
  }
  
  //���÷������ɶ���
  function _reset(){
  	$("#S_COUNTRY_CODE").val("");
  	$("#S_ADOPT_ORG_ID").val("");
  	$("#S_REGISTER_DATE_START").val("");
  	$("#S_REGISTER_DATE_END").val("");
  	$("#S_MALE_NAME").val("");
  	$("#S_FEMALE_NAME").val("");
  	$("#S_TRANSFER_DATE_START").val("");
  	$("#S_TRANSFER_DATE_END").val("");
  	$("#S_FILE_NO").val("");
  	$("#S_CONNECT_NO").val("");
  	$("#S_FILE_TYPE").val("");
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
<BZ:body property="data" codeNames="JJMXZT;WJLX;GJSY;JSMXZT;SYS_GJSY_CN;TWCZFS_ALL;TWLX" onload="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');">
     <BZ:form name="srcForm" method="post" action="transferManager/detailView.action">
		 <input type="hidden" name="TRANSFER_TYPE" id="TRANSFER_TYPE" value="<%=TRANSFER_TYPE%>"/>
		 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 </BZ:frameDiv>
	 <!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
						  <tr>
							<td class="bz-search-title" style="width: 15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td style="width: 10%">
								<BZ:select field="COUNTRY_CODE" formTitle=""
									prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--��ѡ��--
									</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="������֯">������֯</span></td>
							<td style="width: 10%">
								<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
										onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							
							
							</td>
							<td class="bz-search-title" style="width: 15%"><span title="��������">��������</span></td>
							<td style="width: 40%">									
										<BZ:input prefix="S_" field="REGISTER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
										<BZ:input prefix="S_" field="REGISTER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="��������">��������</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="Ů������">Ů������</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 15%"><span title="�ƽ�ʱ��">�ƽ�ʱ��</span></td>
							<td style="width: 40%">
										<BZ:input prefix="S_" field="TRANSFER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
										<BZ:input prefix="S_" field="TRANSFER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_TRANSFER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_TRANSFER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="�ļ����">�ļ����</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="�ļ����" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="���ӵ����">���ӵ����</span></td>
							<td style="width: 10%">
										<BZ:input prefix="S_" field="CONNECT_NO" id="S_CONNECT_NO" defaultValue="" formTitle="���ӵ����" restriction="hasSpecialChar" maxlength="256"/>
										</td>
							<td class="bz-search-title" style="width: 15%"><span title="����ʱ��">����ʱ��</span></td>
							<td style="width: 40%">
										<BZ:input prefix="S_" field="RECEIVER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_END\\')}',readonly:true" formTitle="��ʼ�ύ����"/>~
										<BZ:input prefix="S_" field="RECEIVER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVER_DATE_START\\')}',readonly:true" formTitle="��ֹ�ύ����"/>
										</td>
						  </tr>
						  <tr>
							<td class="bz-search-title" style="width: 15%"><span title="�ļ�����">�ļ�����</span></td>
							<td style="width: 10%">
										<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										</BZ:select>
										</td>
							<td class="bz-search-title" style="width: 10%"><span title="�ƽ�״̬">�ƽ�״̬</span></td>
							<td style="width: 10%">
								<BZ:select prefix="S_"  field="TRANSFER_STATE"  size="1" formTitle="�ƽ�״̬" id="S_TRANSFER_STATE">
									<%if("1".equals(oper_type)){ %>
									<option value="" selected>--��ѡ��--</option>
									<option value="'0'" title="δ�ƽ�">δ�ƽ�</option>
									<option value="'1'" title="���ƽ�">���ƽ�</option>
									<option value="'2'" title="���ƽ�">���ƽ�</option>
									<option value="'3'" title="�ѽ���">�ѽ���</option>
									<%} else if("2".equals(oper_type)){ %>
									<option value="" selected>--��ѡ��--</option>
									<option value="'2'" title="������" >������</option>
									<option value="'3'" title="�ѽ���" >�ѽ���</option>
									<%} %>
								</BZ:select>
							</td>
										
							<td class="bz-search-title" style="width: 15%"><span title="����ʱ��"></span></td>
							<td style="width: 40%">
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
						<th class="center" style="width:2%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:3%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COUNTRY_CN">����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="NAME_CN">������֯</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="FILE_NO">�ļ����</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="REGISTER_DATE">��������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="MALE_NAME">��������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="FEMALE_NAME">Ů������</div>
						</th>
						<%if(tw_flag){ %>
						<th style="width:5%;">
							<div class="sorting" id="APPLE_TYPE">��������</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="HANDLE_TYPE">���Ĵ��÷�ʽ</div>
						</th>
						<%}%>
						<th style="width:10%;">
							<div class="sorting" id="CONNECT_NO">���ӵ����</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSFER_DATE">�ƽ�����</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="RECEIVER_DATE">��������</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSFER_STATE">�ƽ�״̬</div>
						</th>
					</tr>
					</thead>
					<tbody>
						<%if("1".equals(oper_type)){ %>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%if(tw_flag){ %>
								<td><BZ:data field="APPLE_TYPE"  defaultValue="" codeName="TWLX" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/></td>
								<%}%>
								<td><BZ:data field="CONNECT_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECEIVER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSFER_STATE" codeName="JJMXZT" defaultValue="" onlyValue="true"/></td>
								
							</tr>
						</BZ:for>
						<%}else { %>
							<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="TI_ID" onlyValue="true"/>#<BZ:data field="AT_STATE" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<%if(tw_flag){ %>
								<td><BZ:data field="APPLE_TYPE"  defaultValue="" codeName="TWLX" onlyValue="true"/></td>
								<td><BZ:data field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/></td>
								<%}%>
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
					<td>
					<BZ:page form="srcForm" property="List"exportXls="true" exportTitle="�ļ�������ϸ" 
					exportCode="TRANSFER_STATE=CODE,JSMXZT;" 
					exportField="COUNTRY_CN=����,15,20;NAME_CN=������֯,25;FILE_NO=�ļ����,15;REGISTER_DATE=��������,25;MALE_NAME=��������,25;FEMALE_NAME=Ů������,25;CONNECT_NO=���ӵ����,20;TRANSFER_DATE=�ƽ�����,25;CONNECT_NO=���ӵ����,20;TRANSFER_DATE=�ƽ�����,25;RECEIVER_DATE=��������,25;TRANSFER_STATE=�ƽ�״̬,15"/>
					</td>
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
		</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>
