<%
/**   
 * @Title: ffs_af_singleparent_translation.jsp
 * @Description:  文件翻译页（继子女收养）
 * @author wangz   
 * @date 2014-8-11 上午10:00:00 
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	String ADOPTER_SEX = data.getString("ADOPTER_SEX");
	String afId = data.getString("AF_ID");
%>
<BZ:html>

<BZ:head>
    <title>文件翻译页（继子女收养）</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;SEX;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		$(document).ready( function() {
			//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		    $('#tab-container').easytabs();
		    _setValidPeriod('<%=data.getString("VALID_PERIOD")%>');
		})
	/*
	* 设置有效期限类型
	* 1:有效期限
	* 2:长期
	*/
	function _setValidPeriod(v){
		var strText;
		if("-1"==v){				
			strText = "长期";
		}else{
			strText = v + " 个月";			
		}
		$("#FE_VALID_PERIOD_CN").text(strText);	
		$("#FE_VALID_PERIOD_EN").text(strText);
	}	
	//关闭
	function _close(){
		window.close();
	}
	
	//-----  下面是打印控制语句  ----------
	window.onbeforeprint=beforeCNPrint;
	window.onafterprint=afterCNPrint;
	//打印之前隐藏不想打印出来的信息
	function beforeCNPrint()
	{
		_title.style.display='none';
		tab2.style.display='none';
		attarea1.style.display='none';
		attarea2.style.display='none';
		buttonarea.style.display='none';
		tranarea.style.display='none';
	}
	//打印之后将隐藏掉的信息再显示出来
	function afterCNPrint()
	{
		_title.style.display='';
		attarea1.style.display='';
		attarea2.style.display='';
		buttonarea.style.display='';
		tranarea.style.display='';
	}
	
	</script>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs' id="_title">
			<li class='tab'><a href="#tab1">基本信息(中文)</a></li>
			<li class='tab'><a href="#tab2">基本信息(外文)</a></li>
		</ul>
		<div class='panel-container'>
			<!--家庭基本情况(中)：start-->
			<div id="tab1">
				
				<!--文件基本信息：start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">收养组织(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养组织(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">文件类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收养类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收文编号</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" hrefTitle="收文编号" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--文件基本信息：end-->                   
				<!--单亲收养：start-->
				<table id="tb_jzv_cn" class="specialtable">
					<tr>
						 <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
					</tr>
					<tr>
						<td>
							<!--收养人信息：start-->                            	  
							<table class="specialtable">                          	
								<tr>
									<td class="edit-data-title" width="15%">外文姓名</td>
									<td class="edit-data-value" width="26%">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title" width="15%">性别</td>
									<td class="edit-data-value" width="26%"><BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>
									</td>
									<td class="edit-data-value" width="18%" rowspan="4">
									<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
									<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">年龄</td>
									<td class="edit-data-value">
										<div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
										<script>
										document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
										</script>
										</div>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">国籍</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">护照号码</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">婚姻状况</td>
									<td class="edit-data-value">已婚</td>
									<td class="edit-data-title">结婚日期</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/></td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="5" style="text-align:center"><b>政府批准信息</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">批准日期</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">有效期限</td>
									<td class="edit-data-value">
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true" defaultValue=""/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
										</script>
									</td>
								</tr>
								<tr id="attarea1">
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>附件信息</b></td>										
								</tr>
								<tr id="attarea2">
									<td colspan="6">
									<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr> 
							</table>
						</td>
					</tr>
				</table> 
				<!--单亲收养：end-->
			</div>
			<!--家庭基本情况(中)：end-->
			<!--家庭基本情况(外)：start-->
			<div id="tab2">
				<!--文件基本信息：start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">收养组织(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养组织(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">文件类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收养类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收文编号</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" hrefTitle="收文编号" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--文件基本信息：end-->
				<!--单亲收养：start-->
				<table id="tb_jzv_en" class="specialtable">
					<tr>	
						<td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
					</tr>
					<tr>
						<td>
							<!--收养人信息：start-->                            	  
							<table class="specialtable">                          	
								<tr>
									<td class="edit-data-title" width="15%">外文姓名</td>
									<td class="edit-data-value" width="26%">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title" width="15%">性别</td>
									<td class="edit-data-value" width="26%">
									<BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" width="18%" rowspan="4">
									<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
									<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">年龄</td>
									<td class="edit-data-value">
										<div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
										<script>
										document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
										</script>
										</div>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">国籍</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">护照号码</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">婚姻状况</td>
									<td class="edit-data-value">已婚</td>
									<td class="edit-data-title">结婚日期</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/></td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="5" style="text-align:center"><b>政府批准信息</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">批准日期</td>
									<td class="edit-data-title">批准日期</td>
									<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">有效期限</td>
									<td class="edit-data-value">
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true" defaultValue=""/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
										</script>
									</td>                                       
								</tr>
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>附件信息</b></td>										
								</tr>
								<tr>
									<td colspan="6">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>                                    
							</table>
						</td>
					</tr>

				</table>
				<!--单亲收养：end-->                                
						</td>
					</tr>
				</table>     	
			</div>
			<!--家庭基本情况(外)：end-->                                
			</div>
		</div>
		<!--翻译信息：start-->
		<div id="tranarea">
			<table class="specialtable" align="center" style="width:98%;text-align:center">
				<tr>
                    <td class="edit-data-title" colspan="2" style="text-align:center"><b>翻译信息</b></td>
                </tr>
                <tr>
					<td  class="edit-data-title" width="15%">翻译说明</td>
					<td  class="edit-data-value">
					<BZ:dataValue field="TRANSLATION_DESC" type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
			</table>
		</div>
		<!--翻译信息：end-->
		<br>
		<!-- 按钮区域:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="按钮区" id="buttonarea">
				<input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<br/>
		<!-- 按钮区域:end -->
	</BZ:body>
</BZ:html>
