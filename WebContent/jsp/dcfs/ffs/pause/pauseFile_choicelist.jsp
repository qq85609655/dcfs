<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: pauseFile_choicelist.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-9-4 ����2:03:18 
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
		<title>��ͣ�ļ�ѡ���б�</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/pause/pauseChoiceList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_AF_POSITION").value = "";
			document.getElementById("S_AF_GLOBAL_STATE").value = "";
		}
		
		//�����ļ���ͣȷ��ҳ��
		function _confirm(){
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				alert('��ѡ��һ������');
				return;
			}else{
				window.open(path + "ffs/pause/confirmShow.action?showuuid=" + showuuid,"window","width=950,height=450,top=160,left=200,scrollbars=yes");
			}
		}
		function open_tijiao(){
			document.srcForm.action = path +"ffs/pause/pauseFileList.action";
			document.srcForm.submit();
		}
		
		//�鿴�ļ���ϸ��Ϣ
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
				//var url = path + "ffs/pause/fileInfoShow.action?showuuid=" + showuuid;
				window.open(path + "ffs/pause/fileInfoShow.action?showuuid=" + showuuid,"newwindow","height=600,width=1000,top=70,left=180,scrollbars=yes");
				//document.srcForm.submit();
				//_open(url, this, 1000, 600);
			}
		}
		
		//�����ļ���ͣ��Ϣ�б�
		function _goback(){
			window.location.href=path+'ffs/pause/pauseFileList.action';
		}
		

	</script>
	<BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;WJWZ;WJQJZT_ZX">
		<BZ:form name="srcForm" method="post" action="ffs/pause/pauseChoiceList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ������begin -->
		<div class="stepflex" style="margin-right: 30px;">
	        <dl id="payStepFrist" class="first doing">
	            <dt class="s-num">1</dt>
	            <dd class="s-text">��һ����ѡ���ļ���ͣ<s></s>
	                <b></b>
	            </dd>
	        </dl>
	        <dl id="payStepNormal" class="normal do">
	            <dt class="s-num">2</dt>
	            <dd class="s-text">�ڶ�����¼����ͣԭ��<s></s>
	                <b></b>
	            </dd>
	        </dl>
	        <dl id="payStepLast" class="last">
	            <dt class="s-num">3</dt>
	            <dd class="s-text">���������ύ<s></s>
	                <b></b>
	            </dd>
	        </dl>
		</div>
		<!-- ������end -->
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
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
										onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" style="width:270px;"/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="200"/>
								</td>
								
								<td class="bz-search-title">�ļ�λ��</td>
								<td>
									<BZ:select prefix="S_" field="AF_POSITION" id="S_AF_POSITION" isCode="true" codeName="WJWZ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�ļ�״̬</td>
								<td>
									<BZ:select prefix="S_" field="AF_GLOBAL_STATE" id="S_AF_GLOBAL_STATE" isCode="true" codeName="WJQJZT_ZX" formTitle="" defaultValue="" width="84%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									&nbsp;
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="AF_POSITION">�ļ�λ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="AF_GLOBAL_STATE">�ļ�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
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
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" defaultValue="" codeName="WJWZ" onlyValue="true"/></td>
								<td><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_ZX" onlyValue="true"/></td>
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