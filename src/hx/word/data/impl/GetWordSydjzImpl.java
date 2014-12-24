/**
 * 
 */
package hx.word.data.impl;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.word.data.BaseData;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.ncm.MatchAction;

/**
 * @author wang
 *
 */
public class GetWordSydjzImpl  extends BaseData{

	@Override  
	public Map<String, Object> getData(Connection conn, String id) throws DBException {
		  Map<String,Object> dataMap=new HashMap<String,Object>();
		  //��ȡ�����Ǽ�֤������
		  Data d = setData(conn, id);
		  
		  //�����ݸ�ֵ��ģ����		  
		  String ADREG_NO = d.getString("ADREG_NO","");
		  if(!"".equals(ADREG_NO) && ADREG_NO.length()==12){
			  dataMap.put("NO1",ADREG_NO.substring(0, 2));					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO2",ADREG_NO.substring(2, 4));					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO3",ADREG_NO.substring(4, 8));					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO4",ADREG_NO.substring(8, 12));					//�����Ǽ�_�Ǽ�֤��
		  }else{
			  dataMap.put("NO1","X1X2");					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO2","X3X4");					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO3","X5X6X7X8");					//�����Ǽ�_�Ǽ�֤��
			  dataMap.put("NO4","X9X10X11X12");					//�����Ǽ�_�Ǽ�֤��
		  }
		  dataMap.put("NAME",d.getString("NAME",""));					//��ͯ����
		  dataMap.put("CHILD_NAME_EN",d.getString("CHILD_NAME_EN",""));					//��ͯ�뼮����
		  dataMap.put("SENDER", d.getString("SENDER",""));	//����������
	     dataMap.put("SENDER_ADDR", d.getString("SENDER_ADDR",""));	//������/����������ַ
	     dataMap.put("SEX", d.getString("SEX_NAME",""));	//���������Ա�
	     dataMap.put("BIRTHDAY", d.getDate("BIRTHDAY"));	//�������˳�������
	     dataMap.put("CHILD_IDENTITY_NAME", d.getString("CHILD_IDENTITY_NAME",""));	//��ͯ���
	     dataMap.put("ID_CARD", d.getString("ID_CARD",""));	//��ͯ���֤����
	     
	      dataMap.put("MALE_NAME", d.getString("MALE_NAME",""));	//����������_�з�
	      dataMap.put("FEMALE_NAME", d.getString("FEMALE_NAME",""));	//����������_Ů��
	      dataMap.put("MALE_BIRTHDAY", d.getDate("MALE_BIRTHDAY"));	//�����˳�������_�з�
	      dataMap.put("FEMALE_BIRTHDAY", d.getDate("FEMALE_BIRTHDAY"));	//�����˳�������_Ů��
	      dataMap.put("MALE_PASSPORT_NO", d.getString("MALE_PASSPORT_NO",""));	//�����˻��պ���_�з�
	      dataMap.put("FEMALE_PASSPORT_NO", d.getString("FEMALE_PASSPORT_NO",""));	//�����˻��պ���_Ů��
	      dataMap.put("MALE_NATION", d.getString("MALE_NATION_NAME",""));	//�����˹���_�з�
	      dataMap.put("FEMALE_NATION", d.getString("FEMALE_NATION_NAME",""));	//�����˹���_Ů��	      
	     dataMap.put("ADDRESS", d.getString("ADDRESS",""));	//������_��ͥסַ
	    
	   return dataMap;
	}
	
	private Data setData(Connection conn, String id) throws DBException{
		Data ret = new Data();
		//��ȡ��������������
		MatchAction matchAction = new MatchAction();
		
		ret =  matchAction.getNcmMatchInfoForAdregCard(conn, id);
		
		return ret;
	}
	
	

}
