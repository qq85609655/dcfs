package com.dcfs.cms.childReturn;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class ChildReturnHandler extends BaseHandler{
	 public DataList returnListFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//�������ڿ�ʼ
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//�������ڽ���
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//�˲�������
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//�˲���״̬
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//�˲��Ϸ���/��������
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//״̬/�˲��Ͻ�� nullʱδȷ�� 1ʱ��ȷ��
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//�˲���ԭ��
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListFLY",oId,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 public DataList returnListST(Connection conn, String oCode, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
		    //��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String WELFARE_ID = data.getString("WELFARE_ID",null);//����Ժcode
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//�������ڿ�ʼ
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//�������ڽ���
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//�˲�������
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//�˲���״̬
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//�˲��Ϸ���/��������
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//״̬/�˲��Ͻ�� nullʱδȷ�� 1ʱ��ȷ��
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//�˲���ԭ��
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListST",oCode,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 public DataList returnListZX(Connection conn, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
		    //��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String PROVINCE_ID = data.getString("PROVINCE_ID",null);//ʡ��
			String WELFARE_ID = data.getString("WELFARE_ID",null);//����Ժ
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//�������ڿ�ʼ
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//�������ڽ���
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//�˲�������
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//�˲���״̬
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//�˲��Ϸ���/��������
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//״̬/�˲��Ͻ�� nullʱδȷ�� 1ʱ��ȷ��
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//�˲���ԭ��
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String AUD_STATE = data.getString("AUD_STATE", null);	//��ͯ״̬
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectST(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժcode
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String AUD_STATE = data.getString("AUD_STATE", null);	//��ͯ״̬
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectST",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectZX(Connection conn,Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String AUD_STATE = data.getString("AUD_STATE", null);	//��ͯ״̬
			//��ѯ����
			
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 //���ݶ�ͯ����������ȡ��ͯ���ϻ�����Ϣ
	 public Data getChildInfoById(Connection conn, String ci_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getChildInfoById", ci_id));
	        return dataList.getData(0);
	         
	    }
	 //���ݶ�ͯ�����˲���������ȡ�˲�����Ϣ����ͯ��Ϣ
	 public Data getConfirmDataByID(Connection conn, String AR_ID) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getConfirmDataByID", AR_ID));
	        return dataList.getData(0);
	    }
	 
	 public boolean save(Connection conn, Data data) throws DBException {
    	 String CI_ID=data.getString("CI_ID",null);
    	 if(CI_ID==null){
    		 return false;
    	 }
    	 data.setConnection(conn);
    	 data.setEntityName("RFM_CI_REVOCATION");
    	 data.setPrimaryKey("AR_ID");
    	 String id=data.getString("AR_ID", null);
    	 if(id==null){
    		 data.create();
    	 }else{
    	     data.store();
    	 }
	    return true;
     }
	//��ȡ���䳬��17��Ķ�ͯ����
	//��ѯ����Ϊ����ͯ�������ύ;���״̬��Ϊʡ��ͨ�������Ĳ�ͨ��;�˲���״̬Ϊ��;��ͯƥ��״̬��Ϊ1����ƥ�䣩;��ͯ����״̬��Ϊ4(������);��ͯ����״̬��Ϊ3��������
	 public DataList findChildAgeOutSeventeen(Connection conn, String time) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("findChildAgeOutSeventeen", time));
	        return dataList;
	    }
}
