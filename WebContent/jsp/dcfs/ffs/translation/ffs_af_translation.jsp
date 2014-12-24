<%
/**   
 * @Title: ffs_af_translation.jsp
 * @Description:  �ļ�����ҳ
 * @author wangz   
 * @date 2014-8-11 ����10:00:00 
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>

<BZ:head>
    <title>�ļ�����ҳ</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var FAMILY_TYPE = "<BZ:dataValue type="String" field="FAMILY_TYPE" defaultValue="1" onlyValue="true"/>";		//��������
		var FILE_TYPE = "<BZ:dataValue type="String" field="FILE_TYPE" defaultValue="1" onlyValue="true"/>";			//�ļ�����
		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//�������˵Ľ���״��
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//Ů�����˵Ľ���״��
		var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//������λ
		var male_height	 = "<BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>";		//�����������
		var female_height = "<BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>";	//Ů���������
		var male_weight = "<BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>";		//������������
		var female_weight = "<BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>";	//Ů����������
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//��������Υ����Ϊ�����´���
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů������Υ����Ϊ�����´���
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//�����������޲����Ⱥ�
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//Ů���������޲����Ⱥ�
		var MARRY_DATE = "<BZ:dataValue type="String" field="MARRY_DATE" defaultValue="" onlyValue="true"/>";			//�������
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//��ͥ���ʲ�
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";			//��ͥ��ծ��
		
		var IS_FORMULATE = "<BZ:dataValue type="String" field="IS_FORMULATE" defaultValue="0" onlyValue="true"/>";		//����ָ���໤��
		var IS_ABUSE_ABANDON = "<BZ:dataValue type="String" field="IS_ABUSE_ABANDON" defaultValue="0" onlyValue="true"/>";		//��������Ű������
		var IS_MEDICALRECOVERY = "<BZ:dataValue type="String" field="IS_MEDICALRECOVERY" defaultValue="0" onlyValue="true"/>";	//�����ƻ�
		var ADOPT_PREPARE = "<BZ:dataValue type="String" field="ADOPT_PREPARE" defaultValue="0" onlyValue="true"/>";	//����ǰ׼��
		var RISK_AWARENESS = "<BZ:dataValue type="String" field="RISK_AWARENESS" defaultValue="0" onlyValue="true"/>";	//������ʶ
		var IS_SUBMIT_REPORT = "<BZ:dataValue type="String" field="IS_SUBMIT_REPORT" defaultValue="0" onlyValue="true"/>";//ͬ��ݽ����ú󱨸�����
		var IS_FAMILY_OTHERS_FLAG = "<BZ:dataValue type="String" field="IS_FAMILY_OTHERS_FLAG" defaultValue="0" onlyValue="true"/>";//��������������ͬס
		var PARENTING = "<BZ:dataValue type="String" field="PARENTING" defaultValue="0" onlyValue="true"/>";			// ��������
		var ADOPTER_SEX = "<BZ:dataValue type="String" field="ADOPTER_SEX" defaultValue="2" onlyValue="true"/>";		// �������Ա�
		
		var formType = "sqsy";	
		$(document).ready( function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		    $('#tab-container').easytabs();
			
			//�����������ͺ��ļ����ͣ���ʾ˫�����������������ͼ���Ů�����ı�					
			if(FAMILY_TYPE=="2"){
				formType = "dqsy";
			}else{ 
				if(FILE_TYPE=="33"){
					formType = "jzn";	
				}
			}
			formType = "dqsy";	
			switch (formType){
				case "sqsy":
					$('#tb_sqsy_cn').show();
					$('#tb_sqsy_en').show();
					$('#tb_dqsy_cn').hide();
					$('#tb_dqsy_en').hide();					
					$('#tb_jzn_cn').hide();				 	
					$('#tb_jzn_en').hide();
					break;
				case "dqsy":
					$('#tb_sqsy_cn').hide();
					$('#tb_sqsy_en').hide();
					$('#tb_dqsy_cn').show();
					$('#tb_dqsy_en').show();					
					$('#tb_jzn_cn').hide();				 	
					$('#tb_jzn_en').hide();
					break;
				case "jzn":
					$('#tb_sqsy_cn').hide();
					$('#tb_sqsy_en').hide();
					$('#tb_dqsy_cn').hide();
					$('#tb_dqsy_en').hide();					
					$('#tb_jzn_cn').show();				 	
					$('#tb_jzn_en').show();
					break;					
			}
			//��ʼ������״��˵������ʾ������
			_setMale_health(male_health);
			_setFemale_health(female_health);
			//������ߡ����ص���ʾ��ʽ�����ơ�Ӣ�ƣ�
			_setMeasurement(measurement);
			
			//����BMI
			_setBMI("1");
			_setBMI("2");
			
			//��ʼ������Υ����Ϊ�����´���
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			_setFEMALE_PUNISHMENT_FLAG(FEMALE_PUNISHMENT_FLAG);
						
			//��ʼ���������޲����Ⱥ�
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			_setFEMALE_ILLEGALACT_FLAG(FEMALE_ILLEGALACT_FLAG);
			
			//���ý��ʱ��
			_setMarryLength(MARRY_DATE);
			
			//���ü�ͥ���ʲ�
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
			
			//��������ָ���໤��
			_setRadio("IS_FORMULATE",IS_FORMULATE);         
			//���ò�������Ű������
			_setRadio("IS_ABUSE_ABANDON",IS_ABUSE_ABANDON);         
			//���ø����ƻ�               
			_setRadio("IS_MEDICALRECOVERY",IS_MEDICALRECOVERY);         
			//��������ǰ׼��             
			_setRadio("ADOPT_PREPARE",ADOPT_PREPARE);         
			//���÷�����ʶ               
			_setRadio("RISK_AWARENESS",RISK_AWARENESS);         
			//����ͬ��ݽ����ú󱨸����� 
			_setRadio("IS_SUBMIT_REPORT",IS_SUBMIT_REPORT);         
			//���ü�������������ͬס     
			_setRadio("IS_FAMILY_OTHERS_FLAG",IS_FAMILY_OTHERS_FLAG);         
			//������������              
			_setRadio("PARENTING",PARENTING);         
			
			$("#tb_sqsy_cn_MALE_HEALTH").change(function(){
					_setMale_health($(this).val());
			  }); 
			  
			  $("#tb_sqsy_en_MALE_HEALTH").change(function(){
					_setMale_health($(this).val());					
			  });
			  
			 $("#tb_sqsy_cn_FEMALE_HEALTH").change(function(){
					_setFemale_health($(this).val());
			  }); 
			  
			  $("#tb_sqsy_en_FEMALE_HEALTH").change(function(){
					_setFemale_health($(this).val());
			  }); 
			
			$("#tb_sqsy_cn_MEASUREMENT").change(function(){
					_setMeasurement($(this).val());
			  });
			  			  
			$("#tb_sqsy_en_MEASUREMENT").change(function(){
					_setMeasurement($(this).val());
			  });
			  
			  $("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").click(function(){
					_setMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  			  
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").click(function(){
					
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").click(function(){
					_setFEMALE_PUNISHMENT_FLAG($(this).val());
			  });
			  	
			  $("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			   $("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").click(function(){
					_setMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  
			  $("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  			  
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").click(function(){
					_setFEMALE_ILLEGALACT_FLAG($(this).val());
			  });
			  $("#tb_sqsy_cn_IS_FORMULATE0").click(function(){
					_setRadio("IS_FORMULATE",$(this).val());
				});
				 $("#tb_sqsy_cn_IS_FORMULATE1").click(function(){
					_setRadio("IS_FORMULATE",$(this).val());
				});
				$("#tb_sqsy_en_IS_FORMULATE0").click(function(){
					_setRadio("IS_FORMULATE",$(this).val());
				});
				$("#tb_sqsy_en_IS_FORMULATE1").click(function(){
					_setRadio("IS_FORMULATE",$(this).val());
				});
				$("#tb_sqsy_cn_IS_ABUSE_ABANDON0").click(function(){
					_setRadio("IS_ABUSE_ABANDON",$(this).val());
				});
				$("#tb_sqsy_cn_IS_ABUSE_ABANDON1").click(function(){
					_setRadio("IS_ABUSE_ABANDON",$(this).val());
				});
				$("#tb_sqsy_en_IS_ABUSE_ABANDON0").click(function(){
					_setRadio("IS_ABUSE_ABANDON",$(this).val());
				});
				$("#tb_sqsy_en_IS_ABUSE_ABANDON1").click(function(){
					_setRadio("IS_ABUSE_ABANDON",$(this).val());
				});
				$("#tb_sqsy_cn_IS_MEDICALRECOVERY0").click(function(){
					_setRadio("IS_MEDICALRECOVERY",$(this).val());
				});
				$("#tb_sqsy_cn_IS_MEDICALRECOVERY1").click(function(){
					_setRadio("IS_MEDICALRECOVERY",$(this).val());
				});
				$("#tb_sqsy_en_IS_MEDICALRECOVERY0").click(function(){
					_setRadio("IS_MEDICALRECOVERY",$(this).val());
				});
				$("#tb_sqsy_en_IS_MEDICALRECOVERY1").click(function(){
					_setRadio("IS_MEDICALRECOVERY",$(this).val());
				});
				$("#tb_sqsy_cn_ADOPT_PREPARE0").click(function(){
					_setRadio("ADOPT_PREPARE",$(this).val());
				});
				$("#tb_sqsy_cn_ADOPT_PREPARE1").click(function(){
					_setRadio("ADOPT_PREPARE",$(this).val());
				});
				$("#tb_sqsy_en_ADOPT_PREPARE0").click(function(){
					_setRadio("ADOPT_PREPARE",$(this).val());
				});
				$("#tb_sqsy_en_ADOPT_PREPARE1").click(function(){
					_setRadio("ADOPT_PREPARE",$(this).val());
				});
				$("#tb_sqsy_cn_RISK_AWARENESS0").click(function(){
					_setRadio("RISK_AWARENESS",$(this).val());
				});
				$("#tb_sqsy_cn_RISK_AWARENESS1").click(function(){
					_setRadio("RISK_AWARENESS",$(this).val());
				});
				$("#tb_sqsy_en_RISK_AWARENESS0").click(function(){
					_setRadio("RISK_AWARENESS",$(this).val());
				});
				$("#tb_sqsy_en_RISK_AWARENESS1").click(function(){
					_setRadio("RISK_AWARENESS",$(this).val());
				});
				$("#tb_sqsy_cn_IS_SUBMIT_REPORT0").click(function(){
					_setRadio("IS_SUBMIT_REPORT",$(this).val());
				});
				$("#tb_sqsy_cn_IS_SUBMIT_REPORT1").click(function(){
					_setRadio("IS_SUBMIT_REPORT",$(this).val());
				});
				$("#tb_sqsy_en_IS_SUBMIT_REPORT0").click(function(){
					_setRadio("IS_SUBMIT_REPORT",$(this).val());
				});
				$("#tb_sqsy_en_IS_SUBMIT_REPORT1").click(function(){
					_setRadio("IS_SUBMIT_REPORT",$(this).val());
				});
				$("#tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG0").click(function(){
					_setRadio("IS_FAMILY_OTHERS_FLAG",$(this).val());
				});
				$("#tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG1").click(function(){
					_setRadio("IS_FAMILY_OTHERS_FLAG",$(this).val());
				});
				$("#tb_sqsy_en_IS_FAMILY_OTHERS_FLAG0").click(function(){
					_setRadio("IS_FAMILY_OTHERS_FLAG",$(this).val());
				});
				$("#tb_sqsy_en_IS_FAMILY_OTHERS_FLAG1").click(function(){
					_setRadio("IS_FAMILY_OTHERS_FLAG",$(this).val());
				});
				$("#tb_sqsy_cn_PARENTING0").click(function(){
					_setRadio("PARENTING",$(this).val());
				});
				$("#tb_sqsy_cn_PARENTING1").click(function(){
					_setRadio("PARENTING",$(this).val());
				});
				$("#tb_sqsy_en_PARENTING0").click(function(){
					_setRadio("PARENTING",$(this).val());
				});
				$("#tb_sqsy_en_PARENTING1").click(function(){
					_setRadio("PARENTING",$(this).val());
				});
		})
		
		
		function _setMale_health(p){
			if(p != 1){
				$("#tb_sqsy_cn_MALE_HEALTH_CONTENT_CN").show();
				$("#tb_sqsy_en_MALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#tb_sqsy_cn_MALE_HEALTH_CONTENT_CN").hide();
				$("#tb_sqsy_en_MALE_HEALTH_CONTENT_EN").hide();
			}
		}
		
		function _setFemale_health(p){
			if(p != 1){
				$("#tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN").show();
				$("#tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN").hide();
				$("#tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN").hide();
			}			
		}
		
		function _setMeasurement(m){
			measurement = m;
			if(m == "0"){	//0:����
				$("#tb_sqsy_cn_MALE_HEIGHT_INCH").hide();				
				$("#tb_sqsy_cn_MALE_WEIGHT_POUNDS").hide();							
				$("#tb_sqsy_cn_MALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_cn_MALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_POUNDS").hide();				
				$("#tb_sqsy_cn_FEMALE_HEIGHT_INCH").hide();	
				$("#tb_sqsy_cn_FEMALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_cn_MALE_HEIGHT").val(male_height);
				$("#tb_sqsy_cn_MALE_WEIGHT").val(male_weight);
				$("#tb_sqsy_cn_FEMALE_HEIGHT").val(female_height);			
				$("#tb_sqsy_cn_FEMALE_WEIGHT").val(female_weight);
				
				$("#tb_sqsy_en_MALE_HEIGHT_INCH").hide();
				$("#tb_sqsy_en_MALE_WEIGHT_POUNDS").hide();
				$("#tb_sqsy_en_FEMALE_WEIGHT_POUNDS").hide();				
				$("#tb_sqsy_en_FEMALE_HEIGHT_INCH").hide();	
							
				$("#tb_sqsy_en_MALE_HEIGHT_METRE").show();
				$("#tb_sqsy_en_MALE_WEIGHT_KILOGRAM").show();
				$("#tb_sqsy_en_FEMALE_HEIGHT_METRE").show();				
				$("#tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM").show();	
				
				$("#tb_sqsy_en_MALE_HEIGHT").val(male_height);
				$("#tb_sqsy_en_MALE_WEIGHT").val(male_weight);
				$("#tb_sqsy_en_FEMALE_HEIGHT").val(female_height);			
				$("#tb_sqsy_en_FEMALE_WEIGHT").val(female_weight);	
			}else{ //Ӣ��
				$("#tb_sqsy_cn_MALE_HEIGHT_INCH").show();
				$("#tb_sqsy_cn_MALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_cn_FEMALE_HEIGHT_INCH").show();
				$("#tb_sqsy_cn_FEMALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_cn_MALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_cn_MALE_WEIGHT_KILOGRAM").hide();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM").hide();
				
				$("#tb_sqsy_en_MALE_HEIGHT_INCH").show();
				$("#tb_sqsy_en_MALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_en_FEMALE_HEIGHT_INCH").show();
				$("#tb_sqsy_en_FEMALE_HEIGHT_METRE").hide();
				$("#tb_sqsy_en_MALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_en_MALE_WEIGHT_KILOGRAM").hide();
				$("#tb_sqsy_en_FEMALE_WEIGHT_POUNDS").show();
				$("#tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM").hide();

				//���������ת��ΪӢ�����,1Ӣ��=0.3048�ף�1Ӣ��=0.0254��
				var mh = converToValues(male_height,1);	
				var fh = converToValues(female_height,1);
				$("#tb_sqsy_cn_MALE_FEET").val(mh[0]);
				$("#tb_sqsy_cn_MALE_INCH").val(mh[1]);
				$("#tb_sqsy_cn_FEMALE_FEET").val(fh[0]);
				$("#tb_sqsy_cn_FEMALE_INCH").val(fh[1]);
				
				$("#tb_sqsy_en_MALE_FEET").val(mh[0]);
				$("#tb_sqsy_en_MALE_INCH").val(mh[1]);
				$("#tb_sqsy_en_FEMALE_FEET").val(fh[0]);
				$("#tb_sqsy_en_FEMALE_INCH").val(fh[1]);				
				
				var mw = converToValues(male_weight,3);
				var fw = converToValues(female_weight,3);				
				$("#tb_sqsy_cn_MALE_WEIGHT").val(mw);
				$("#tb_sqsy_cn_FEMALE_WEIGHT").val(fw);
				$("#tb_sqsy_en_MALE_WEIGHT").val(mw);
				$("#tb_sqsy_en_FEMALE_WEIGHT").val(fw);				
			}	
		}
	
	function _setBMI(s){		
		if(s=="1"){	//��������
			if(male_height=="" || male_weight==""){
				return;	
			}
			$("#tb_sqsy_cn_MALE_BMI").text(_bmi(male_height/100,male_weight));
			$("#tb_sqsy_en_MALE_BMI").text(_bmi(male_height/100,male_weight));
			
		}else if(s=="2"){//Ů������
			if(female_height=="" || female_weight==""){
				return;	
			}
			$("#tb_sqsy_cn_FEMALE_BMI").text(_bmi(female_height/100,female_weight));
			$("#tb_sqsy_en_FEMALE_BMI").text(_bmi(female_height/100,female_weight));
		}
			
	}
	
	function _bmi(h,w){
		return parseFloat(w / (h * h)).toFixed(2);
	}

	//����Υ����Ϊ�����´���	
	function _setMALE_PUNISHMENT_FLAG(f){
		MALE_PUNISHMENT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").get(0).checked = true;		
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").get(0).checked = true;			
			$("#tb_sqsy_cn_MALE_PUNISHMENT_CN").show();
			$("#tb_sqsy_en_MALE_PUNISHMENT_EN").show();
		}else{
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_PUNISHMENT_FLAG0").get(0).checked = true;
			
			$("#tb_sqsy_cn_MALE_PUNISHMENT_CN").hide();
			$("#tb_sqsy_en_MALE_PUNISHMENT_EN").hide();
		}	
	}
	
	//����Υ����Ϊ�����´���
	function _setFEMALE_PUNISHMENT_FLAG(f){
		FEMALE_PUNISHMENT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_CN").show();
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_EN").show();
		}else{
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_cn_FEMALE_PUNISHMENT_CN").hide();
			$("#tb_sqsy_en_FEMALE_PUNISHMENT_EN").hide();
		}			
	}
	
	//�������޲����Ⱥ�
	function _setMALE_ILLEGALACT_FLAG(f){
		MALE_ILLEGALACT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_cn_MALE_ILLEGALACT_CN").show();
			$("#tb_sqsy_en_MALE_ILLEGALACT_EN").show();
		}else{
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_MALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_MALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_sqsy_cn_MALE_ILLEGALACT_CN").hide();
			$("#tb_sqsy_en_MALE_ILLEGALACT_EN").hide();
		}			
	}
	
		//�������޲����Ⱥ�
	function _setFEMALE_ILLEGALACT_FLAG(f){
		FEMALE_ILLEGALACT_FLAG = f;
		if(f == "1"){
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").get(0).checked = true;				
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_CN").show();
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_EN").show();
		}else{
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0").get(0).checked = true;	
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1").removeAttr("checked");
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0").get(0).checked = true;				
			$("#tb_sqsy_cn_FEMALE_ILLEGALACT_CN").hide();
			$("#tb_sqsy_en_FEMALE_ILLEGALACT_EN").hide();
		}			
	}
	
	
	function _setRadio(rname,rvalue){
		var oc0 = "#tb_sqsy_cn_" + rname + "0";
		var oc1 = "#tb_sqsy_cn_" + rname + "1";
		var oe0 = "#tb_sqsy_en_" + rname + "0";
		var oe1 = "#tb_sqsy_en_" + rname + "1";
		if(rvalue == "1"){			
			$(oc0).removeAttr("checked");
			$(oc1).get(0).checked = true;	
			$(oe0).removeAttr("checked");
			$(oe1).get(0).checked = true;				
		}else{
			$(oc1).removeAttr("checked");
			$(oc0).get(0).checked = true;	
			
			$(oe1).removeAttr("checked");
			$(oe0).get(0).checked = true;				
		}			
	}
			
	/*
	* ���������޸�
	* o������
	* p����ǩҳ
	* n����������
	* s���Ա�
	*/
	function _chgBirthday(o,p,n,s){
		if(s=="1"){		
			document.getElementById("tb_sqsy_cn_MALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_sqsy_en_MALE_AGE").innerHTML = getAge(o.value);
		}else if(s=="2"){
			document.getElementById("tb_sqsy_cn_FEMALE_AGE").innerHTML = getAge(o.value);
			document.getElementById("tb_sqsy_en_FEMALE_AGE").innerHTML = getAge(o.value)
		}
		_chgValue(o,p,n);
	}
	
	/*
	*����޸�
	*/
	function _chgHeight(o,p,n,s){
		if(measurement == "0"){
			if(s=="1"){				
				male_height = o.value;
			}else if(s=="2"){
				female_height = o.value;	
			}
		}else if(measurement == "1"){
			var arr = new Array();
			var obj1,obj2;
			if(s=="1"){				
				obj1 = "#" + _getP1(p) + "MALE_FEET";
				obj2 = "#" + _getP1(p) + "MALE_INCH";			
				arr[0] = ($(obj1).val()!="")?$(obj1).val():0;
				arr[1] = ($(obj2).val()!="")?$(obj2).val():0;		
				male_height = converToValues(arr,2);			
			}else if(s=="2"){
				obj1 = "#" + _getP1(p) + "FEMALE_FEET";
				obj2 = "#" + _getP1(p) + "FEMALE_INCH";	
				arr[0] = ($(obj1).val()!="")?$(obj1).val():0;
				arr[1] = ($(obj2).val()!="")?$(obj2).val():0;

				female_height = converToValues(arr,2);
			}
		}
		_setBMI(s);
		_chgValue(o,p,n);
	}
	/*
	*Ӣ�������޸�
	*/	
	function _chgWeight(o,p,n,s){		
		if(measurement == "0"){
			if(s=="1"){				
				male_weight = o.value;
			}else if(s=="2"){
				female_weight = o.value;	
			}
		}else if(measurement == "1"){
			if(s=="1"){				
				male_weight = converToValues(o.value,4);
			}else if(s=="2"){		
				female_weight = converToValues(o.value,4);
			}
		}
		_setBMI(s);
		_chgValue(o,p,n);
	}
	
	/*
	* ��������޸�
	* o������
	* p����ǩҳ
	* n����������
	*/
	function _chgMarryDate(o,p,n){
		_setMarryLength(o.value);	
		_chgValue(o,p,n);
	}
	
	/*
	* ���ý��ʱ��
	* d���������
	*/
	function _setMarryLength(d){
		$("#tb_sqsy_cn_MARRY_LENGTH").text(getAge(d));
		$("#tb_sqsy_en_MARRY_LENGTH").text(getAge(d));
	}
	/*
	*��ͥ���ʲ��޸�
	*/
	function _chgTotalAsset(o,p,n){
		TOTAL_ASSET = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	*��ͥ��ծ���޸�
	*/
	function _chgTotalDebt(o,p,n){
		TOTAL_DEBT = o.value;
		_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
		_chgValue(o,p,n);
	}
	
	/*
	* ���ü�ͥ���ʲ�
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}		
		$("#tb_sqsy_cn_TOTAL_MANNY").text(a - d);
		$("#tb_sqsy_en_TOTAL_MANNY").text(a - d);	
	}
	/*
	* �������ı�������
	* o������
	* p����ǩҳ -1ʱ������Ҫ��Ӣ��ͬ��
	* n����������
	*/	
	function _chgValue(o,p,n){
		if(p!="-1"){
			var _id1 = _getP(p) + n;
			document.getElementById(_id1).value = o.value;			
		}
		var ret = o.value;
		
		//�����Ӣ����ߣ��������򱣴湫���������
		if(n=="MALE_FEET" || n=="MALE_INCH"){
			n = "MALE_HEIGHT";
			ret = male_height;
		}
		if(n=="FEMALE_FEET" || n=="FEMALE_INCH"){
			n = "FEMALE_HEIGHT";
			ret = female_height;
		}
		//�����Ӣ�����أ��������򱣴湫����������
		if(n=="MALE_WEIGHT" ){
			ret = male_weight;
		}
		if(n=="FEMALE_WEIGHT"){
			ret = female_weight;
		}
		
		//����ǵ������������Ů�������жϺ������Ա�����Ů���ڶ���ǰ��ǰ׺"FE"���������������Ӧ�ֶ�
		if(formType == "dqsy" || formType == "jzn"){
			if(ADOPTER_SEX == "2"){
				if(n.substr(0,4)=="MALE"){
					n = "FE" + n;
				}
			}
		}
		var _id2 = "P_" + n;
		document.getElementById(_id2).value = ret;
	}
	
	function _getP(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_sqsy_en_";		
			break;
		case 1:
			p1 = "tb_sqsy_cn_";
			break;	
		}
		return p1;
	}
	
	function _getP1(p){
		var p1;
		switch(p){
		case 0:
			p1 = "tb_sqsy_cn_";		
			break;
		case 1:
			p1 = "tb_sqsy_en_";
			break;	
		}
		return p1;
	}
	
	</script>
	
	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
         
        <BZ:input type="hidden" prefix="P_" field="MALE_NAME" id="P_MALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" defaultValue=""/> 
        <!--todo-->
        <BZ:input type="hidden" prefix="P_" field="MALE_PHOTO " id="P_MALE_PHOTO" defaultValue=""/> 
        <!--todo-->        
        <BZ:input type="hidden" prefix="P_" field="MALE_NATION" id="P_MALE_NATION " defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PASSPORT_NO" id="P_MALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_EDUCATION " id="P_MALE_EDUCATION " defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_CN" id="P_MALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_JOB_EN" id="P_MALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH" id="P_MALE_HEALTH" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_CN" id="P_MALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEALTH_CONTENT_EN" id="P_MALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEASUREMENT" id="P_MEASUREMENT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_HEIGHT" id="P_MALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_WEIGHT" id="P_MALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_BMI" id="P_MALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_FLAG" id="P_MALE_PUNISHMENT_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_CN" id="P_MALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_PUNISHMENT_EN" id="P_MALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_FLAG" id="P_MALE_ILLEGALACT_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_CN" id="P_MALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_ILLEGALACT_EN" id="P_MALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_RELIGION_CN" id="P_MALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_RELIGION_EN" id="P_MALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_MARRY_TIMES" id="P_MALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MALE_YEAP_INCOME" id="P_MALE_YEAP_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NAME" id="P_FEMALE_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PHOTO" id="P_FEMALE_PHOTO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_NATION" id="P_FEMALE_NATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PASSPORT_NO" id="P_FEMALE_PASSPORT_NO" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_EDUCATION" id="P_FEMALE_EDUCATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_CN" id="P_FEMALE_JOB_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_JOB_EN" id="P_FEMALE_JOB_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH" id="P_FEMALE_HEALTH" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_CN" id="P_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEALTH_CONTENT_EN" id="P_FEMALE_HEALTH_CONTENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_HEIGHT" id="P_FEMALE_HEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_WEIGHT" id="P_FEMALE_WEIGHT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_BMI" id="P_FEMALE_BMI" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_FLAG" id="P_FEMALE_PUNISHMENT_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_CN" id="P_FEMALE_PUNISHMENT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_PUNISHMENT_EN" id="P_FEMALE_PUNISHMENT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_FLAG" id="P_FEMALE_ILLEGALACT_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_CN" id="P_FEMALE_ILLEGALACT_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_ILLEGALACT_EN" id="P_FEMALE_ILLEGALACT_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_RELIGION_CN" id="P_FEMALE_RELIGION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_RELIGION_EN" id="P_FEMALE_RELIGION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_MARRY_TIMES" id="P_FEMALE_MARRY_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FEMALE_YEAP_INCOME" id="P_FEMALE_YEAP_INCOME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MARRY_CONDITION" id="P_MARRY_CONDITION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MARRY_DATE" 		id="P_MARRY_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CONABITA_PARTNERS" id="P_CONABITA_PARTNERS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CONABITA_PARTNERS_TIME" id="P_CONABITA_PARTNERS_TIME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="GAY_STATEMENT" id="P_GAY_STATEMENT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CURRENCY" id="P_CURRENCY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="TOTAL_ASSET" id="P_TOTAL_ASSET" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="TOTAL_DEBT" id="P_TOTAL_DEBT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILD_CONDITION_CN" id="P_CHILD_CONDITION_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILD_CONDITION_EN" id="P_CHILD_CONDITION_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="UNDERAGE_NUM" id="P_UNDERAGE_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADDRESS" id="P_ADDRESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_CN" id="P_ADOPT_REQUEST_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_REQUEST_EN" id="P_ADOPT_REQUEST_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="FINISH_DATE" id="P_FINISH_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HOMESTUDY_ORG_NAME" id="P_HOMESTUDY_ORG_NAME" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RECOMMENDATION_NUM" id="P_RECOMMENDATION_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="HEART_REPORT" id="P_HEART_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_MEDICALRECOVERY" id="P_IS_MEDICALRECOVERY" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_CN" id="P_MEDICALRECOVERY_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="MEDICALRECOVERY_EN" id="P_MEDICALRECOVERY_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FORMULATE" id="P_IS_FORMULATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_PREPARE" id="P_ADOPT_PREPARE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="RISK_AWARENESS" id="P_RISK_AWARENESS" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_ABUSE_ABANDON" id="P_IS_ABUSE_ABANDON" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_SUBMIT_REPORT" id="P_IS_SUBMIT_REPORT" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_FLAG" id="P_IS_FAMILY_OTHERS_FLAG" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_CN" id="P_IS_FAMILY_OTHERS_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="IS_FAMILY_OTHERS_EN" id="P_IS_FAMILY_OTHERS_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ADOPT_MOTIVATION" id="P_ADOPT_MOTIVATION" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_ABOVE" id="P_CHILDREN_ABOVE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="INTERVIEW_TIMES" id="P_INTERVIEW_TIMES" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="ACCEPTED_CARD" id="P_ACCEPTED_CARD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="PARENTING" id="P_PARENTING" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SOCIALWORKER" id="P_SOCIALWORKER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="REMARK_CN" id="P_REMARK_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="REMARK_EN" id="P_REMARK_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="GOVERN_DATE" id="P_GOVERN_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="VALID_PERIOD" id="P_VALID_PERIOD" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="APPROVE_CHILD_NUM" id="P_APPROVE_CHILD_NUM" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="AGE_FLOOR" 			id="P_AGE_FLOOR" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="AGE_UPPER" 			id="P_AGE_UPPER" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_SEX" 		id="P_CHILDREN_SEX" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_HEALTH_CN" 	id="P_CHILDREN_HEALTH_CN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CHILDREN_HEALTH_EN" 	id="P_CHILDREN_HEALTH_EN" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="PACKAGE_ID" 			id="P_PACKAGE_ID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CREATE_USERID" 		id="P_CREATE_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="CREATE_DATE" 		id="P_CREATE_DATE" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SUBMIT_USERID" 		id="P_SUBMIT_USERID" defaultValue=""/> 
        <BZ:input type="hidden" prefix="P_" field="SUBMIT_DATE" 		id="P_SUBMIT_DATE" defaultValue=""/> 
		<!-- ��������end -->
		
        <div id="tab-container" class='tab-container'>
            <ul class='etabs'>
                <li class='tab'><a href="#tab1">������Ϣ(����)</a></li>
                <li class='tab'><a href="#tab2">������Ϣ(����)</a></li>
            </ul>
			<div class='panel-container'>
            	<!--��ͥ�������(��)��start-->
            	<div id="tab1">
                	<!--�ļ�������Ϣ��start-->
                    <table class="specialtable">
                        <tr>
                            <td class="edit-data-title" width="15%">������֯(CN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">������֯(EN)</td>
                            <td class="edit-data-value" colspan="5">
                                <BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="edit-data-title">�ļ�����</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
                            </td>
                            <td class="edit-data-title" width="15%">��������</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
                            </td>
                            <td class="edit-data-title" width="15%">���ı��</td>
                            <td class="edit-data-value" width="18%">
                                <BZ:dataValue field="FILE_NO" hrefTitle="���ı��" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                    </table>
                    <!--�ļ�������Ϣ��end-->
                    <!--˫��������start-->
                    <table class="specialtable" id="tb_sqsy_cn">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--��������Ϣ��start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value" colspan="2">
                                            <input type="text" id="tb_sqsy_cn_MALE_NAME" value="<BZ:dataValue field="MALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,0,'MALE_NAME')" maxlength="150">
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <input type="text" id="tb_sqsy_cn_FEMALE_NAME" value="<BZ:dataValue field="FEMALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,0,'FEMALE_NAME')" maxlength="150">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value" colspan="2">
                                            <input onclick="error_onclick(this);"  style="width:166px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="�������˳�������"  id="tb_sqsy_cn_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <input onclick="error_onclick(this);"  style="width:166px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="Ů�����˳�������"  id="tb_sqsy_cn_FEMALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,0,'FEMALE_BIRTHDAY','2')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<div id="tb_sqsy_cn_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge($("#tb_sqsy_cn_MALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2" style="font-size:14px">
                                        	<div id="tb_sqsy_cn_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge($("#tb_sqsy_cn_FEMALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">����</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_sqsy_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="170px"></BZ:select>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="FEMALE_NATION" formTitle="����" codeName="GJ" isCode="true"  defaultValue="" id="tb_sqsy_cn_FEMALE_NATION" onchange="_chgValue(this,0,'FEMALE_NATION')" width="170px"></BZ:select>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">���պ���</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="MALE_PASSPORT_NO" id="tb_sqsy_cn_MALE_PASSPORT_NO" type="String" formTitle="�������˻��պ���" defaultValue="" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')" style="width:166px"/>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="FEMALE_PASSPORT_NO" id="tb_sqsy_cn_FEMALE_PASSPORT_NO" type="String" formTitle="Ů�����˻��պ���" defaultValue="" onchange="_chgValue(this,0,'FEMALE_PASSPORT_NO')" style="width:166px"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">�ܽ����̶�</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="MALE_EDUCATION" formTitle="���������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_cn_MALE_EDUCATION" onchange="_chgValue(this,0,'MALE_EDUCATION')"></BZ:select>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select field="FEMALE_EDUCATION" formTitle="Ů�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_cn_FEMALE_EDUCATION" onchange="_chgValue(this,0,'FEMALE_EDUCATION')"></BZ:select>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">ְҵ</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="MALE_JOB_CN" type="String" formTitle="��������ְҵ" defaultValue=""  id="tb_sqsy_cn_MALE_JOB_CN" onchange="_chgValue(this,-1,'MALE_JOB_CN')" style="width:166px"/>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:input field="FEMALE_JOB_CN" type="String" formTitle="Ů������ְҵ" defaultValue="" id="tb_sqsy_cn_FEMALE_JOB_CN" onchange="_chgValue(this,-1,'FEMALE_JOB_CN')" style="width:166px"/>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<BZ:select width="100px" field="MALE_HEALTH" formTitle="�������˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_cn_MALE_HEALTH" onchange="_chgValue(this,0,'MALE_HEALTH')"></BZ:select>
                                            
                                        	<textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_CN" id="tb_sqsy_cn_MALE_HEALTH_CONTENT_CN">					
                                        	<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
                                        	</textarea>
                                        </td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<BZ:select width="100px" field="FEMALE_HEALTH" prefix="P_" formTitle="Ů�����˽���״��"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_cn_FEMALE_HEALTH" onchange="_chgValue(this,0,'FEMALE_HEALTH')"></BZ:select>
                                    		<textarea style="height: 20px;width: 60%;" name="P_FEMALE_HEALTH_CONTENT_CN" id="tb_sqsy_cn_FEMALE_HEALTH_CONTENT_CN">
                                    		<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
                                    		</textarea>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:select field="MEASUREMENT" id="tb_sqsy_cn_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,0,'MEASUREMENT')">
                                                <BZ:option value="0">����</BZ:option>
                                                <BZ:option value="1">Ӣ��</BZ:option>
                                            </BZ:select>
                                            <span id="tb_sqsy_cn_MALE_HEIGHT_INCH" style="display: none">
                                                <BZ:input field="MALE_FEET" id="tb_sqsy_cn_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'MALE_FEET','1')"/>Ӣ��(Feet)
                                                <BZ:input field="MALE_INCH" id="tb_sqsy_cn_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'MALE_INCH','1')"/>Ӣ��(Inch)
                                            </span>
                                            <span id="tb_sqsy_cn_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_sqsy_cn_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,0,'MALE_HEIGHT','1')"/>����</span>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <span id="tb_sqsy_cn_FEMALE_HEIGHT_INCH" style="display: none">
                                                <BZ:input field="FEMALE_FEET" id="tb_sqsy_cn_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'FEMALE_FEET','2')"/>Ӣ��(Feet)
                                                <BZ:input field="FEMALE_INCH" id="tb_sqsy_cn_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,0,'FEMALE_INCH','2')"/>Ӣ��(Inch)
                                            </span>
                                            <span id="tb_sqsy_cn_FEMALE_HEIGHT_METRE"><BZ:input field="FEMALE_HEIGHT" id="tb_sqsy_cn_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,0,'FEMALE_HEIGHT','2')"/>����</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_WEIGHT" id="tb_sqsy_cn_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" onchange="_chgWeight(this,0,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_sqsy_cn_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_sqsy_cn_MALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_WEIGHT" id="tb_sqsy_cn_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setFemaleBMI()" onchange="_chgWeight(this,0,'FEMALE_WEIGHT','2')" maxlength="50"/><span id="tb_sqsy_cn_FEMALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_sqsy_cn_FEMALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">����ָ��</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<div id="tb_sqsy_cn_MALE_BMI" style="font-size:14px">&nbsp;</div>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    		<div id="tb_sqsy_cn_FEMALE_BMI" style="font-size:14px">&nbsp;</div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                            <input type="radio" name="tb_sqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                            <BZ:input field="MALE_PUNISHMENT_CN" id="tb_sqsy_cn_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_CN')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_FLAG')">��
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_cn_FEMALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_FLAG')">��
                                            <BZ:input field="FEMALE_PUNISHMENT_CN" id="tb_sqsy_cn_FEMALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_CN')"/>
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">���޲����Ⱥ�</td>
                                        <td class="edit-data-value" colspan="2">
                                        	<input type="radio" name="tb_sqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                            <input type="radio" name="tb_sqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                            <BZ:input field="MALE_ILLEGALACT_CN" id="tb_sqsy_cn_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_CN')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">��
                                            <input type="radio" name="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_cn_FEMALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">��
                                            <BZ:input field="FEMALE_ILLEGALACT_CN" id="tb_sqsy_cn_FEMALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ڽ�����</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_RELIGION_CN" id="tb_sqsy_cn_MALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_RELIGION_CN" id="tb_sqsy_cn_FEMALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'FEMALE_RELIGION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="4">�ѻ�</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���ҵ�λ</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:select field="CURRENCY" id="tb_sqsy_cn_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="170px" onchange="_chgValue(this,0,'CURRENCY')"></BZ:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_YEAR_INCOME" id="tb_sqsy_cn_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'MALE_YEAR_INCOME')" maxlength="22"/>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_YEAR_INCOME" id="tb_sqsy_cn_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'FEMALE_YEAR_INCOME')" maxlength="22"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">ǰ�����</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_cn_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'MALE_MARRY_TIMES')"/>��
                                        </td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_cn_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'FEMALE_MARRY_TIMES')"/>��
                                        </td>
                                    </tr>                                                                       
                                </table>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" width="15%">����״��</td>
                                        <td class="edit-data-value" width="18%">�ѻ�</td>
                                        <td class="edit-data-title" width="15%">�������</td>
                                        <td class="edit-data-value" width="18%">
                                            <BZ:input field="MARRY_DATE" id="tb_sqsy_cn_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,0,'MARRY_DATE')"/>
                                        </td>
                                        <td class="edit-data-title" width="15%">����ʱ�����꣩</td>
                                        <td class="edit-data-value" width="19%">
                                            <div id="tb_sqsy_cn_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="TOTAL_ASSET" id="tb_sqsy_cn_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                        </td>
                                        <td class="edit-data-title">��ͥ��ծ��</td>
                                        <td class="edit-data-value">
                                            <BZ:input  field="TOTAL_DEBT" id="tb_sqsy_cn_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                        </td>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value">
                                            <div id="tb_sqsy_cn_TOTAL_MANNY"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">18����������Ů����</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="UNDERAGE_NUM" id="tb_sqsy_cn_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��Ů���������</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="CHILD_CONDITION_CN" id="tb_sqsy_cn_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,0,'CHILD_CONDITION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥסַ</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="ADDRESS" id="tb_sqsy_cn_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">����Ҫ��</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="ADOPT_REQUEST_CN" id="tb_sqsy_cn_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ɼҵ���֯����</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="HOMESTUDY_ORG_NAME" id="tb_sqsy_cn_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" maxlength="200" style="width:80%"  onchange="_chgValue(this,0,'HOMESTUDY_ORG_NAME')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ�����������</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="FINISH_DATE" id="tb_sqsy_cn_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,0,'FINISH_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">����������Σ�</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="INTERVIEW_TIMES" id="tb_sqsy_cn_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'INTERVIEW_TIMES')"/>
                                        </td>                                    
                                        <td class="edit-data-title">�Ƽ��ţ��⣩</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="RECOMMENDATION_NUM" id="tb_sqsy_cn_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'RECOMMENDATION_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="HEART_REPORT" id="tb_sqsy_cn_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT"  notnull="" width="70%" onchange="_chgValue(this,0,'HEART_REPORT')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="ADOPT_MOTIVATION" id="tb_sqsy_cn_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,0,'ADOPT_MOTIVATION')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    
                                        <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_ABOVE" id="tb_sqsy_cn_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,0,'CHILDREN_ABOVE')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ָ���໤��</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_FORMULATE" id="tb_sqsy_cn_IS_FORMULATE0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_IS_FORMULATE" id="tb_sqsy_cn_IS_FORMULATE1" value="1">��
                                        </td>
                                        <td class="edit-data-title">��������Ű������</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_ABUSE_ABANDON" id="tb_sqsy_cn_IS_ABUSE_ABANDON0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_IS_ABUSE_ABANDON" id="tb_sqsy_cn_IS_ABUSE_ABANDON1" value="1">��
                                        </td>
                                    
                                        <td class="edit-data-title">�����ƻ�</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_MEDICALRECOVERY" id="tb_sqsy_cn_IS_MEDICALRECOVERY0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_IS_MEDICALRECOVERY" id="tb_sqsy_cn_IS_MEDICALRECOVERY1" value="1">��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ǰ׼��</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_ADOPT_PREPARE" id="tb_sqsy_cn_ADOPT_PREPARE0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_ADOPT_PREPARE" id="tb_sqsy_cn_ADOPT_PREPARE1" value="1">��
                                        </td>
                                        <td class="edit-data-title">������ʶ</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_RISK_AWARENESS" id="tb_sqsy_cn_RISK_AWARENESS0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_RISK_AWARENESS" id="tb_sqsy_cn_RISK_AWARENESS1" value="1">��
                                        </td>
                                   
                                        <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_SUBMIT_REPORT" id="tb_sqsy_cn_IS_SUBMIT_REPORT0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_IS_SUBMIT_REPORT" id="tb_sqsy_cn_IS_SUBMIT_REPORT1" value="1">��
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_PARENTING" id="tb_sqsy_cn_PARENTING0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_PARENTING" id="tb_sqsy_cn_PARENTING1" value="1">��
                                        </td>
                                        <td class="edit-data-title">�繤���</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="SOCIALWORKER" id="tb_sqsy_cn_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,0,'SOCIALWORKER')" >
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                                <BZ:option value="1">֧��</BZ:option>
                                                <BZ:option value="2">�������</BZ:option>
                                                <BZ:option value="3">��֧��</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������������ͬס</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG0" value="0">��
                                            <input type="radio" name="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_cn_IS_FAMILY_OTHERS_FLAG1" value="1">��
                                        </td>
                                        <td class="edit-data-title">����������ͬס˵��</td>
                                        <td class="edit-data-value" colspan="3">
                                            <BZ:input field="IS_FAMILY_OTHERS_CN" id="tb_sqsy_cn_IS_FAMILY_OTHERS_CN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ��˵������������</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="REMARK_CN" id="tb_sqsy_cn_REMARK_CN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="GOVERN_DATE" id="tb_sqsy_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_sqsy_cn_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">��Ч����</BZ:option>
                                                <BZ:option value="2">����</BZ:option>
                                            </BZ:select>
                                            <BZ:input field="VALID_PERIOD" id="tb_sqsy_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>��
                                        </td>
                                        <td class="edit-data-title">��׼��ͯ����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="APPROVE_CHILD_NUM" id="tb_sqsy_cn_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'APPROVE_CHILD_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������ͯ����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="AGE_FLOOR" id="tb_sqsy_cn_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_FLOOR')"/>��~
                                            <BZ:input field="AGE_UPPER" id="tb_sqsy_cn_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_UPPER')"/>��
                                        </td>
                                        <td class="edit-data-title">������ͯ�Ա�</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_SEX" id="tb_sqsy_cn_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,0,'CHILDREN_SEX')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">������ͯ����״��</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_HEALTH_EN" id="tb_sqsy_cn_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%"  onchange="_chgValue(this,0,'CHILDREN_HEALTH_EN')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
                                </table>                                 
                            </td>
                        </tr> 
                    <!--˫��������end--> 
                    </table>
                    <!--����������start-->
                    <table id="tb_dqsy_cn" class="specialtable" style="display:block">
                    	<tr>
                             <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--��������Ϣ��start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>
                                        <td class="edit-data-title" width="15%">��������</td>
                                        <td class="edit-data-value" width="25%">
                                            <BZ:input field="MALE_NAME" id="tb_dqsy_cn_MALE_NAME" formTitle="" defaultValue="" notnull=""  maxlength="150" onchange="_chgValue(this,0,'MALE_NAME')"/>
                                        </td>
                                        <td class="edit-data-title" width="15%">�Ա�</td>
                                        <td class="edit-data-value" width="25%">
                                            <BZ:select field="ADOPTER_SEX" id="tb_dqsy_cn_ADOPTER_SEX" formTitle="" defaultValue="" notnull="" width="166px" onchange="_chgValue(this,0,'ADOPTER_SEX')">
                                                <BZ:option value="1">��</BZ:option>
                                                <BZ:option value="2">Ů</BZ:option>
                                            </BZ:select>					
                                        </td>
                                        <td class="edit-data-value" width="20%" rowspan="6">
                                            ��Ƭ
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_BIRTHDAY" id="tb_dqsy_cn_MALE_BIRTHDAY" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')"/>
                                        </td>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
                                            <script>
                                            document.write(getAge($("#tb_dqsy_cn_MALE_BIRTHDAY").val()));
                                            </script>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_dqsy_cn_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="166px"></BZ:select>
                                        </td>
                                        <td class="edit-data-title">���պ���</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_PASSPORT_NO" id="tb_dqsy_cn_MALE_PASSPORT_NO" type="String" formTitle="�����˻��պ���" defaultValue="" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')" style="width:166px"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ܽ����̶�</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MALE_EDUCATION" formTitle="�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_dqsy_cn_MALE_EDUCATION" width="166px" onchange="_chgValue(this,0,'MALE_EDUCATION')"></BZ:select>
                                        </td>
                                        <td class="edit-data-title">ְҵ</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_JOB_CN" type="String" formTitle="������ְҵ" defaultValue=""  id="tb_dqsy_cn_MALE_JOB_CN" onchange="_chgValue(this,-1,'MALE_JOB_CN')" style="width:166px"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="3">
                                            <BZ:select width="100px" field="MALE_HEALTH" formTitle="�����˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_dqsy_cn_MALE_HEALTH" onchange="_chgValue(this,0,'MALE_HEALTH')"></BZ:select>					
                                            <textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_CN" id="tb_dqsy_cn_MALE_HEALTH_CONTENT_CN">		
                                            <BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="MEASUREMENT" id="tb_dqsy_cn_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,0,'MEASUREMENT')">
                                                <BZ:option value="0">����</BZ:option>
                                                <BZ:option value="1">Ӣ��</BZ:option>
                                            </BZ:select>
                                            <span id="tb_dqsy_cn_MALE_HEIGHT_INCH" style="display: none">
                                                <BZ:input field="MALE_FEET" id="tb_dqsy_cn_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_FEET','1')"/>Ӣ��(Feet)
                                                <BZ:input field="MALE_INCH" id="tb_dqsy_cn_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_INCH','1')"/>Ӣ��(Inch)
                                            </span>
                                            <span id="tb_dqsy_cn_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_dqsy_cn_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" size="10" onchange="_chgHeight(this,0,'MALE_HEIGHT','1')"/>����</span>
                                        </td>
                                        <td class="edit-data-title">����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_WEIGHT" id="tb_dqsy_cn_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" size="10" onchange="_chgWeight(this,0,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_dqsy_cn_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_dqsy_cn_MALE_WEIGHT_KILOGRAM">ǧ��</span>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">����ָ��</td>
                                        <td class="edit-data-value" colspan="4">
                                            <div id="tb_dqsy_cn_MALE_BMI" style="font-size:14px">&nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_dqsy_cn_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                            <input type="radio" name="tb_dqsy_cn_MALE_PUNISHMENT_FLAG" id="tb_dqsy_cn_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                            <BZ:input field="MALE_PUNISHMENT_CN" id="tb_dqsy_cn_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_CN')"/>
                                        </td>
                                        <td class="edit-data-title">���޲����Ⱥ�</td>
                                        <td class="edit-data-value" colspan="2">
                                            <input type="radio" name="tb_dqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_dqsy_cn_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                            <input type="radio" name="tb_dqsy_cn_MALE_ILLEGALACT_FLAG" id="tb_dqsy_cn_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                            <BZ:input field="MALE_ILLEGALACT_CN" id="tb_dqsy_cn_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ڽ�����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="MALE_RELIGION_CN" id="tb_dqsy_cn_MALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>
                                        </td>
                                        <td class="edit-data-title">����״��</td>
                                        <td class="edit-data-value" colspan="2">
                                        <BZ:select field="MARRY_CONDITION" id="tb_dqsy_cn_MARRY_CONDITION" formTitle=""  defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" notnull="" width="166px" onchange="_chgValue(this,0,'MARRY_CONDITION')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                        </BZ:select>                                       
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">ͬ�ӻ��</td>
                                        <td class="edit-data-value">
                                            <BZ:radio field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
                                            <BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
                                        </td>
                                        <td class="edit-data-title">ͬ��ʱ��</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input  field="CONABITA_PARTNERS_TIME" id="tb_dqsy_cn_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͬ��������</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:radio field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">��</BZ:radio>
                                            <BZ:radio field="GAY_STATEMENT" value="1" formTitle="" >��</BZ:radio>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">���ҵ�λ</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CURRENCY" id="tb_dqsy_cn_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="166px" onchange="_chgValue(this,0,'CURRENCY')"></BZ:select>
                                        </td>
                                        <td class="edit-data-title">������</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input field="MALE_YEAR_INCOME" id="tb_dqsy_cn_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'MALE_YEAR_INCOME')" maxlength="22"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="TOTAL_ASSET" id="tb_dqsy_cn_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                        </td>
                                        <td class="edit-data-title">��ͥ��ծ��</td>
                                        <td class="edit-data-value" colspan="2">
                                            <BZ:input  field="TOTAL_DEBT" id="tb_dqsy_cn_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ���ʲ�</td>
                                        <td class="edit-data-value" colspan="4">
                                            <div id="tb_dqsy_cn_TOTAL_MANNY"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">18����������Ů����</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="UNDERAGE_NUM" id="tb_dqsy_cn_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��Ů���������</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="CHILD_CONDITION_CN" id="tb_dqsy_cn_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,0,'CHILD_CONDITION_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥסַ</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADDRESS" id="tb_dqsy_cn_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����Ҫ��</td>
                                        <td class="edit-data-value" colspan="4">
                                            <BZ:input field="ADOPT_REQUEST_CN" id="tb_dqsy_cn_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
                                        </td>
                                    </tr>
                                </table>
                                <table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ɼҵ���֯����</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="HOMESTUDY_ORG_NAME" id="tb_dqsy_cn_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" maxlength="200" style="width:80%"  onchange="_chgValue(this,0,'HOMESTUDY_ORG_NAME')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" style="width:15%">��ͥ�����������</td>
                                        <td class="edit-data-value" style="width:18%">
                                            <BZ:input field="FINISH_DATE" id="tb_dqsy_cn_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,0,'FINISH_DATE')"/>
                                        </td>
                                        <td class="edit-data-title" style="width:15%">����������Σ�</td>
                                        <td class="edit-data-value" style="width:18%">
                                            <BZ:input field="INTERVIEW_TIMES" id="tb_dqsy_cn_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'INTERVIEW_TIMES')"/>
                                        </td>                                    
                                        <td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
                                        <td class="edit-data-value" style="width:19%">
                                            <BZ:input field="RECOMMENDATION_NUM" id="tb_dqsy_cn_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'RECOMMENDATION_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="HEART_REPORT" id="tb_dqsy_cn_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT"  notnull="" width="70%" onchange="_chgValue(this,0,'HEART_REPORT')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="ADOPT_MOTIVATION" id="tb_dqsy_cn_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,0,'ADOPT_MOTIVATION')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    
                                        <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_ABOVE" id="tb_dqsy_cn_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,0,'CHILDREN_ABOVE')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ָ���໤��</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_IS_FORMULATE" id="tb_dqsy_cn_IS_FORMULATE0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_IS_FORMULATE" id="tb_dqsy_cn_IS_FORMULATE1" value="1">��
                                        </td>
                                        <td class="edit-data-title">��������Ű������</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_IS_ABUSE_ABANDON" id="tb_dqsy_cn_IS_ABUSE_ABANDON0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_IS_ABUSE_ABANDON" id="tb_dqsy_cn_IS_ABUSE_ABANDON1" value="1">��
                                        </td>
                                    
                                        <td class="edit-data-title">�����ƻ�</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_IS_MEDICALRECOVERY" id="tb_dqsy_cn_IS_MEDICALRECOVERY0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_IS_MEDICALRECOVERY" id="tb_dqsy_cn_IS_MEDICALRECOVERY1" value="1">��
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">����ǰ׼��</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_ADOPT_PREPARE" id="tb_dqsy_cn_ADOPT_PREPARE0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_ADOPT_PREPARE" id="tb_dqsy_cn_ADOPT_PREPARE1" value="1">��
                                        </td>
                                        <td class="edit-data-title">������ʶ</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_RISK_AWARENESS" id="tb_dqsy_cn_RISK_AWARENESS0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_RISK_AWARENESS" id="tb_dqsy_cn_RISK_AWARENESS1" value="1">��
                                        </td>
                                   
                                        <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_IS_SUBMIT_REPORT" id="tb_dqsy_cn_IS_SUBMIT_REPORT0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_IS_SUBMIT_REPORT" id="tb_dqsy_cn_IS_SUBMIT_REPORT1" value="1">��
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">��������</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_PARENTING" id="tb_dqsy_cn_PARENTING0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_PARENTING" id="tb_dqsy_cn_PARENTING1" value="1">��
                                        </td>
                                        <td class="edit-data-title">�繤���</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="SOCIALWORKER" id="tb_dqsy_cn_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,0,'SOCIALWORKER')" >
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                                <BZ:option value="1">֧��</BZ:option>
                                                <BZ:option value="2">�������</BZ:option>
                                                <BZ:option value="3">��֧��</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��������������ͬס</td>
                                        <td class="edit-data-value">
                                            <input type="radio" name="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG0" value="0">��
                                            <input type="radio" name="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_cn_IS_FAMILY_OTHERS_FLAG1" value="1">��
                                        </td>
                                        <td class="edit-data-title">����������ͬס˵��</td>
                                        <td class="edit-data-value" colspan="3">
                                            <BZ:input field="IS_FAMILY_OTHERS_CN" id="tb_dqsy_cn_IS_FAMILY_OTHERS_CN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��ͥ��˵������������</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:input field="REMARK_CN" id="tb_dqsy_cn_REMARK_CN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">��׼����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="GOVERN_DATE" id="tb_dqsy_cn_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
                                        </td>
                                        <td class="edit-data-title">��Ч����</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="VALID_PERIOD_TYPE" id="tb_dqsy_cn_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'VALID_PERIOD_TYPE')">
                                                <BZ:option value="1">��Ч����</BZ:option>
                                                <BZ:option value="2">����</BZ:option>
                                            </BZ:select>
                                            <BZ:input field="VALID_PERIOD" id="tb_dqsy_cn_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>��
                                        </td>
                                        <td class="edit-data-title">��׼��ͯ����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="APPROVE_CHILD_NUM" id="tb_dqsy_cn_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'APPROVE_CHILD_NUM')"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������ͯ����</td>
                                        <td class="edit-data-value">
                                            <BZ:input field="AGE_FLOOR" id="tb_dqsy_cn_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_FLOOR')"/>��~
                                            <BZ:input field="AGE_UPPER" id="tb_dqsy_cn_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_UPPER')"/>��
                                        </td>
                                        <td class="edit-data-title">������ͯ�Ա�</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_SEX" id="tb_dqsy_cn_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,0,'CHILDREN_SEX')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                        <td class="edit-data-title">������ͯ����״��</td>
                                        <td class="edit-data-value">
                                            <BZ:select field="CHILDREN_HEALTH_EN" id="tb_dqsy_cn_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%"  onchange="_chgValue(this,0,'CHILDREN_HEALTH_EN')">
                                                <BZ:option value="">--��ѡ��--</BZ:option>
                                            </BZ:select>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> 
                    <!--����������end-->
                    <!--����Ů������start-->
                    <table id="tb_jzn_cn" class="specialtable" style="display:block">
                    	<tr><td>����Ů�����������ӣ���������</td></tr>
					</table>
                    <!--����Ů������end-->                      
                </div>
                <!--��ͥ�������(��)��end-->
                <!--��ͥ�������(��)��start-->
                <div id="tab2">
                	<table class="specialtable">
                    	<tr>
                        	<td>
                            	<!--�ļ�������Ϣ��start-->
                                <table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" width="15%">������֯(CN)</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">������֯(EN)</td>
                                        <td class="edit-data-value" colspan="5">
                                            <BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">�ļ�����</td>
                                        <td class="edit-data-value" width="18%">
                                            <BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
                                        </td>
                                        <td class="edit-data-title" width="15%">��������</td>
                                        <td class="edit-data-value" width="18%">
                                            <BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
                                        </td>
                                        <td class="edit-data-title" width="15%">���ı��</td>
                                        <td class="edit-data-value" width="18%">
                                            <BZ:dataValue field="FILE_NO" hrefTitle="���ı��" defaultValue="" />
                                        </td>
                                    </tr>
                                </table>
                                <!--�ļ�������Ϣ��end-->
                            </td>
                        </tr>                         
                        <tr>
                            <td>
                                <!--˫��������start-->                            	  
                                <table class="specialtable"  id="tb_sqsy_en" style="display:block">
                                	<tr>
                                         <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                    	<td>
                                        	<table class="specialtable">
                                                <tr>                                    	
                                                    <td class="edit-data-title" width="15%">&nbsp;</td>
                                                    <td class="edit-data-title" colspan="2" style="text-align:center">��������</td>
                                                    <td class="edit-data-title" colspan="2" style="text-align:center">Ů������</td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title"><font color="red">*</font>��������</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="text" id="tb_sqsy_en_MALE_NAME" value="<BZ:dataValue field="MALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,1,'MALE_NAME')" maxlength="150">
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="text" id="tb_sqsy_en_FEMALE_NAME" value="<BZ:dataValue field="FEMALE_NAME" onlyValue="true"/>" onchange="_chgValue(this,1,'FEMALE_NAME')" maxlength="150">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input onclick="error_onclick(this);"  style="width:166px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="�������˳�������"  id="tb_sqsy_en_MALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,1,'MALE_BIRTHDAY','1')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input onclick="error_onclick(this);"  style="width:166px;height:18px;padding-top:4px;padding-left:2px;font-size: 12px;" formTitle="Ů�����˳�������"  id="tb_sqsy_en_FEMALE_BIRTHDAY" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" value="<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>" onchange="_chgBirthday(this,1,'FEMALE_BIRTHDAY','2')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <div id="tb_sqsy_en_MALE_AGE" style="font-size:14px">
                                                        <script>
                                                        document.write(getAge($("#tb_sqsy_en_MALE_BIRTHDAY").val()));
                                                        </script>
                                                        </div>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2" style="font-size:14px">
                                                        <div id="tb_sqsy_en_FEMALE_AGE" style="font-size:14px">
                                                        <script>
                                                        document.write(getAge($("#tb_sqsy_en_FEMALE_BIRTHDAY").val()));
                                                        </script>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue=""  id="tb_sqsy_en_MALE_NATION" onchange="_chgValue(this,1,'MALE_NATION')"></BZ:select>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select field="FEMALE_NATION" formTitle="����" codeName="GJ" isCode="true"  defaultValue="" id="tb_sqsy_en_FEMALE_NATION" onchange="_chgValue(this,1,'FEMALE_NATION')"></BZ:select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">���պ���</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_PASSPORT_NO" id="tb_sqsy_en_MALE_PASSPORT_NO" type="String" formTitle="�������˻��պ���" defaultValue="" onchange="_chgValue(this,1,'MALE_PASSPORT_NO')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_PASSPORT_NO" id="tb_sqsy_en_FEMALE_PASSPORT_NO" type="String" formTitle="Ů�����˻��պ���" defaultValue="" onchange="_chgValue(this,1,'FEMALE_PASSPORT_NO')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">�ܽ����̶�</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select field="MALE_EDUCATION" formTitle="���������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_en_MALE_EDUCATION" onchange="_chgValue(this,1,'MALE_EDUCATION')"></BZ:select>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select field="FEMALE_EDUCATION" formTitle="Ů�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_sqsy_en_FEMALE_EDUCATION" onchange="_chgValue(this,1,'FEMALE_EDUCATION')"></BZ:select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">ְҵ</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_JOB_EN" type="String" formTitle="��������ְҵ" defaultValue=""  id="tb_sqsy_en_MALE_JOB_EN" onchange="_chgValue(this,-1,'MALE_JOB_EN')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_JOB_EN" prefix="P_" type="String" formTitle="Ů������ְҵ" defaultValue="" id="tb_sqsy_en_FEMALE_JOB_EN" onchange="_chgValue(this,-1,'FEMALE_JOB_EN')" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����״��</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select width="100px" field="MALE_HEALTH" prefix="P_" formTitle="�������˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_en_MALE_HEALTH" onchange="_chgValue(this,1,'MALE_HEALTH')"></BZ:select>
                                                        <textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_MALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'MALE_HEALTH_CONTENT_EN')">
                                                        <BZ:dataValue field="MALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
                                                        </textarea>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select width="100px" field="FEMALE_HEALTH" prefix="P_" formTitle="Ů�����˽���״��"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue="" id="tb_sqsy_en_FEMALE_HEALTH" onchange="_chgValue(this,1,'FEMALE_HEALTH')"></BZ:select>
                                                        <textarea style="height: 20px;width: 60%;" name="P_FEMALE_HEALTH_CONTENT_EN" id="tb_sqsy_en_FEMALE_HEALTH_CONTENT_EN" onchange="_chgValue(this,-1,'FEMALE_HEALTH_CONTENT_EN')">
                                                        <BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
                                                        </textarea>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td class="edit-data-title">���</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:select field="MEASUREMENT" id="tb_sqsy_en_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,1,'MEASUREMENT')">
                                                            <BZ:option value="0">����</BZ:option>
                                                            <BZ:option value="1">Ӣ��</BZ:option>
                                                        </BZ:select>
                                                        <span id="tb_sqsy_en_MALE_HEIGHT_INCH" style="display: none">
                                                            <BZ:input field="MALE_FEET" id="tb_sqsy_en_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'MALE_FEET','1')"/>Ӣ��(Feet)
                                                            <BZ:input field="MALE_INCH" id="tb_sqsy_en_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'MALE_INCH','1')"/>Ӣ��(Inch)
                                                        </span>
                                                        <span id="tb_sqsy_en_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_sqsy_en_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,1,'MALE_HEIGHT','1')"/>����</span>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <span id="tb_sqsy_en_FEMALE_HEIGHT_INCH" style="display: none">
                                                            <BZ:input field="FEMALE_FEET" id="tb_sqsy_en_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'FEMALE_FEET','2')"/>Ӣ��(Feet)
                                                            <BZ:input field="FEMALE_INCH" id="tb_sqsy_en_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:15%" onchange="_chgHeight(this,1,'FEMALE_INCH','2')"/>Ӣ��(Inch)
                                                        </span>
                                                        <span id="tb_sqsy_en_FEMALE_HEIGHT_METRE"><BZ:input field="FEMALE_HEIGHT" id="tb_sqsy_en_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" onchange="_chgHeight(this,1,'FEMALE_HEIGHT','2')"/>����</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_WEIGHT" id="tb_sqsy_en_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number"  onchange="_chgWeight(this,1,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_sqsy_en_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_sqsy_en_MALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_WEIGHT" id="tb_sqsy_en_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onchange="_chgWeight(this,1,'FEMALE_WEIGHT','2')" maxlength="50"/><span id="tb_sqsy_en_FEMALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_sqsy_en_FEMALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����ָ��</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <div id="tb_sqsy_en_MALE_BMI" style="font-size:14px">&nbsp;</div>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <div id="tb_sqsy_en_FEMALE_BMI" style="font-size:14px">&nbsp;</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_MALE_PUNISHMENT_FLAG" id="tb_sqsy_en_MALE_PUNISHMENT_FLAG1" value="1">��
                                                        <BZ:input field="MALE_PUNISHMENT_EN" id="tb_sqsy_en_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_EN')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG" id="tb_sqsy_en_FEMALE_PUNISHMENT_FLAG1" value="1">��
                                                        <BZ:input field="FEMALE_PUNISHMENT_EN" id="tb_sqsy_en_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_PUNISHMENT_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">���޲����Ⱥ�</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                                        <input type="radio" name="tb_sqsy_en_MALE_ILLEGALACT_FLAG" id="tb_sqsy_en_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                                        <BZ:input field="MALE_ILLEGALACT_EN" id="tb_sqsy_en_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_EN')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">��
                                                        <input type="radio" name="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG" id="tb_sqsy_en_FEMALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_FLAG')">��
                                                        <BZ:input field="FEMALE_ILLEGALACT_EN" id="tb_sqsy_en_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'FEMALE_ILLEGALACT_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">�ڽ�����</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_RELIGION_EN" id="tb_sqsy_en_MALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_EN')"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_RELIGION_EN" id="tb_sqsy_en_FEMALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'FEMALE_RELIGION_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">���ҵ�λ</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:select field="CURRENCY" id="tb_sqsy_en_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ" notnull="" width="170px" onchange="_chgValue(this,1,'CURRENCY')"></BZ:select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">������</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_YEAR_INCOME" id="tb_sqsy_en_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'MALE_YEAR_INCOME')" maxlength="22"/>
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_YEAR_INCOME" id="tb_sqsy_en_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,1,'FEMALE_YEAR_INCOME')" maxlength="22"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">ǰ�����</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_MARRY_TIMES" id="tb_sqsy_en_MALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'MALE_MARRY_TIMES')"/>��
                                                    </td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="FEMALE_MARRY_TIMES" id="tb_sqsy_en_FEMALE_MARRY_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'FEMALE_MARRY_TIMES')"/>��
                                                    </td>
                                                </tr> 
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="specialtable">
                                                <tr>
                                                    <td class="edit-data-title" width="15%">����״��</td>
                                                    <td class="edit-data-value" width="18%">�ѻ�</td>
                                                    <td class="edit-data-title" width="15%">�������</td>
                                                    <td class="edit-data-value" width="18%">
                                                        <BZ:input field="MARRY_DATE" id="tb_sqsy_en_MARRY_DATE" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgMarryDate(this,1,'MARRY_DATE')"/>
                                                    </td>
                                                    <td class="edit-data-title" width="15%">����ʱ�����꣩</td>
                                                    <td class="edit-data-value" width="19%">
                                                        <div id="tb_sqsy_en_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ���ʲ�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="TOTAL_ASSET" id="tb_sqsy_en_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,1,'TOTAL_ASSET')"/>
                                                    </td>
                                                    <td class="edit-data-title">��ͥ��ծ��</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input  field="TOTAL_DEBT" id="tb_sqsy_en_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,1,'TOTAL_DEBT')"/>
                                                    </td>
                                                    <td class="edit-data-title">��ͥ���ʲ�</td>
                                                    <td class="edit-data-value">
                                                        <div id="tb_sqsy_en_TOTAL_MANNY"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">18����������Ů����</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="UNDERAGE_NUM" id="tb_sqsy_en_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'UNDERAGE_NUM')"/>��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��Ů���������</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="CHILD_CONDITION_EN" id="tb_sqsy_en_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'CHILD_CONDITION_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥסַ</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="ADDRESS" id="tb_sqsy_en_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,1,'ADDRESS')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title" width="15%">����Ҫ��</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="ADOPT_REQUEST_EN" id="tb_sqsy_en_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ɼҵ���֯����</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="HOMESTUDY_ORG_NAME" id="tb_sqsy_en_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" style="width:80%" onchange="_chgValue(this,1,'HOMESTUDY_ORG_NAME')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ�����������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="FINISH_DATE" id="tb_sqsy_en_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,1,'FINISH_DATE')"/>
                                                    </td>
                                                    <td class="edit-data-title">����������Σ�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="INTERVIEW_TIMES" id="tb_sqsy_en_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,1,'INTERVIEW_TIMES')"/>
                                                    </td>
                                                    <td class="edit-data-title">�Ƽ��ţ��⣩</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="RECOMMENDATION_NUM" id="tb_sqsy_en_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,1,'RECOMMENDATION_NUM')"/></td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">������������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="HEART_REPORT" id="tb_sqsy_en_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT" notnull="" width="70%" onchange="_chgValue(this,1,'HEART_REPORT')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="ADOPT_MOTIVATION" id="tb_sqsy_en_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,1,'ADOPT_MOTIVATION')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CHILDREN_ABOVE" id="tb_sqsy_en_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,1,'CHILDREN_ABOVE')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                </tr>
                                                <tr>                                        
                                                    <td class="edit-data-title">����ָ���໤��</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_IS_FORMULATE" id="tb_sqsy_en_IS_FORMULATE0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_IS_FORMULATE" id="tb_sqsy_en_IS_FORMULATE1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">��������Ű������</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_IS_ABUSE_ABANDON" id="tb_sqsy_en_IS_ABUSE_ABANDON0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_IS_ABUSE_ABANDON" id="tb_sqsy_en_IS_ABUSE_ABANDON1" value="1">��
                                                    </td>                                    
                                                    <td class="edit-data-title">�����ƻ�</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_IS_MEDICALRECOVERY" id="tb_sqsy_en_IS_MEDICALRECOVERY0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_IS_MEDICALRECOVERY" id="tb_sqsy_en_IS_MEDICALRECOVERY1" value="1">��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����ǰ׼��</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_ADOPT_PREPARE" id="tb_sqsy_en_ADOPT_PREPARE0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_ADOPT_PREPARE" id="tb_sqsy_en_ADOPT_PREPARE1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">������ʶ</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_RISK_AWARENESS" id="tb_sqsy_en_RISK_AWARENESS0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_RISK_AWARENESS" id="tb_sqsy_en_RISK_AWARENESS1" value="1">��
                                                    </td>                                    
                                                    <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_IS_SUBMIT_REPORT" id="tb_sqsy_en_IS_SUBMIT_REPORT0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_IS_SUBMIT_REPORT" id="tb_sqsy_en_IS_SUBMIT_REPORT1" value="1">��
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_PARENTING" id="tb_sqsy_en_PARENTING0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_PARENTING" id="tb_sqsy_en_PARENTING1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">�繤���</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="SOCIALWORKER" id="tb_sqsy_en_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,1,'SOCIALWORKER')" >
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                            <BZ:option value="1">֧��</BZ:option>
                                                            <BZ:option value="2">�������</BZ:option>
                                                            <BZ:option value="3">��֧��</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">&nbsp;</td>
                                                    <td class="edit-data-value">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��������������ͬס</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG0" value="0">��
                                                        <input type="radio" name="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_sqsy_en_IS_FAMILY_OTHERS_FLAG1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">����������ͬס˵��</td>
                                                    <td class="edit-data-value" colspan="3">
                                                        <BZ:input field="IS_FAMILY_OTHERS_EN" id="tb_sqsy_en_IS_FAMILY_OTHERS_EN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ��˵������������</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="REMARK_EN" id="tb_sqsy_en_REMARK_EN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_EN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��׼����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="GOVERN_DATE" id="tb_sqsy_en_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,1,'GOVERN_DATE')"/>
                                                    </td>
                                                    <td class="edit-data-title">��Ч����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="VALID_PERIOD_TYPE" id="tb_sqsy_en_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,1,'VALID_PERIOD_TYPE')">
                                                            <BZ:option value="1">��Ч����</BZ:option>
                                                            <BZ:option value="2">����</BZ:option>
                                                        </BZ:select>
                                                        <BZ:input field="VALID_PERIOD" id="tb_sqsy_en_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,1,'VALID_PERIOD')"/>��
                                                    </td>
                                                    <td class="edit-data-title">��׼��ͯ����</td>
                                                    <td class="edit-data-value" width="19%">
                                                        <BZ:input field="APPROVE_CHILD_NUM" id="tb_sqsy_en_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,1,'APPROVE_CHILD_NUM')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">������ͯ����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="AGE_FLOOR" id="tb_sqsy_en_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,1,'AGE_FLOOR')"/>��~
                                                        <BZ:input field="AGE_UPPER" id="tb_sqsy_en_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,1,'AGE_UPPER')"/>��
                                                    </td>
                                                    <td class="edit-data-title">������ͯ�Ա�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CHILDREN_SEX" id="tb_sqsy_en_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,1,'CHILDREN_SEX')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">������ͯ����״��</td>
                                                    <td class="edit-data-value" width="19%">
                                                        <BZ:select field="CHILDREN_HEALTH_EN" id="tb_sqsy_en_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%" onchange="_chgValue(this,1,'CHILDREN_HEALTH_EN')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <!--����������start-->
                                <table id="tb_dqsy_en" class="specialtable" style="display:block">
                                    <tr>	
                                        <td class="edit-data-title" style="text-align:center"><b>�����˻�����Ϣ</b></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <!--��������Ϣ��start-->                            	  
                                            <table class="specialtable">                          	
                                                <tr>
                                                    <td class="edit-data-title" width="15%">��������</td>
                                                    <td class="edit-data-value" width="25%">
                                                        <BZ:input field="MALE_NAME" id="tb_dqsy_en_MALE_NAME" formTitle="" defaultValue="" notnull=""  maxlength="150" onchange="_chgValue(this,0,'MALE_NAME')"/>
                                                    </td>
                                                    <td class="edit-data-title" width="15%">�Ա�</td>
                                                    <td class="edit-data-value" width="25%">
                                                        <BZ:select field="ADOPTER_SEX" id="tb_dqsy_en_ADOPTER_SEX" formTitle="" defaultValue="" notnull="" width="166px" onchange="_chgValue(this,0,'ADOPTER_SEX')">
                                                            <BZ:option value="1">��</BZ:option>
                                                            <BZ:option value="2">Ů</BZ:option>
                                                        </BZ:select>					
                                                    </td>
                                                    <td class="edit-data-value" width="20%" rowspan="6">
                                                        ��Ƭ
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="MALE_BIRTHDAY" id="tb_dqsy_en_MALE_BIRTHDAY" formTitle="" defaultValue="" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="" onchange="_chgBirthday(this,0,'MALE_BIRTHDAY','1')"/>
                                                    </td>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value">
                                                        <div id="tb_dqsy_en_MALE_AGE" style="font-size:14px">
                                                        <script>
                                                        document.write(getAge($("#tb_dqsy_en_MALE_BIRTHDAY").val()));
                                                        </script>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="MALE_NATION" formTitle="����" codeName="GJ" isCode="true" defaultValue="" id="tb_dqsy_en_MALE_NATION" onchange="_chgValue(this,0,'MALE_NATION')" width="166px"></BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">���պ���</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="MALE_PASSPORT_NO" id="tb_dqsy_en_MALE_PASSPORT_NO" type="String" formTitle="�����˻��պ���" defaultValue="" onchange="_chgValue(this,0,'MALE_PASSPORT_NO')" style="width:166px"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">�ܽ����̶�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="MALE_EDUCATION" formTitle="�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue="" id="tb_dqsy_en_MALE_EDUCATION" width="166px" onchange="_chgValue(this,0,'MALE_EDUCATION')"></BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">ְҵ</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="MALE_JOB_CN" type="String" formTitle="������ְҵ" defaultValue=""  id="tb_dqsy_en_MALE_JOB_CN" onchange="_chgValue(this,-1,'MALE_JOB_CN')" style="width:166px"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����״��</td>
                                                    <td class="edit-data-value" colspan="3">
                                                        <BZ:select width="100px" field="MALE_HEALTH" formTitle="�����˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue="" id="tb_dqsy_en_MALE_HEALTH" onchange="_chgValue(this,0,'MALE_HEALTH')"></BZ:select>					
                                                        <textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_CN" id="tb_dqsy_en_MALE_HEALTH_CONTENT_CN">		
                                                        <BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
                                                        </textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">���</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="MEASUREMENT" id="tb_dqsy_en_MEASUREMENT" formTitle=""  defaultValue="" notnull="" onchange="_chgValue(this,0,'MEASUREMENT')">
                                                            <BZ:option value="0">����</BZ:option>
                                                            <BZ:option value="1">Ӣ��</BZ:option>
                                                        </BZ:select>
                                                        <span id="tb_dqsy_en_MALE_HEIGHT_INCH" style="display: none">
                                                            <BZ:input field="MALE_FEET" id="tb_dqsy_en_MALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_FEET','1')"/>Ӣ��(Feet)
                                                            <BZ:input field="MALE_INCH" id="tb_dqsy_en_MALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:10%" onchange="_chgHeight(this,0,'MALE_INCH','1')"/>Ӣ��(Inch)
                                                        </span>
                                                        <span id="tb_dqsy_en_MALE_HEIGHT_METRE"><BZ:input field="MALE_HEIGHT" id="tb_dqsy_en_MALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" size="10" onchange="_chgHeight(this,0,'MALE_HEIGHT','1')"/>����</span>
                                                    </td>
                                                    <td class="edit-data-title">����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="MALE_WEIGHT" id="tb_dqsy_en_MALE_WEIGHT" formTitle="" defaultValue="" notnull="" restriction="number" onblur="_setMaleBMI()" size="10" onchange="_chgWeight(this,0,'MALE_WEIGHT','1')" maxlength="50"/><span id="tb_dqsy_en_MALE_WEIGHT_POUNDS" style="display: none">��</span><span id="tb_dqsy_en_MALE_WEIGHT_KILOGRAM">ǧ��</span>
                                                    </td>
                                                </tr>                                    
                                                <tr>
                                                    <td class="edit-data-title">����ָ��</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <div id="tb_dqsy_en_MALE_BMI" style="font-size:14px">&nbsp;</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                <tr>
                                                    <td class="edit-data-title">Υ����Ϊ�����´���</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_MALE_PUNISHMENT_FLAG" id="tb_dqsy_en_MALE_PUNISHMENT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                                        <input type="radio" name="tb_dqsy_en_MALE_PUNISHMENT_FLAG" id="tb_dqsy_en_MALE_PUNISHMENT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_FLAG')">��
                                                        <BZ:input field="MALE_PUNISHMENT_CN" id="tb_dqsy_en_MALE_PUNISHMENT_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_PUNISHMENT_CN')"/>
                                                    </td>
                                                    <td class="edit-data-title">���޲����Ⱥ�</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <input type="radio" name="tb_dqsy_en_MALE_ILLEGALACT_FLAG" id="tb_dqsy_en_MALE_ILLEGALACT_FLAG0" value="0" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                                        <input type="radio" name="tb_dqsy_en_MALE_ILLEGALACT_FLAG" id="tb_dqsy_en_MALE_ILLEGALACT_FLAG1" value="1" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_FLAG')">��
                                                        <BZ:input field="MALE_ILLEGALACT_CN" id="tb_dqsy_en_MALE_ILLEGALACT_CN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none;width:70%" onchange="_chgValue(this,-1,'MALE_ILLEGALACT_CN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">�ڽ�����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="MALE_RELIGION_CN" id="tb_dqsy_en_MALE_RELIGION_CN" formTitle="" defaultValue="" maxlength="500" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>
                                                    </td>
                                                    <td class="edit-data-title">����״��</td>
                                                    <td class="edit-data-value" colspan="2">
                                                    <BZ:select field="MARRY_CONDITION" id="tb_dqsy_en_MARRY_CONDITION" formTitle=""  defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" notnull="" width="166px" onchange="_chgValue(this,0,'MARRY_CONDITION')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                    </BZ:select>                                       
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">ͬ�ӻ��</td>
                                                    <td class="edit-data-value">
                                                        <BZ:radio field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
                                                        <BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
                                                    </td>
                                                    <td class="edit-data-title">ͬ��ʱ��</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input  field="CONABITA_PARTNERS_TIME" id="tb_dqsy_en_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" onchange="_chgValue(this,-1,'MALE_RELIGION_CN')"/>��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͬ��������</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:radio field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">��</BZ:radio>
                                                        <BZ:radio field="GAY_STATEMENT" value="1" formTitle="" >��</BZ:radio>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">���ҵ�λ</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CURRENCY" id="tb_dqsy_en_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  notnull="" width="166px" onchange="_chgValue(this,0,'CURRENCY')"></BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">������</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input field="MALE_YEAR_INCOME" id="tb_dqsy_en_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="" onchange="_chgValue(this,0,'MALE_YEAR_INCOME')" maxlength="22"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ���ʲ�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="TOTAL_ASSET" id="tb_dqsy_en_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalAsset(this,0,'TOTAL_ASSET')"/>
                                                    </td>
                                                    <td class="edit-data-title">��ͥ��ծ��</td>
                                                    <td class="edit-data-value" colspan="2">
                                                        <BZ:input  field="TOTAL_DEBT" id="tb_dqsy_en_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgTotalDebt(this,0,'TOTAL_DEBT')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ���ʲ�</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <div id="tb_dqsy_en_TOTAL_MANNY"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">18����������Ů����</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:input field="UNDERAGE_NUM" id="tb_dqsy_en_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'UNDERAGE_NUM')"/>��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��Ů���������</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:input field="CHILD_CONDITION_CN" id="tb_dqsy_en_CHILD_CONDITION_CN" formTitle="" defaultValue="" type="textarea" notnull="" maxlength="1000" style="width:80%" onchange="_chgValue(this,0,'CHILD_CONDITION_CN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥסַ</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:input field="ADDRESS" id="tb_dqsy_en_ADDRESS" formTitle="" defaultValue="" notnull="" maxlength="500" style="width:80%" onchange="_chgValue(this,0,'ADDRESS')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����Ҫ��</td>
                                                    <td class="edit-data-value" colspan="4">
                                                        <BZ:input field="ADOPT_REQUEST_CN" id="tb_dqsy_en_ADOPT_REQUEST_CN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'ADOPT_REQUEST_CN')"/>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table class="specialtable">
                                                <tr>
                                                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>��ͥ���鼰��֯�����Ϣ</b></td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ɼҵ���֯����</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="HOMESTUDY_ORG_NAME" id="tb_dqsy_en_HOMESTUDY_ORG_NAME" formTitle="" defaultValue="" maxlength="200" style="width:80%"  onchange="_chgValue(this,0,'HOMESTUDY_ORG_NAME')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title" style="width:15%">��ͥ�����������</td>
                                                    <td class="edit-data-value" style="width:18%">
                                                        <BZ:input field="FINISH_DATE" id="tb_dqsy_en_FINISH_DATE" formTitle="" defaultValue="" type="Date" notnull="" onchange="_chgValue(this,0,'FINISH_DATE')"/>
                                                    </td>
                                                    <td class="edit-data-title" style="width:15%">����������Σ�</td>
                                                    <td class="edit-data-value" style="width:18%">
                                                        <BZ:input field="INTERVIEW_TIMES" id="tb_dqsy_en_INTERVIEW_TIMES" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'INTERVIEW_TIMES')"/>
                                                    </td>                                    
                                                    <td class="edit-data-title" style="width:15%">�Ƽ��ţ��⣩</td>
                                                    <td class="edit-data-value" style="width:19%">
                                                        <BZ:input field="RECOMMENDATION_NUM" id="tb_dqsy_en_RECOMMENDATION_NUM" formTitle="" defaultValue="" restriction="int" notnull="" style="width:60%" onchange="_chgValue(this,0,'RECOMMENDATION_NUM')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">������������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="HEART_REPORT" id="tb_dqsy_en_HEART_REPORT" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_HEART_REPORT"  notnull="" width="70%" onchange="_chgValue(this,0,'HEART_REPORT')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="ADOPT_MOTIVATION" id="tb_dqsy_en_ADOPT_MOTIVATION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION" notnull="" width="70%" onchange="_chgValue(this,0,'ADOPT_MOTIVATION')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                
                                                    <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CHILDREN_ABOVE" id="tb_dqsy_en_CHILDREN_ABOVE" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_ABOVE" notnull="" width="70%" onchange="_chgValue(this,0,'CHILDREN_ABOVE')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����ָ���໤��</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_IS_FORMULATE" id="tb_dqsy_en_IS_FORMULATE0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_IS_FORMULATE" id="tb_dqsy_en_IS_FORMULATE1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">��������Ű������</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_IS_ABUSE_ABANDON" id="tb_dqsy_en_IS_ABUSE_ABANDON0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_IS_ABUSE_ABANDON" id="tb_dqsy_en_IS_ABUSE_ABANDON1" value="1">��
                                                    </td>
                                                
                                                    <td class="edit-data-title">�����ƻ�</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_IS_MEDICALRECOVERY" id="tb_dqsy_en_IS_MEDICALRECOVERY0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_IS_MEDICALRECOVERY" id="tb_dqsy_en_IS_MEDICALRECOVERY1" value="1">��
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">����ǰ׼��</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_ADOPT_PREPARE" id="tb_dqsy_en_ADOPT_PREPARE0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_ADOPT_PREPARE" id="tb_dqsy_en_ADOPT_PREPARE1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">������ʶ</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_RISK_AWARENESS" id="tb_dqsy_en_RISK_AWARENESS0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_RISK_AWARENESS" id="tb_dqsy_en_RISK_AWARENESS1" value="1">��
                                                    </td>
                                               
                                                    <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_IS_SUBMIT_REPORT" id="tb_dqsy_en_IS_SUBMIT_REPORT0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_IS_SUBMIT_REPORT" id="tb_dqsy_en_IS_SUBMIT_REPORT1" value="1">��
                                                    </td>
                                                </tr>                                    
                                                <tr>
                                                    <td class="edit-data-title">��������</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_PARENTING" id="tb_dqsy_en_PARENTING0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_PARENTING" id="tb_dqsy_en_PARENTING1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">�繤���</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="SOCIALWORKER" id="tb_dqsy_en_SOCIALWORKER" formTitle="" defaultValue="" notnull=""  width="70%" onchange="_chgValue(this,0,'SOCIALWORKER')" >
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                            <BZ:option value="1">֧��</BZ:option>
                                                            <BZ:option value="2">�������</BZ:option>
                                                            <BZ:option value="3">��֧��</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">&nbsp;</td>
                                                    <td class="edit-data-value">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��������������ͬס</td>
                                                    <td class="edit-data-value">
                                                        <input type="radio" name="tb_dqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_en_IS_FAMILY_OTHERS_FLAG0" value="0">��
                                                        <input type="radio" name="tb_dqsy_en_IS_FAMILY_OTHERS_FLAG" id="tb_dqsy_en_IS_FAMILY_OTHERS_FLAG1" value="1">��
                                                    </td>
                                                    <td class="edit-data-title">����������ͬס˵��</td>
                                                    <td class="edit-data-value" colspan="3">
                                                        <BZ:input field="IS_FAMILY_OTHERS_CN" id="tb_dqsy_en_IS_FAMILY_OTHERS_CN" type="textarea" formTitle="" defaultValue="" maxlength="500" style="width:70%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��ͥ��˵������������</td>
                                                    <td class="edit-data-value" colspan="5">
                                                        <BZ:input field="REMARK_CN" id="tb_dqsy_en_REMARK_CN" type="textarea" formTitle="" defaultValue="" maxlength="1000" style="width:80%" onchange="_chgValue(this,-1,'IS_FAMILY_OTHERS_CN')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title" colspan="6" style="text-align:center"><b>������׼��Ϣ</b></td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">��׼����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="GOVERN_DATE" id="tb_dqsy_en_GOVERN_DATE" type="Date" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'GOVERN_DATE')"/>
                                                    </td>
                                                    <td class="edit-data-title">��Ч����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="VALID_PERIOD_TYPE" id="tb_dqsy_en_VALID_PERIOD_TYPE" formTitle="" defaultValue="" notnull="" onchange="_chgValue(this,0,'VALID_PERIOD_TYPE')">
                                                            <BZ:option value="1">��Ч����</BZ:option>
                                                            <BZ:option value="2">����</BZ:option>
                                                        </BZ:select>
                                                        <BZ:input field="VALID_PERIOD" id="tb_dqsy_en_VALID_PERIOD" formTitle="" defaultValue="" restriction="int" notnull="" style="width:20%" onchange="_chgValue(this,0,'VALID_PERIOD')"/>��
                                                    </td>
                                                    <td class="edit-data-title">��׼��ͯ����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="APPROVE_CHILD_NUM" id="tb_dqsy_en_APPROVE_CHILD_NUM" formTitle="" defaultValue="" restriction="int" notnull="" onchange="_chgValue(this,0,'APPROVE_CHILD_NUM')"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="edit-data-title">������ͯ����</td>
                                                    <td class="edit-data-value">
                                                        <BZ:input field="AGE_FLOOR" id="tb_dqsy_en_AGE_FLOOR" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_FLOOR')"/>��~
                                                        <BZ:input field="AGE_UPPER" id="tb_dqsy_en_AGE_UPPER" formTitle="" defaultValue="" restriction="int" maxlength="22" style="width:30%" onchange="_chgValue(this,0,'AGE_UPPER')"/>��
                                                    </td>
                                                    <td class="edit-data-title">������ͯ�Ա�</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CHILDREN_SEX" id="tb_dqsy_en_CHILDREN_SEX" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_SEX" width="70%" onchange="_chgValue(this,0,'CHILDREN_SEX')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                    <td class="edit-data-title">������ͯ����״��</td>
                                                    <td class="edit-data-value">
                                                        <BZ:select field="CHILDREN_HEALTH_EN" id="tb_dqsy_en_CHILDREN_HEALTH_EN" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH" width="70%"  onchange="_chgValue(this,0,'CHILDREN_HEALTH_EN')">
                                                            <BZ:option value="">--��ѡ��--</BZ:option>
                                                        </BZ:select>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                                <!--����������end-->
                                <!--����Ů������start-->
                                <table id="tb_jzn_en" class="specialtable" style="display:block">
                                    <tr><td>����Ů������������2����������</td></tr>
                                </table>
                                <!--����Ů������end-->
                            </td>
                        </tr>
					</table>     	
                </div>
                <!--��ͥ�������(��)��end-->
                                
			</div>
		</div>
	</BZ:form>
	</BZ:body>
</BZ:html>
