<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: 省厅寄送打印单
 * @author wangzheng   
 * @date 2014-9-18
 * @version V1.0   
 */
 String postDate=(String)request.getAttribute("postDate");
 String postPerson=(String)request.getAttribute("postPerson");
 String allSize=(String)request.getAttribute("allSize");
 String normalSize=(String)request.getAttribute("normalSize");
 String specialSize=(String)request.getAttribute("specialSize");
%>
<BZ:html>
	<BZ:head>
		<title>材料寄送打印单</title>
        <BZ:webScript list="true"/>
        <link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
	</BZ:head>
	
<script type="text/javascript">
	//关闭
	function _close(){
		window.close();
	}	

</script>
	<BZ:body codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE"> 
	<div id='PrintArea'>   
	<div class="page-content">
		<table width="100%">
			<tr>
				<td colspan="2" align="center"><font size="+2"><span class="title3">涉外收养儿童材料寄送单</span></font></td>
			</tr>
			<tr><td style="text-align: center; border-top:none; height:25px;">&nbsp;</td></tr>
			<tr>
			    <!-- <td align="left">寄送单号：</td> -->
				<td colspan="2" align="right">寄送日期：<%=postDate %>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					<!--结果列表区Start -->
					<table class="table table-striped table-bordered table-hover dataTable table-print" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width:5%;">序号</th>
								<th style="width:8%;">省份</th>
								<th style="width:17%;">福利院</th>
								<th style="width:6%;">姓名</th>
								<th style="width:5%;">性别</th>
								<th style="width:10%;">出生日期</th>
								<th style="width:7%;">材料类别</th>
								<th style="width:8%;">特殊活动</th>
								<th style="width:7%;">是否同胞</th>
								<th style="width:11%;">病残种类</th>
								<th style="width:16%;">备注</th>
							</tr>
							</thead>
							<tbody>	
								<BZ:for property="list">
									<tr>
										<td class="center">
											<BZ:i/>
										</td>
										<td><BZ:data codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
										<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
										<td>
										<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=希望之旅"/>
										<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=明天计划"/>
										</td>
										<td align="center"><BZ:data field="IS_TWINS" onlyValue="true" defaultValue="0" checkValue="0=否;1=是"/></td>
										<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
										<td>&nbsp;</td>
									</tr>
								</BZ:for>
							</tbody>
						</table>
						<!--查询结果列表区End -->
					</td>
				</tr>
				<tr>
			    <td align="left">&nbsp;共<%=allSize %>份，其中正常<%=normalSize %>份，特需<%=specialSize %>份</td> 
				<td align="right">寄送人：<%=postPerson %>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
				</td>
			    </tr>
			</table>		
		</div>
	</div>
	<br>
	<!-- 按钮区域:begin -->
	<div class="bz-action-frame" style="text-align:center">
		<div class="bz-action-edit" desc="按钮区">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">打印</button>
			<!-- <input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()"/> -->&nbsp;&nbsp;
			<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
		</div>
	</div>
	<!-- 按钮区域:end -->
	</BZ:body>
	<script>
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:html>
