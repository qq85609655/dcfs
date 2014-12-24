<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description: 文件翻译记录列表
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
		<title>文件翻译记录列表</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		setSigle();
		dyniframesize(['iframe','mainFrame']);
		
	});
	</script>
	<BZ:body  >
		<BZ:form name="srcForm" method="post" action="ffs/jbraudit/findTranslationList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
	
		<div class="page-content">
			<div class="wrapper">
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 2%;">
									<div class="sorting_disabled">
										序号
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_UNITNAME">
										翻译单位
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NOTICE_DATE">
										送翻时间
									</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_USERNAME">
										翻译类型
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_STATE">
										翻译状态
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="TRANSLATION_USERNAME">
										翻译人
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="COMPLETE_DATE">
										完成时间
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="TRANSLATION_UNITNAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="NOTICE_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								
								<td>
									<BZ:data field="TRANSLATION_TYPE" defaultValue="" checkValue="0=文件翻译;1=补充翻译;2=重新翻译"/>
								</td>
								<td>
									<BZ:data field="TRANSLATION_STATE" defaultValue=""  checkValue="0=待翻译;1=翻译中;2=已翻译" />
								</td>
								<td>
									<BZ:data field="TRANSLATION_USERNAME" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="COMPLETE_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>