<%
/**   
 * @Title: normalFile_steptempleteview.jsp
 * @Description:  ����Ů�����ļ���ϸ��Ϣ�鿴ҳ
 * @author yangrt   
 * @date 2014-7-22 ����14:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String packageId = (String)request.getAttribute("PACKAGE_ID");
	String male_photo = (String)request.getAttribute("MALE_PHOTO");
	String female_photo = (String)request.getAttribute("FEMALE_PHOTO");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>����Ů�����ļ���ϸ��Ϣ�鿴ҳ</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//�����Ա��ж�Ҫ��ʾ����Ϣ
			var sex_flag = $("#R_ADOPTER_SEX").val();
			if(sex_flag == "1"){
				$(".male").show();
				$(".female").hide();
				
				//�����������˵���ʾ����
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
			}else{
				$(".female").show();
				$(".male").hide();
				
				//����Ů�����˵���ʾ����
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
			}
			
			//��Ч����
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1"){
				$("#R_PERIOD").text(valid_period + " ��(Month)");
			}else{
				$("#R_PERIOD").text("����(Long-term)");
			}
		});
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday)
		{       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//ͬ�� ��Ϊ0��
		    }else{
		        var ageDiff = nowYear - birthYear ; //��֮��
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//��֮��
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//��֮��
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		        }
		    }
		    
		    return returnAge;//������������
		    
		}
		
	</script>
	<BZ:body property="data" codeNames="GJ;ZCWJLX;SYLX">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<!-- ��������end -->
		
		<!-- ��ť����begin -->
		<div class="blue-hr"> 
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>&nbsp;&nbsp;
			<button class="btn btn-sm btn-primary" onclick="window.close();">Close</button>
		</div>
		<!-- ��ť����end -->
		<div id='PrintArea'>
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�鿴����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table table-print" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">�ļ�����<br>Document type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="ZCWJLX" isShowEN="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">��������<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" isShowEN="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div class="title3" style="height: 35px; padding-top: 5px;">�����˻�����Ϣ(Information about the adoptive parents)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table table-print" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
							<td class="bz-edit-data-value" width="25%">
								<span class="male"><BZ:dataValue field="MALE_NAME" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NAME" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="ADOPTER_SEX" checkValue="1=Male;2=Female;" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<span class="male">
									<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=male_photo %>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
								</span>
								<span class="female">
									<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=female_photo %>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ" isShowEN="true"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ" isShowEN="true"/></span>
							</td>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����״��<br> Marital status</td>
							<td class="bz-edit-data-value">Married</td>
							<td class="bz-edit-data-title">�������<br>Date of the present marriage</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div class="title3" style="height: 35px; padding-top: 5px;">������׼��Ϣ(Government approval information)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table table-print" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">��׼����<br>Date of approval</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">��Ч����<br>Validity period</td>
							<td class="bz-edit-data-value" width="30%">
								<span id="R_PERIOD"></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����" id="print2">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ(Attachment)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-value">
								<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<%=packageId %>" frameborder=0 width="100%" ></IFRAME>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
	<script>
	//��ӡ�������
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
	</BZ:body>
</BZ:html>