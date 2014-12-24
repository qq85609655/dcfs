/**
 * 
 */
package hx.word.data.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.ncm.MatchAction;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.word.data.BaseData;

/**
 * @author wang
 *
 */
public class GetWordSydjsqsImpl  extends BaseData{
    
	public Map<String, Object> getData(Connection conn, String id) throws DBException {
		  Map<String,Object> dataMap=new HashMap<String,Object>();
		  //��ȡ�����Ǽ������������
		  Data d = setData(conn, id);
		  
		  //�����ݸ�ֵ��ģ����		  
	      dataMap.put("ci_name", d.getString("NAME",""));					//��ͯ����
	      String FAMILY_TYPE = d.getString("FAMILY_TYPE");	//��������
	      String ADOPTER_SEX = d.getString("ADOPTER_SEX"); //�������Ա�
	      dataMap.put("MALE_NAME", d.getString("MALE_NAME",""));	//����������_�з�
	      dataMap.put("FEMALE_NAME", d.getString("FEMALE_NAME",""));	//����������_Ů��
	      dataMap.put("MALE_BIRTHDAY", d.getDate("MALE_BIRTHDAY"));	//�����˳�������_�з�
	      dataMap.put("FEMALE_BIRTHDAY", d.getDate("FEMALE_BIRTHDAY"));	//�����˳�������_Ů��
	      dataMap.put("MALE_PASSPORT_NO", d.getString("MALE_PASSPORT_NO",""));	//�����˻��պ���_�з�
	      dataMap.put("FEMALE_PASSPORT_NO", d.getString("FEMALE_PASSPORT_NO",""));	//�����˻��պ���_Ů��
	      dataMap.put("MALE_NATION", d.getString("MALE_NATION_NAME",""));	//�����˹���_�з�
	      dataMap.put("FEMALE_NATION", d.getString("FEMALE_NATION_NAME",""));	//�����˹���_Ů��
	      dataMap.put("MALE_JOB_CN", d.getString("MALE_JOB_CN",""));	//������ְҵ_�з�
	      dataMap.put("FEMALE_JOB_CN", d.getString("FEMALE_JOB_CN",""));	//������ְҵ_Ů��
	      dataMap.put("MALE_EDUCATION", d.getString("MALE_EDUCATION_NAME",""));	//�������Ļ��̶�_�з�
	      dataMap.put("FEMALE_EDUCATION", d.getString("FEMALE_EDUCATION_NAME",""));	//�������Ļ��̶�_Ů��
	      dataMap.put("MALE_HEALTH", d.getString("MALE_HEALTH_NAME",""));	//�����˽���״��_�з�
	      dataMap.put("FEMALE_HEALTH", d.getString("FEMALE_HEALTH_NAME",""));	//�����˽���״��_Ů��
	      if("1".endsWith(FAMILY_TYPE)){//˫������
	    	  dataMap.put("MALE_MARRY_CONDITION", "�ѻ�");	//������_����״��
	    	  dataMap.put("FEMALE_MARRY_CONDITION", "�ѻ�");	//������_����״��
	      }else{
	    	  if("1".equals(ADOPTER_SEX)){//�������Ա�Ϊ��
	    		  dataMap.put("MALE_MARRY_CONDITION", d.getString("MARRY_CONDITION_NAME"));	//������_����״��
	    		  dataMap.put("FEMALE_MARRY_CONDITION", "");	//������_����״��
	    	  }else{
	    		  dataMap.put("FEMALE_MARRY_CONDITION", d.getString("MARRY_CONDITION_NAME"));	//������_����״��
	    		  dataMap.put("MALE_MARRY_CONDITION", "");	//������_����״��
	    	  }	    	  
	      }
	      dataMap.put("CHILD_CONDITION_CN", d.getString("CHILD_CONDITION_CN",""));	//������_��Ů���
	      dataMap.put("TOTAL_ASSET", d.getInt("TOTAL_ASSET"));	//������_���ʲ�
	      dataMap.put("TOTAL_DEBT", d.getInt("TOTAL_DEBT"));	//������_��ծ��
	      Integer  TOTAL_RESULT = d.getInt("TOTAL_ASSET") - d.getInt("TOTAL_DEBT");
	     dataMap.put("TOTAL_RESULT", TOTAL_RESULT.toString());	//������_���ʲ�
	     dataMap.put("ADDRESS", d.getString("ADDRESS",""));	//������_��ͥסַ
	     dataMap.put("NAME_CN", d.getString("NAME_CN",""));	//�� ϵ �� �� ��  �� �� �� ֯ �� ��
	     dataMap.put("SENDER", d.getString("SENDER",""));	//����������
	     dataMap.put("SENDER_ADDR", d.getString("SENDER_ADDR",""));	//������/����������ַ
	     dataMap.put("SEX", d.getString("SEX_NAME",""));	//���������� ��
	     dataMap.put("BIRTHDAY", d.getDate("BIRTHDAY"));	//�������˳�������
	     if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(d.getString("CHILD_TYPE"))){//������ͯ
	    	 dataMap.put("SN_TYPE", "����");	 //�� �� ״ ��
	     }else{
	    	 dataMap.put("SN_TYPE", d.getString("SN_TYPE_NAME",""));	 //�� �� ״ ��
	     }
	    dataMap.put("CHILD_IDENTITY", d.getString("CHILD_IDENTITY",""));	//��ͯ���
	    //System.out.println( d.getString	("CHILD_IDENTITY",""));
	    //Map<String, CodeList> codes = UtilCode.getCodeLists("ETSFLX"); 
	    //CodeList codeList = UtilCode.getCodeLists("ETSFLX").get("ETSFLX");
	    	
	     dataMap.put("CONTACT_NAME", d.getString("CONTACT_NAME",""));	//����������
	     dataMap.put("CONTACT_JOB", d.getString("CONTACT_JOB",""));	//������ְ��
	     dataMap.put("CONTACT_CARD", d.getString("CONTACT_CARD",""));	//������     ���֤����
	     dataMap.put("CONTACT_TEL", d.getString("CONTACT_TEL",""));	 //��������ϵ  ��   ��
	   return dataMap;
	}
	
	private Data setData(Connection conn, String id) throws DBException{
		Data ret = new Data();
		//��ȡ��������������
		MatchAction matchAction = new MatchAction();
		ret =  matchAction.getNcmMatchInfoForAdreg(conn, id);		
		return ret;
	}

}
