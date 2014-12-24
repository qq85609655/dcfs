<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data;" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: 预批审核和儿童基本信息
 * @author mayun   
 * @date 2014-8-14
 * @version V1.0   
 */
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>预批审核和儿童基本信息</title>
		<BZ:webScript edit="true"/>
		<BZ:webScript list="true"/>
	</BZ:head>
	
	<BZ:body codeNames="PROVINCE;ETXB;BCZL;BCCD">
		<BZ:form name="srcForm" method="post" action="">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>锁定儿童基本信息</div>
				</div>
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled" id="PROVINCE_ID">
										省份
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="WELFARE_NAME_CN">
										福利院
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="NAME">
										姓名
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SEX">
										性别
									</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="BIRTHDAY">
										出生日期
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SPECIAL_FOCUS">
										特别关注
									</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="SN_TYPE">
										病残种类
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="SN_DEGREE">
										病残程度
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled" id="IS_TWINS">
										有无同胞
									</div>
								</th>
								<th style="width:15%;">
									<div class="sorting_disabled" id="DISEASE_CN">
										病残诊断
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="etList">
							<tr class="emptyData">
								<td>
									<BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="NAME" type="datetime"  defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"  />
								</td>
								<td>
									<BZ:data field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date"/>
								</td>
								<td>
									<BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
								</td>
								<td>
									<BZ:data field="SN_TYPE" defaultValue="" onlyValue="true" codeName="BCZL"/>
								</td>
								<td>
									<BZ:data field="SN_DEGREE" defaultValue="" onlyValue="true" codeName="BCCD" />
								</td>
								<td>
									<BZ:data field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
								</td>
								<td>
									<BZ:data field="DISEASE_CN" defaultValue="" onlyValue="true"/>
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
			</div>
		</div>
		<br/>
	
		<div class="page-content">
			<div class="wrapper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批审核信息</div>
				</div>
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_LEVEL">
										审核级别
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_DATE">
										审核时间
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_USERNAME">
										审核人
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_OPTION">
										审核结果
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="AUDIT_CONTENT_CN">
										审核意见
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="ypshList" fordata="myData">
							<tr class="emptyData">
								<td>
									<BZ:data field="AUDIT_LEVEL" defaultValue="" onlyValue="true" checkValue="0=经办人审核;1=部门主任复核;2=分管主任审批"/>
								</td>
								<td>
									<BZ:data field="AUDIT_DATE" defaultValue="" onlyValue="true" type="datetime"/>
								</td>
								<td>
									<BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true" />
								</td>
								<%
								String type = ((Data)pageContext.getAttribute("myData")).getString("AUDIT_TYPE","");
								if("1".equals(type)){
							%>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="1=上报;2=通过;3=不通过;4=补充信息;7=退回重审;8=退回经办人;"/></td>
							<%	}else{ %>
								<td class="center"><BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="2=审核通过;3=审核不通过;4=补充信息;"/></td>
							<%	} %>
								<%-- <td>
									<BZ:data field="AUDIT_OPTION" defaultValue="" onlyValue="true" checkValue="0=通过;1=不通过;2=退回经办人;3=补充文件"  />
								</td> --%>
								<td>
									<BZ:data field="AUDIT_CONTENT_CN" defaultValue="" onlyValue="true" />
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>