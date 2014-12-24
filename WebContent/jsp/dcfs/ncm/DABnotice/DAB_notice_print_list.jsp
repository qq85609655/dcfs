<%
/**   
 * @Title: DAB_notice_print_list.jsp
 * @Description: ������֪ͨ���ӡ�б�
 * @author xugy
 * @date 2014-9-16����9:47:21
 * @version V1.0   
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
		<title>������֪ͨ���ӡ�б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
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
				area: ['1050px','180px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"notice/DABNoticePrintList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_ARCHIVE_NO").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_NOTICECOPY_PRINT_NUM").value = "";
			document.getElementById("S_NOTICECOPY_REPRINT").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		
		//��ӡ����
		function _printCopy(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids = id.split(",")[1];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/DABNoticePrintPreview.action";
				document.srcForm.submit();
			}
		}
		//������ӡ
		function _printCopyAll(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids = ids + "#" + id.split(",")[1];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('��ѡ���ӡ����');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/DABNoticePrint.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="notice/DABNoticePrintList.action">
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
								<td class="bz-search-title" style="width: 10%;">������</td>
								<td style="width: 23%;">
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="������" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 10%;">���ı��</td>
								<td style="width: 24%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 10%;">����</td>
								<td style="width: 23%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
								<td class="bz-search-title">�з�</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
							
								<td class="bz-search-title">Ů��</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								
							</tr>
							<tr>
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								
								<td class="bz-search-title">��ӡ����</td>
								<td>
									<BZ:input prefix="S_" field="NOTICECOPY_PRINT_NUM" id="S_NOTICECOPY_PRINT_NUM" defaultValue="" restriction="plusInt" formTitle="��ӡ����" maxlength="" />
								</td>
								
								<td class="bz-search-title">�Ƿ��ش�</td>
								<td>
									<BZ:select prefix="S_" field="NOTICECOPY_REPRINT" id="S_NOTICECOPY_REPRINT" width="148px" formTitle="�Ƿ��ش�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
										<BZ:option value="9">���ش�</BZ:option>
										<BZ:option value="99">ȫ������</BZ:option>
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
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��ӡ����" class="btn btn-sm btn-primary" onclick="_printCopy()"/>&nbsp;
					<input type="button" value="������ӡ" class="btn btn-sm btn-primary" onclick="_printCopyAll()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ARCHIVE_NO">������</div>
								</th>
								
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 18%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								
								<th style="width: 8%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								
								<th style="width: 8%;">
									<div class="sorting" id="NOTICECOPY_PRINT_NUM">��ӡ����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICECOPY_REPRINT">�Ƿ��ش�</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="ARCHIVE_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue=""/></td>
								
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								
								<td><BZ:data field="NAME" defaultValue=""/></td>
								
								<td><BZ:data field="NOTICECOPY_PRINT_NUM" defaultValue=""/></td>
								<td><BZ:data field="NOTICECOPY_REPRINT" defaultValue="" checkValue="0=��;1=��;9=���ش�"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="������֪ͨ�鸱����ӡ����" exportCode="COUNTRY_CODE=CODE,GJSY;NOTICECOPY_REPRINT=FLAG,0:��&1:��&9:�Ѵ�ӡ;" exportField="ARCHIVE_NO=������,15,20;FILE_NO=���ı��,15;COUNTRY_CODE=����,10;NAME_CN=������֯,15;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;NAME=��ͯ����,10;NOTICECOPY_PRINT_NUM=��ӡ����,10;NOTICECOPY_REPRINT=�Ƿ��ش�,10;"/></td>
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