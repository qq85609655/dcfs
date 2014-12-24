 /**
 * @Title: TransferInfoAction.java
 * @Package com.dcfs.ffs.transferManager
 * @Description: 
 * @author xxx   
 * @project DCFS 
 * @date 2014-7-29 10:44:21
 * @version V1.0   
 */
package com.dcfs.ffs.transferManager;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import java.sql.Connection;
import java.util.Map;

import com.dcfs.common.transfercode.TransferCode;
import com.hx.upload.utils.UtilDateTime;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

/**
 * @Title: TransferInfoHandler.java
 * @Description:????
 * @Created on 
 * @author xxx
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class TransferManagerHandler extends BaseHandler{
	
	private IDataExecute ide = null;
	  /**
     * ���潻�ӵ�����,���ش������ӵ�����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public String TransferListSave(Connection conn, Map<String, Object> data) throws DBException {
        
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("TRANSFER_INFO");
        dataadd.setPrimaryKey("TI_ID");
        if("".equals(dataadd.getString("TI_ID", ""))){
            return dataadd.create().getString("TI_ID");
        }else{
            return dataadd.store().getString("TI_ID");
        }
    }
    /**
     * ����\�ύ ���� ��TRANSFER_STATEȷ�����������Ǳ�����ύ
     * @param conn
     * @param datalist
     * @param TI_ID
     * @param TRANSFER_STATE
     * @return
     * @throws DBException
     */
    public Data TransferDetailSave(Connection conn, Data data) throws DBException {
        
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("TRANSFER_INFO_DETAIL");
        dataadd.setPrimaryKey("TID_ID");
        if("".equals(dataadd.getString("TID_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * �������½��ӵ�����
     * @param conn
     * @param datalist
     * @return
     * @throws DBException
     */
    public boolean TransferBatchSubmit(Connection conn, DataList datalist,String AT_STATE)
    		throws DBException {
    	ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<datalist.size();i++){
    		datalist.getData(i).setEntityName("TRANSFER_INFO");
    		datalist.getData(i).setPrimaryKey("TI_ID");
    		datalist.getData(i).add("AT_STATE", AT_STATE);
    	}
    	int re =ide.batchStore(datalist);
    	if(re>0){
    	return true;
    	}else{
    		return false;
    	}
    }
    /**
     * ɾ������״̬�����ƽ����Ľ��ӵ�
     * @param conn
     * @param datalist
     * @param AT_STATE
     * @return
     * @throws DBException
     */
    public boolean TransferBatchDelete(Connection conn, DataList datalist,String AT_STATE)
    		throws DBException {
    	ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<datalist.size();i++){
    		datalist.getData(i).setEntityName("TRANSFER_INFO");
    		datalist.getData(i).setPrimaryKey("TI_ID");
    		datalist.getData(i).add("AT_STATE", AT_STATE);
    	}
    	int re =ide.remove(datalist);
    	if(re>0){
    	return true;
    	}else{
    		return false;
    	}
    }
    /**
     * ɾ�����ӵ�����½�����ϸ������
     * @param conn
     * @param TI_ID
     * @param TRANSFER_CODE
     * @return
     * @throws DBException
     */
    public boolean UpdateTransfer_Delete(Connection conn, String TI_ID ,String TRANSFER_CODE)
    		throws DBException {
    	ide = DataBaseFactory.getDataBase(conn);
    	StringBuffer sql=new StringBuffer();
    	sql.append("UPDATE TRANSFER_INFO_DETAIL SET TRANSFER_STATE='0'��TI_ID = '' WHERE ");
    	sql.append(" TI_ID = '"+TI_ID+"' ");
    	sql.append("AND TRANSFER_CODE='"+TRANSFER_CODE+"' ");
    	sql.append("AND TRANSFER_STATE = '1' ");
    	return ide.execute(sql.toString());
    }
    /**
     * �������½�����ϸ��
     * @param conn
     * @param datalist
     * @param TRANSFER_STATE
     * @return
     * @throws DBException
     */
    public boolean UpdateTransfer(Connection conn, String TI_ID)
    		throws DBException {
    	ide = DataBaseFactory.getDataBase(conn);
    	StringBuffer sql=new StringBuffer();
    	sql.append("UPDATE TRANSFER_INFO_DETAIL SET TRANSFER_STATE='2' WHERE ");
    	sql.append(" TI_ID = '"+TI_ID+"' ");
    	//sql.append("AND TRANSFER_CODE='"+TRANSFER_CODE+"' ");
    	sql.append("AND TRANSFER_STATE = '1' ");
    	System.out.println(sql);
     	return ide.execute(sql.toString());
    }
    /**
     * ��ѯ���ӵ���
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList TransferList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
		//��ѯ����
		String CONNECT_NO = data.getString("CONNECT_NO", null);//���ӵ����
		String COPIES = data.getString("COPIES", null);//����
		String TRANSFER_USERNAME = data.getString("TRANSFER_USERNAME", null);//�ƽ���
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//�ƽ����ڿ�ʼ
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//�ƽ����ڽ�ֹ
		String RECEIVER_USERNAME = data.getString("RECEIVER_USERNAME", null);//������
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//����ʱ�俪ʼ
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//����ʱ���ֹ
		String AT_STATE = data.getString("AT_STATE", null);//�ƽ�״̬
		String OPER_TYPE =data.getString("OPER_TYPE",null);    //��������
		String TRANSFER_CODE =data.getString("TRANSFER_CODE",null);    //ҵ�񻷽ڣ����Ӵ��룩
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferList",CONNECT_NO,COPIES,TRANSFER_USERNAME,TRANSFER_DATE_START,TRANSFER_DATE_END,RECEIVER_USERNAME,RECEIVER_DATE_START,RECEIVER_DATE_END,AT_STATE,compositor,ordertype,TRANSFER_CODE,OPER_TYPE);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);

        	
        return dl;
    }

    /**
     * �鿴
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getShowData", uuid));
        return dataList.getData(0);
    }

    /**
     * ɾ��
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public boolean delete(Connection conn, String[] uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        for (int i = 0; i < uuid.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("TRANSFER_INFO");
            data.setPrimaryKey("TI_ID");
            data.add("TI_ID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
    /**
     * ��ʼ��������ϸ��TRANSFER_INFO_DETAIL������ 
     * Data ��װ����  ���£�
     * 1��APP_ID ҵ��ʵ���uuid 
     * 2��TRANSFER_CODE �������ʹ��� �������ݲμ� com.dcfs.common.transfercode.transfercode.java
     * 3��TRANSFER_STATE �ƽ�״̬ ����Ϊ��0��
     * @param conn
     * @param dl
     * @return
     */
    public boolean TransferDetailInit(Connection conn, DataList dl) throws DBException {
    	 //***��������*****
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        for(int i=0;i<dl.size();i++){
        	      	
        	dl.getData(i).setEntityName("TRANSFER_INFO");
        	dl.getData(i).setPrimaryKey("TID_ID");
        	
        }
        ide.batchCreate(dl);
        
        return true;
    }
    /**
     * ��ѯ�ֹ�����ļ����� ���б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList TransferMannualFileList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException{
    	
		//��ѯ����
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//����Code
    	String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//������֯Code
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//����������ʼ
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//�������ڽ�ֹ
		String FILE_NO = data.getString("FILE_NO", null);//�ļ����
		String FILE_TYPE = data.getString("FILE_TYPE", null);//�ļ�����
		String MALE_NAME = data.getString("MALE_NAME", null);//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//Ů����������
		String TRANSFER_CODE = data.getString("TRANSFER_CODE", null);//ҵ�񻷽�
		String HANDLE_TYPE = data.getString("HANDLE_TYPE",null); //���Ĵ���ʽ
		String RETURN_STATE = null;
		String sql="";
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//���ҵ������ԡ�5����ʼ����������ҵ�������ÿɲ�ѯ�����ļ�¼״̬Ϊ��1����ȷ�ϡ�
		if(TRANSFER_CODE!=null&&"5".equals(TRANSFER_CODE.substring(0,1))){
			RETURN_STATE = "1";  
	        sql = getSql("TransferMannualFileListForTW",COUNTRY_CODE,ADOPT_ORG_ID,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,FILE_TYPE,MALE_NAME,FEMALE_NAME,compositor,ordertype,TRANSFER_CODE,HANDLE_TYPE,RETURN_STATE);
		}else{
			sql = getSql("TransferMannualFileList",COUNTRY_CODE,ADOPT_ORG_ID,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,FILE_TYPE,MALE_NAME,FEMALE_NAME,compositor,ordertype,TRANSFER_CODE,HANDLE_TYPE,RETURN_STATE);
		}

        DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    	
    }

    /**
     * ��ȡָ�����ӵ�ID�Ľ�����ϸ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailList(Connection conn, String TI_ID,String transfer_code)
    		throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	
        //String sql = getSql("TransferEditList",TI_ID);
        StringBuffer sql =new StringBuffer();
        //ƴдsql��� ���ղ�ͬ��ҵ�����̲��������ӱ�������
        //��transfer_codeΪ��13��ʱ��Ҫ���Ӷ�ͯ���ϱ� ��ѯ�����ͯ����
        //��transfer_codeΪ��5*������Ҫ����������Ϣ���ѯ����ԭ���봦�÷�ʽ
        sql.append("SELECT TID_ID,COUNTRY_CN,NAME_CN,FAI.REGISTER_DATE AS REGISTER_DATE,FAI.FILE_NO AS FILE_NO,FAI.FILE_TYPE AS FILE_TYPE,FAI.MALE_NAME AS MALE_NAME,FAI.FEMALE_NAME AS FEMALE_NAME");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
        	//��ҵ�����Ϊ13�²�ѯ�����ͯ����
        	sql.append(",CI.NAME AS NAME ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
        	//��ҵ�����Ϊ5*ʱ��ѯ����ԭ��
        	sql.append(",RA.RETURN_REASON AS RETURN_REASON,RA.HANDLE_TYPE AS HANDLE_TYPE,RA.APPLE_TYPE as APPLE_TYPE,RA.RETREAT_DATE as RETREAT_DATE");
        }
        sql.append(" FROM TRANSFER_INFO_DETAIL TID LEFT JOIN FFS_AF_INFO FAI ON TID.APP_ID = FAI.AF_ID ");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
        	//��ҵ�����Ϊ13ʱ���Ӷ�ͯ������Ϣ��
        	sql.append(" LEFT JOIN CMS_CI_INFO CI ON FAI.CI_ID = CI.CI_ID ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
        	//��ҵ�����Ϊ5*ʱ�������ı�
        	sql.append(" LEFT JOIN RFM_AF_REVOCATION RA ON TID.APP_ID = RA.AF_ID ");
        }
        sql.append("WHERE  TI_ID='"+TI_ID+"' ");
        
        DataList dl = ide.find(sql.toString());
    	return dl;
    }
    /**
     * 
     * @Title: TransferEditDetailListOfUuid
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����12:01:15
     * @param conn
     * @param TID_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailListOfUuid(Connection conn, String TID_ID,String transfer_code)
            throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        //String sql = getSql("TransferEditList",TI_ID);
        StringBuffer sql =new StringBuffer();
        //ƴдsql��� ���ղ�ͬ��ҵ�����̲��������ӱ�������
        //��transfer_codeΪ��13��ʱ��Ҫ���Ӷ�ͯ���ϱ� ��ѯ�����ͯ����
        //��transfer_codeΪ��5*������Ҫ����������Ϣ���ѯ����ԭ���봦�÷�ʽ
        sql.append("SELECT TID_ID,COUNTRY_CN,NAME_CN,FAI.REGISTER_DATE AS REGISTER_DATE,FAI.FILE_NO AS FILE_NO,FAI.FILE_TYPE AS FILE_TYPE,FAI.MALE_NAME AS MALE_NAME,FAI.FEMALE_NAME AS FEMALE_NAME");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
            //��ҵ�����Ϊ13�²�ѯ�����ͯ����
            sql.append(",CI.NAME AS NAME ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
            //��ҵ�����Ϊ5*ʱ��ѯ����ԭ��
            sql.append(",RA.RETURN_REASON AS RETURN_REASON,RA.HANDLE_TYPE AS HANDLE_TYPE,RA.APPLE_TYPE as APPLE_TYPE ");
        }
        sql.append(" FROM TRANSFER_INFO_DETAIL TID LEFT JOIN FFS_AF_INFO FAI ON TID.APP_ID = FAI.AF_ID ");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
            //��ҵ�����Ϊ13ʱ���Ӷ�ͯ������Ϣ��
            sql.append(" LEFT JOIN CMS_CI_INFO CI ON FAI.CI_ID = CI.CI_ID ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
            //��ҵ�����Ϊ5*ʱ�������ı�
            sql.append(" LEFT JOIN RFM_AF_REVOCATION RA ON TID.APP_ID = RA.AF_ID ");
        }
        sql.append("WHERE  TID_ID='"+TID_ID+"' ");
        
        DataList dl = ide.find(sql.toString());
        return dl;
    }
    /**
     * ��ȡָ�����ӵ�ID�Ĳ��Ͻ�����ϸ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChildinfoList(Connection conn, String TI_ID)
    		throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT TID_ID,CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,SPECIAL_FOCUS ");
		sql.append("FROM TRANSFER_INFO_DETAIL TD LEFT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID  ");
		sql.append("WHERE  TI_ID ='"+TI_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
    	return dl;
    }
    /**
     * 
     * @Title: TransferEditDetailChildinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����11:55:58
     * @param conn
     * @param TID_ID
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChildinfoListOfUuid(Connection conn, String TID_ID)
            throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT TID_ID,CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,SPECIAL_FOCUS ");
        sql.append("FROM TRANSFER_INFO_DETAIL TD LEFT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID  ");
        sql.append("WHERE  TID_ID ='"+TID_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
        return dl;
    }
    
    /**
     * ���ò����������Ĳ�����Ҫȡ��ƥ����Ϣ
     * @Title: TransferEditDetailChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����4:54:53
     * @param conn
     * @param TI_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChildMatchinfoList(Connection conn, String TI_ID) throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailChildMatchinfoList", TI_ID);
        System.out.println(sql);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: TransferEditDetailChildMatchinfoListOfUuid
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����11:57:25
     * @param conn
     * @param TID_ID
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChildMatchinfoListOfUuid(Connection conn, String TID_ID) throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailChildMatchinfoListOfUuid", TID_ID);
        System.out.println(sql);
        DataList dl = ide.find(sql);
        return dl;
    }
    
    /**
     * ��ȡָ�����ӵ�ID��Ʊ�ݽ�����ϸ�б�
     * @Title: TransferEditDetailChequeinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-24����11:25:06
     * @param conn
     * @param TI_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChequeinfoList(Connection conn, String TI_ID,String transfer_code)
            throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailChequeinfoList", TI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * ��ȡָ�����ӵ�ID�İ��ú󱨸潻����ϸ�б�
     * @Title: TransferEditDetailArchiveinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18����11:29:52
     * @param conn
     * @param TI_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailArchiveinfoList(Connection conn, String TI_ID,String transfer_code)
            throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailArchiveinfoList", TI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    
    /**
     * ��ȡָ�����ӵ�ID��Ʊ�ݽ�����ϸ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChequeList(Connection conn, String TI_ID)
    		throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
		sql.append("SELECT T.TID_ID AS TID_ID, PAID_NO,COUNTRY_CODE,NAME_CN,PAID_WAY,BILL_NO,PAR_VALUE FROM TRANSFER_INFO_DETAIL T  JOIN FAM_CHEQUE_INFO F ON T.APP_ID =F.CHEQUE_ID ");
		sql.append("WHERE 1=1 AND TI_ID ='"+TI_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
    	return dl;
    }
    
    /**
     * 
     * @Title: TransferEditDetailChequeListOfUuid
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����11:15:01
     * @param conn
     * @param TID_ID
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChequeListOfUuid(Connection conn, String TID_ID)
            throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT T.TID_ID AS TID_ID, PAID_NO,COUNTRY_CODE,NAME_CN,PAID_WAY,BILL_NO,PAR_VALUE FROM TRANSFER_INFO_DETAIL T  JOIN FAM_CHEQUE_INFO F ON T.APP_ID =F.CHEQUE_ID ");
        sql.append("WHERE 1=1 AND TID_ID ='"+TID_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
        return dl;
    }
    /**
     * ��ȡָ�����ӵ�ID�İ��ú󱨸潻����ϸ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    
    public DataList TransferEditDetailArchiveList(Connection conn, String TI_ID)
    		throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT TID_ID,NI.COUNTRY_CODE AS COUNTRY_CODE,NI.NAME_CN AS NAME_CN,NI.ARCHIVE_NO AS ARCHIVE_NO ,MALE_NAME,FEMALE_NAME,NAME,SIGN_DATE,REPORT_DATE,NUM ");
		sql.append("FROM TRANSFER_INFO_DETAIL TD JOIN PFR_FEEDBACK_RECORD PR ON TD.APP_ID = PR.FB_REC_ID ");
		sql.append(" JOIN  PFR_FEEDBACK_INFO PI ON PR.FEEDBACK_ID=PI.FEEDBACK_ID ");
		sql.append(" JOIN  NCM_ARCHIVE_INFO NI ON PI.ARCHIVE_ID = NI.ARCHIVE_ID ");
		sql.append("WHERE 1=1 AND TI_ID ='"+TI_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
    	return dl;
    }
    /**
     * 
     * @Title: TransferEditDetailArchiveListOfUuid
     * @Description: ��ȡָ��������ϸID�İ��ú󱨸潻����ϸ�б�
     * @author: xugy
     * @date: 2014-12-8����5:09:49
     * @param conn
     * @param TI_ID
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailArchiveListOfUuid(Connection conn, String TID_ID)
            throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT TID_ID,NI.COUNTRY_CODE AS COUNTRY_CODE,NI.NAME_CN AS NAME_CN,NI.ARCHIVE_NO AS ARCHIVE_NO ,MALE_NAME,FEMALE_NAME,NAME,SIGN_DATE,REPORT_DATE,NUM ");
        sql.append("FROM TRANSFER_INFO_DETAIL TD JOIN PFR_FEEDBACK_RECORD PR ON TD.APP_ID = PR.FB_REC_ID ");
        sql.append(" JOIN  PFR_FEEDBACK_INFO PI ON PR.FEEDBACK_ID=PI.FEEDBACK_ID ");
        sql.append(" JOIN  NCM_ARCHIVE_INFO NI ON PI.ARCHIVE_ID = NI.ARCHIVE_ID ");
        sql.append("WHERE 1=1 AND TID_ID ='"+TID_ID+"' ");
        System.out.println(sql);
        DataList dl = ide.find(sql.toString());
        return dl;
    }
    /**
     * ͨ��������ȡ���ӵ���TRANSFER_INFO������Ϣ
     * @param conn
     * @param TI_ID
     * @return
     * @throws DBException
     */
    public Data TransferEdit(Connection conn,String TI_ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data=new Data();
    	data.setEntityName("TRANSFER_INFO");
    	data.setPrimaryKey("TI_ID");
    	data.add("TI_ID", TI_ID);
    	Data resda= ide.findByPrimaryKey(data);
    	return resda;
    }
    public DataList queryTransferDatalistById()throws DBException{
    	return null;
    }
    /**
     * ���ӵ��޸��Ƴ��������ݷ���
     * @param conn
     * @param updatalist
     * @return
     */
    
	public int updateDetail(Connection conn, DataList updatalist) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dlDataList =new DataList();
    	for(int i=0;i<updatalist.size();i++){
    		Data data=new Data();
    		data.setEntityName("TRANSFER_INFO_DETAIL");
    		data.setPrimaryKey("TID_ID");
    		data.add("TID_ID", updatalist.getData(i).getString("TID_ID"));
    		data.add("TI_ID", "");
    		data.add("TRANSFER_STATE", TransferConstant.TRANSFER_STATE_TODO);
    		dlDataList.add(data);
    	}
    	
    	return ide.batchStore(dlDataList);
		
	}
    /**
     * **************************************����Ϊ���ܻ��ڷ���**********************************************
     */
    /**
     * ��ѯ���ӵ���-����
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList TransferReceiveList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
		//��ѯ����
		String CONNECT_NO = data.getString("CONNECT_NO", null);//���ӵ����
		String COPIES = data.getString("COPIES", null);//����
		String TRANSFER_USERNAME = data.getString("TRANSFER_USERNAME", null);//�ƽ���
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//�ƽ����ڿ�ʼ
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//�ƽ����ڽ�ֹ
		String RECEIVER_USERNAME = data.getString("RECEIVER_USERNAME", null);//������
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//����ʱ�俪ʼ
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//����ʱ���ֹ
		String AT_STATE = data.getString("AT_STATE", null);//�ƽ�״̬
		

		//String OPER_TYPE =data.getString("OPER_TYPE",null);    //��������
		String OPER_TYPE = "1";//��������Ϊ����
		String TRANSFER_CODE =data.getString("TRANSFER_CODE",null);    //ҵ�񻷽ڣ����Ӵ��룩
		boolean flag = false;
		//����ǵ��������Ĵ��ý�����������ҵ���ҵ�������������
		if(TRANSFER_CODE!=null&&TransferCode.RFM_FILE_DAB.equals(TRANSFER_CODE.substring(0,1))){
			TRANSFER_CODE = TransferCode.RFM_FILE_DAB;
			flag = true ;
		}
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = "";
        if(flag){
        	sql = getSql("TransferReceiveList_RFM",CONNECT_NO,COPIES,TRANSFER_USERNAME,TRANSFER_DATE_START,TRANSFER_DATE_END,RECEIVER_USERNAME,RECEIVER_DATE_START,RECEIVER_DATE_END,AT_STATE,compositor,ordertype,TRANSFER_CODE,OPER_TYPE);
        }else{
        	sql = getSql("TransferReceiveList",CONNECT_NO,COPIES,TRANSFER_USERNAME,TRANSFER_DATE_START,TRANSFER_DATE_END,RECEIVER_USERNAME,RECEIVER_DATE_START,RECEIVER_DATE_END,AT_STATE,compositor,ordertype,TRANSFER_CODE,OPER_TYPE);
        }
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);

        	
        return dl;
    }
    /**
     * �����ļ�ȷ�Ϸ���
     * @param conn
     * @param TI_ID
     * @param RECEIVER_DEPT_NAME 
     * @param RECEIVER_DEPT_ID 
     * @param RECEIVER_USERNAME 
     * @param RECEIVER_USERID 
     * @return
     */
	public Data ReceiveConfirm(Connection conn, String TI_ID, String RECEIVER_USERID, String RECEIVER_USERNAME, String RECEIVER_DEPT_ID, String RECEIVER_DEPT_NAME) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String currentDate = DateUtility.getCurrentDate();
    	
    	Data data=new Data();
    	data.setEntityName("TRANSFER_INFO");
    	data.setPrimaryKey("TI_ID");
    	data.add("TI_ID", TI_ID);
    	data.add("RECEIVER_DATE", currentDate);
    	data.add("RECEIVER_USERID", RECEIVER_USERID);
    	data.add("RECEIVER_USERNAME", RECEIVER_USERNAME);
    	data.add("RECEIVER_DEPT_ID", RECEIVER_DEPT_ID);
    	data.add("RECEIVER_DEPT_NAME", RECEIVER_DEPT_NAME);
    	data.add("AT_STATE", "2");
    	data.add("OPER_TYPE", "2");
    	Data resda= ide.store(data);
    	return resda;
		
	}
	/**
	 * �����ļ�ȷ�Ϸ���-���½����ļ���ϸ
	 * @param conn
	 * @param TI_ID
	 * @return
	 */
	public boolean ReceiveConfirmDetail(Connection conn, String TI_ID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	StringBuffer sql = new StringBuffer();
    	sql.append("UPDATE TRANSFER_INFO_DETAIL T SET T.TRANSFER_STATE = '3' ");
    	sql.append("WHERE T.TI_ID ='"+TI_ID+"' ");
    	return ide.execute(sql.toString());
	}
	/**
	 * ��ѯ���ӵ���ϸ����Ϣ
	 * @param conn
	 * @param TI_ID
	 * @return
	 * @throws DBException
	 */
	public DataList selectTransferDetailById(Connection conn, String TI_ID) throws DBException{
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		
		String sql = "SELECT * FROM TRANSFER_INFO_DETAIL WHERE TI_ID='"+TI_ID+"' ";
		
		DataList dl =ide.find(sql);
		
		return dl;
	}
	/**
	 * ��ѯ���ӵ���ϸ����Ϣ
	 * @param conn
	 * @param TI_ID
	 * @return
	 * @throws DBException
	 */
	public Data selectTransferById(Connection conn, String TI_ID) throws DBException{
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		
		String sql = "SELECT * FROM TRANSFER_INFO WHERE TI_ID='"+TI_ID+"' ";
		
		Data da =(ide.find(sql)).getData(0);
		
		return da;
	}
    /**
     * �����ļ��˻ط���
     * @param conn
     * @param TI_ID
     * @param RECEIVER_DEPT_NAME 
     * @param RECEIVER_DEPT_ID 
     * @param RECEIVER_USERNAME 
     * @param RECEIVER_USERID 
     * @return
     */
	public Data ReceiveReturn(Connection conn, String TI_ID, String REJECT_USERID, String REJECT_USERNAME, String RECEIVER_DEPT_ID, String RECEIVER_DEPT_NAME,String REJECT_DESC) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	
    	Data data=new Data();
    	data.setEntityName("TRANSFER_INFO");
    	data.setPrimaryKey("TI_ID");
    	data.add("TI_ID", TI_ID);
    	data.add("REJECT_USERID", REJECT_USERID);
    	data.add("REJECT_USERNAME", REJECT_USERNAME);
    	data.add("RECEIVER_DEPT_ID", RECEIVER_DEPT_ID);
    	data.add("RECEIVER_DEPT_NAME", RECEIVER_DEPT_NAME);
    	data.add("REJECT_DATE", UtilDateTime.nowDateString());
    	data.add("REJECT_DESC", REJECT_DESC);
    	data.add("AT_STATE", "0"); //״̬���ó����ƽ�
    	data.add("OPER_TYPE", "1"); //������������Ϊ�ƽ�
    	Data resda= ide.store(data);
    	return resda;
		
	}
	/**
	 * �����ļ��˻ط���-���½����ļ���ϸ
	 * @param conn
	 * @param TI_ID
	 * @return
	 */
	public boolean ReceiveReturnDetail(Connection conn, String TI_ID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	StringBuffer sql = new StringBuffer();
    	sql.append("UPDATE TRANSFER_INFO_DETAIL T SET T.TRANSFER_STATE = '1' "); //״̬���ó����ƽ�
    	sql.append("WHERE T.TI_ID ='"+TI_ID+"' ");
    	return ide.execute(sql.toString());
		
	}
	/**
	 * ��ϸ��ѯ����
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 */
	public DataList FindDetailList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype)  throws DBException {
		//��ѯ����
		String TRANSFER_CODE = data.getString("TRANSFER_CODE", null);//ҵ��ڵ����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//���Ҵ���
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//������������
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//������ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//���Ľ�������
		String MALE_NAME = data.getString("MALE_NAME", null);//��������
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//Ů������
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//�ƽ���ʼ����
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//�ƽ���ֹ����
		String FILE_NO = data.getString("FILE_NO", null);//�ļ����
		String CONNECT_NO = data.getString("CONNECT_NO", null);//���ӵ����RECEIVER_DATE
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//������ʼ����
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//���ս�������
		String FILE_TYPE = data.getString("FILE_TYPE", null);//�ļ�����
		String TRANSFER_STATE = data.getString("TRANSFER_STATE", null);//�ļ�����
		String OPER_TYPE=data.getString("OPER_TYPE", null);//��������
		if(TRANSFER_STATE==null){
			if(OPER_TYPE!=null&&"1".equals(OPER_TYPE)){
				TRANSFER_STATE ="'0','1','2','3'";
			}else if(OPER_TYPE!=null&&"2".equals(OPER_TYPE)){
				TRANSFER_STATE ="'2','3'";
			}
		}
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("FindDetailList",TRANSFER_CODE,COUNTRY_CODE,ADOPT_ORG_ID,REGISTER_DATE_START,REGISTER_DATE_END,MALE_NAME,FEMALE_NAME,TRANSFER_DATE_START,TRANSFER_DATE_END,FILE_NO,CONNECT_NO,RECEIVER_DATE_START,RECEIVER_DATE_END,FILE_TYPE,TRANSFER_STATE);

        //StringBuffer sql =new StringBuffer();
        
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);

        	
        return dl;
		
	}
	/**
	 * ��ϸ��ѯ������������
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 */
	public DataList FindChildinfoDetailList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype)  throws DBException {
		String OPER_TYPE=data.getString("OPER_TYPE", TransferConstant.OPER_TYPE_SEND);//��������
		StringBuffer sql =new StringBuffer();        
        sql.append("SELECT " +
        		"TID_ID," +
        		"CHILD_NO," +
        		"PROVINCE_ID," +
        		"WELFARE_NAME_CN," +
        		"NAME," +
        		"SEX," +
        		"BIRTHDAY," +
        		"CHILD_TYPE," +
        		"SPECIAL_FOCUS," +
        		"CONNECT_NO," +
        		"TRANSFER_DATE," +
        		"RECEIVER_DATE, " +
        		"TRANSFER_STATE" +        		
        		" FROM TRANSFER_INFO_DETAIL TD,TRANSFER_INFO TI, CMS_CI_INFO CI" +
        		" WHERE TD.TI_ID=TI.TI_ID AND TD.APP_ID = CI.CI_ID  " +
        		"AND TD.TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' ");
		
		if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //��ͯ���ϱ��
			sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
		}
		if(data.getString("PROVINCE_ID")!=null&&!"".equals(data.getString("PROVINCE_ID"))){ //ʡ��ID
			sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
		}
		if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //����ԺID
			sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
			sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //�Ա�
			sql.append("AND SEX = '"+data.getString("SEX")+"' ");
		}
		if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //��ͯ���տ�ʼ
			sql.append("AND BIRTHDAY >= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //��ͯ���ս���
			sql.append("AND BIRTHDAY <= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //��ͯ���
			sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
		}
		if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //�ر��ע
			sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
		}
		if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //���ӵ����
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
		if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //����״̬
			sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
		}else{
			 if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){
				sql.append("AND TRANSFER_STATE IN ('2','3')");
			 }
		}
		if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //�ƽ����ڿ�ʼ
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //�ƽ����ڽ���
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //�������ڿ�ʼ
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //�������ڽ���
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
		
		if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
			sql.append(" ORDER BY  ");
			sql.append(compositor);
		}
		if(ordertype!=null&&!"".equals(ordertype)){ //������
			sql.append(" ");
			sql.append(ordertype);
		}
		System.out.println(sql);
		ide = DataBaseFactory.getDataBase(conn);
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
	}
	/**
	 * ��ϸ��ѯ�����������ϣ�ƥ�䣩
	 * @Title: FindChildMatchinfoDetailList
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-11-26����6:48:36
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 * @throws DBException
	 */
	public DataList FindChildMatchinfoDetailList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype)  throws DBException {
        String OPER_TYPE=data.getString("OPER_TYPE", TransferConstant.OPER_TYPE_SEND);//��������
        StringBuffer sql =new StringBuffer();        
        sql.append("SELECT TID_ID,CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,SPECIAL_FOCUS,CONNECT_NO,TRANSFER_DATE,TI.RECEIVER_DATE AS RECEIVER_DATE,TD.TRANSFER_STATE AS TRANSFER_STATE," + 
                "COUNTRY_CODE,COUNTRY_CN,ADOPT_ORG_ID,NAME_CN,FILE_NO,FILE_TYPE "+
                "FROM TRANSFER_INFO_DETAIL TD RIGHT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID JOIN TRANSFER_INFO TI ON TD.TI_ID=TI.TI_ID "+
                "LEFT JOIN (SELECT AF_ID,CI_ID FROM NCM_MATCH_INFO WHERE  MATCH_STATE <> '4' AND MATCH_STATE <> '9' ) A ON A.CI_ID=TD.APP_ID "+
                "LEFT JOIN FFS_AF_INFO AF ON AF.AF_ID=A.AF_ID "+
                "WHERE 1=1 AND TD.TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' ");
        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //����
            sql.append("AND COUNTRY_CODE='"+data.getString("COUNTRY_CODE")+"' ");
        }
        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯
            sql.append("AND ADOPT_ORG_ID='"+data.getString("ADOPT_ORG_ID")+"' ");
        }
        if(data.getString("FILE_NO")!=null&&!"".equals(data.getString("FILE_NO"))){ //�ļ����
            sql.append("AND FILE_NO LIKE '%"+data.getString("FILE_NO")+"%' ");
        }
        if(data.getString("FILE_TYPE")!=null&&!"".equals(data.getString("FILE_TYPE"))){ //�ļ�����
            sql.append("AND FILE_TYPE='"+data.getString("FILE_TYPE")+"' ");
        }
        if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //��ͯ���ϱ��
            sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
        }
        if(data.getString("PROVINCE_ID")!=null&&!"".equals(data.getString("PROVINCE_ID"))){ //ʡ��ID
            sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
        }
        if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //����ԺID
            sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
        }
        if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
            sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
        }
        if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //�Ա�
            sql.append("AND SEX = '"+data.getString("SEX")+"' ");
        }
        if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //��ͯ���տ�ʼ
            sql.append("AND BIRTHDAY >= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //��ͯ���ս���
            sql.append("AND BIRTHDAY <= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
        }
        if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //��ͯ���
            sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
        }
        if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //�ر��ע
            sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
        }
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //���ӵ����
            sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
        }
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //����״̬
            sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
        }else{
             if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){
                sql.append("AND TRANSFER_STATE IN ('2','3')");
             }
        }
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //�ƽ����ڿ�ʼ
            sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //�ƽ����ڽ���
            sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
        }
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //�������ڿ�ʼ
            sql.append("AND TI.RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //�������ڽ���
            sql.append("AND TI.RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
        }
        
        if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //������
            sql.append(" ");
            sql.append(ordertype);
        }
        System.out.println(sql);
        ide = DataBaseFactory.getDataBase(conn);
        DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
    }
	
	/**
	 * ��ϸ��ѯ��������Ʊ��
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 */
	public DataList FindChequeDetailList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype)  throws DBException {
		
		ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT PAID_NO,COUNTRY_CODE,NAME_CN,PAID_WAY,BILL_NO,PAR_VALUE,TI.CONNECT_NO AS CONNECT_NO,TI.TRANSFER_DATE AS TRANSFER_DATE,TI.RECEIVER_DATE AS RECEIVER_DATE,T.TRANSFER_STATE AS TRANSFER_STATE  ");
        sql.append("FROM TRANSFER_INFO_DETAIL T RIGHT JOIN  FAM_CHEQUE_INFO F ON T.APP_ID =F.CHEQUE_ID   JOIN TRANSFER_INFO TI ON T.TI_ID=TI.TI_ID  ");
		sql.append("WHERE 1=1 ");
		
        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //����
			sql.append("AND F.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
		}
        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯
			sql.append("AND F.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
		}
        if(data.getString("PAID_WAY")!=null&&!"".equals(data.getString("PAID_WAY"))){ //�ɷѷ�ʽ
            sql.append("AND F.PAID_WAY = '"+data.getString("PAID_WAY")+"' ");
        }
        if(data.getString("PAID_NO")!=null&&!"".equals(data.getString("PAID_NO"))){ //�ɷѱ��
			sql.append("AND F.PAID_NO LIKE '%"+data.getString("PAID_NO")+"%' ");
		}
        if(data.getString("BILL_NO")!=null&&!"".equals(data.getString("BILL_NO"))){ //Ʊ��
			sql.append("AND F.BILL_NO LIKE '%"+data.getString("BILL_NO")+"%' ");
		}
        if(data.getString("PAR_VALUE_START")!=null&&!"".equals(data.getString("PAR_VALUE_START"))){ //Ʊ������ʼֵ
			sql.append("AND F.PAR_VALUE >= "+data.getString("PAR_VALUE_START")+" ");
		}
        if(data.getString("PAR_VALUE_END")!=null&&!"".equals(data.getString("PAR_VALUE_END"))){ //Ʊ�����ֵֹ
			sql.append("AND F.PAR_VALUE <= "+data.getString("PAR_VALUE_END")+" ");
		}
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //�ƽ������
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //�ƽ�������ʼֵ
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //�ƽ����ڽ�ֵֹ
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //����������ʼֵ
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //�ƽ����ڽ�ֵֹ
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
        String OPER_TYPE=data.getString("OPER_TYPE");//��������
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //�ƽ�״̬
            sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
        }else{
            if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){//����
                sql.append("AND TRANSFER_STATE IN ('2','3') ");
            }
            if(TransferConstant.OPER_TYPE_SEND.equals(OPER_TYPE)){//�ƽ�
                sql.append("AND TRANSFER_STATE IN ('0','1','2','3') ");
            }
        }
        
        if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }else{
            sql.append(" ORDER BY TRANSFER_DATE ");
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //������
            sql.append(" ");
            sql.append(ordertype);
        }
		System.out.println(sql);	
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
		
	}
	/**
	 * ��ϸ��ѯ�����������ú󱨸�
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 */
	public DataList FindArchiveDetailList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype)  throws DBException {
		ide = DataBaseFactory.getDataBase(conn);
        StringBuffer sql =new StringBuffer();
        sql.append("SELECT TD.TI_ID AS TI_ID,NI.COUNTRY_CODE AS COUNTRY_CODE, NI.NAME_CN AS NAME_CN,NI.ARCHIVE_NO AS ARCHIVE_NO ,MALE_NAME,FEMALE_NAME,NAME,SIGN_DATE,REPORT_DATE,NUM,TI.CONNECT_NO AS CONNECT_NO,TI.TRANSFER_DATE AS TRANSFER_DATE,TI.RECEIVER_DATE AS RECEIVER_DATE,TD.TRANSFER_STATE AS TRANSFER_STATE  ");
        sql.append(" FROM TRANSFER_INFO_DETAIL TD JOIN PFR_FEEDBACK_RECORD PR ON TD.APP_ID = PR.FB_REC_ID  ");
        sql.append(" JOIN  PFR_FEEDBACK_INFO PI ON PR.FEEDBACK_ID=PI.FEEDBACK_ID");
        sql.append(" JOIN  NCM_ARCHIVE_INFO NI ON PI.ARCHIVE_ID = NI.ARCHIVE_ID");
        sql.append(" JOIN TRANSFER_INFO TI ON TI.TI_ID = TD.TI_ID ");
		sql.append("WHERE 1=1 ");
		
		if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //���Ҵ���
			sql.append("AND NI.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
		}
		if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯�������
			sql.append("AND NI.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
		}
		if(data.getString("ARCHIVE_NO")!=null&&!"".equals(data.getString("ARCHIVE_NO"))){ //������
			sql.append("AND NI.ARCHIVE_NO LIKE '%"+data.getString("ARCHIVE_NO")+"%' ");
		}
		if(data.getString("MALE_NAME")!=null&&!"".equals(data.getString("MALE_NAME"))){ //������������
			sql.append("AND NI.MALE_NAME LIKE '%"+data.getString("MALE_NAME")+"%' ");
		}
		if(data.getString("FEMALE_NAME")!=null&&!"".equals(data.getString("FEMALE_NAME"))){ //Ů����������
			sql.append("AND NI.FEMALE_NAME LIKE '%"+data.getString("FEMALE_NAME")+"%' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
			sql.append("AND NI.NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SIGN_DATE_START")!=null&&!"".equals(data.getString("SIGN_DATE_START"))){ //ǩ���տ�ʼ
			sql.append("AND SIGN_DATE >= to_date('"+data.getString("SIGN_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("SIGN_DATE_END")!=null&&!"".equals(data.getString("SIGN_DATE_END"))){ //ǩ�����ڽ���
			sql.append("AND SIGN_DATE <= to_date('"+data.getString("SIGN_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("REPORT_DATE_START")!=null&&!"".equals(data.getString("REPORT_DATE_START"))){ //��������տ�ʼ
			sql.append("AND REPORT_DATE >= to_date('"+data.getString("REPORT_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("REPORT_DATE_END")!=null&&!"".equals(data.getString("REPORT_DATE_END"))){ //����������ڽ���
			sql.append("AND REPORT_DATE <= to_date('"+data.getString("REPORT_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("NUM")!=null&&!"".equals(data.getString("NUM"))){ //����
			sql.append("AND NUM = '"+data.getString("NUM")+"' ");
		}
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //�ƽ������
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //�ƽ�������ʼֵ
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //�ƽ����ڽ�ֵֹ
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //����������ʼֵ
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //�������ڽ�ֵֹ
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
        String OPER_TYPE=data.getString("OPER_TYPE");//��������
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //�ƽ�״̬
			sql.append("AND TD.TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
		}else{
		    if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){//����
		        sql.append("AND TD.TRANSFER_STATE IN ('2','3') ");
		    }
		    if(TransferConstant.OPER_TYPE_SEND.equals(OPER_TYPE)){//�ƽ�
		        sql.append("AND TD.TRANSFER_STATE IN ('0','1','2','3') ");
		    }
		}
        if(data.getString("TRANSFER_CODE")!=null&&!"".equals(data.getString("TRANSFER_CODE"))){ //�ƽ�״̬
            sql.append("AND TD.TRANSFER_CODE = '"+data.getString("TRANSFER_CODE")+"' ");
        }
        if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }else{
            sql.append(" ORDER BY TRANSFER_DATE ");
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //������
            sql.append(" ");
            sql.append(ordertype);
        }
		System.out.println(sql);	
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
		
	}
	/**
     * ��ѯ�ֹ���Ӳ��Ͻ��ӵ��б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
	 public DataList TransferMannualChildinfoList(Connection conn, Data data,  int pageSize, int page, String compositor, String ordertype)  throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT TID_ID," +	//�ƽ���¼ID
				"CHILD_NO," +				//��ͯ���
				"PROVINCE_ID," +			//ʡ��ID
				"WELFARE_NAME_CN," +//����Ժ����
				"NAME,SEX," +					//��ͯ�Ա�
				"BIRTHDAY," +					//��������
				"CHILD_TYPE," +				//��ͯ���
				"SPECIAL_FOCUS "+		//�Ƿ��ر��ע
				"FROM TRANSFER_INFO_DETAIL TD LEFT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID  " +
				"WHERE TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' "+
				"AND TRANSFER_STATE = '" + TransferConstant.TRANSFER_STATE_TODO  +"'");//δ�ƽ�״̬				
		
		
		if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //��ͯ���ϱ��
			sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
		}
		if(data.getString("PROVINCE_ID")!=null && !"".equals(data.getString("PROVINCE_ID"))){ //ʡ��ID
			sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
		}
		if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //����ԺID
			sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
			sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //�Ա�
			sql.append("AND SEX = '"+data.getString("SEX")+"' ");
		}
		if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //��ͯ���տ�ʼ
			sql.append("AND BIRTHDAY>= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //��ͯ���ս���
			sql.append("AND BIRTHDAY<= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //��ͯ���
			sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
		}
		if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //�ر��ע
			sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
		}
		if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
			sql.append(" ORDER BY  ");
			sql.append(compositor);
		}
		if(ordertype!=null&&!"".equals(ordertype)){ //������
			sql.append(" ");
			sql.append(ordertype);
		}
		
		System.out.println(sql);
        DataList dl = ide.find(sql.toString(), pageSize, page);
		return dl;
	}
	 /**
	  * ��ѯ�ֹ���Ӳ��Ͻ��ӵ��б���ƥ����Ϣ��
	  * @Title: TransferMannualChildMatchinfoList
	  * @Description: 
	  * @author: xugy
	  * @date: 2014-11-26����5:22:28
	  * @param conn
	  * @param data
	  * @param pageSize
	  * @param page
	  * @param compositor
	  * @param ordertype
	  * @return
	  * @throws DBException
	  */
	 public DataList TransferMannualChildMatchinfoList(Connection conn, Data data,  int pageSize, int page, String compositor, String ordertype)  throws DBException{
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        StringBuffer sql = new StringBuffer();
	        sql.append("SELECT TID_ID,CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,SPECIAL_FOCUS,"+ 
	                    "COUNTRY_CODE,COUNTRY_CN,ADOPT_ORG_ID,NAME_CN,FILE_NO,FILE_TYPE "+
	                "FROM TRANSFER_INFO_DETAIL TD LEFT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID " +
	                "LEFT JOIN (SELECT AF_ID,CI_ID FROM NCM_MATCH_INFO WHERE  MATCH_STATE <> '4' AND MATCH_STATE <> '9') A ON A.CI_ID=TD.APP_ID "+
	                "LEFT JOIN FFS_AF_INFO AF ON AF.AF_ID=A.AF_ID "+
	                "WHERE TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' "+
	                "AND TRANSFER_STATE = '" + TransferConstant.TRANSFER_STATE_TODO  +"'");//δ�ƽ�״̬              
	        
	        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //����
                sql.append("AND COUNTRY_CODE='"+data.getString("COUNTRY_CODE")+"' ");
            }
	        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯
                sql.append("AND ADOPT_ORG_ID='"+data.getString("ADOPT_ORG_ID")+"' ");
            }
	        if(data.getString("FILE_NO")!=null&&!"".equals(data.getString("FILE_NO"))){ //�ļ����
                sql.append("AND FILE_NO LIKE '%"+data.getString("FILE_NO")+"%' ");
            }
	        if(data.getString("FILE_TYPE")!=null&&!"".equals(data.getString("FILE_TYPE"))){ //�ļ�����
                sql.append("AND FILE_TYPE='"+data.getString("FILE_TYPE")+"' ");
            }
	        if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //��ͯ���ϱ��
	            sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
	        }
	        if(data.getString("PROVINCE_ID")!=null && !"".equals(data.getString("PROVINCE_ID"))){ //ʡ��ID
	            sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
	        }
	        if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //����ԺID
	            sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
	        }
	        if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
	            sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
	        }
	        if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //�Ա�
	            sql.append("AND SEX = '"+data.getString("SEX")+"' ");
	        }
	        if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //��ͯ���տ�ʼ
	            sql.append("AND BIRTHDAY>= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
	        }
	        if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //��ͯ���ս���
	            sql.append("AND BIRTHDAY<= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
	        }
	        if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //��ͯ���
	            sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
	        }
	        if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //�ر��ע
	            sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
	        }
	        if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
	            sql.append(" ORDER BY  ");
	            sql.append(compositor);
	        }
	        if(ordertype!=null&&!"".equals(ordertype)){ //������
	            sql.append(" ");
	            sql.append(ordertype);
	        }
	        
	        System.out.println(sql);
	        DataList dl = ide.find(sql.toString(), pageSize, page);
	        return dl;
	    }
	 
	 
		/**
	     * ��ѯ���Ʊ�ݽ��ӵ��б�
	     * @param conn
	     * @param data
	     * @param pageSize
	     * @param page
	     * @param compositor
	     * @param ordertype
	     * @return
	     * @throws DBException
	     */
		 public DataList TransferMannualChequeList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException{
			IDataExecute ide = DataBaseFactory.getDataBase(conn);
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT T.TID_ID AS TID_ID, PAID_NO,COUNTRY_CODE,NAME_CN,PAID_WAY,BILL_NO,PAR_VALUE FROM TRANSFER_INFO_DETAIL T JOIN FAM_CHEQUE_INFO F ON T.APP_ID =F.CHEQUE_ID ");
			sql.append("WHERE 1 = 1 ");
			sql.append("AND TRANSFER_STATE = '0' "); //δ�ƽ�״̬
			if(data.getString("PAID_NO")!=null&&!"".equals(data.getString("PAID_NO"))){ //Ʊ��id
				sql.append("AND PAID_NO LIKE '%"+data.getString("PAID_NO")+"%' ");
			}
			if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //���Ҵ���
				sql.append("AND COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
			}
			if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯�������
				sql.append("AND ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
			}
			if(data.getString("PAID_WAY")!=null&&!"".equals(data.getString("PAID_WAY"))){ //�ɷѷ�ʽ
			    sql.append("AND PAID_WAY = '"+data.getString("PAID_WAY")+"' ");
			}
			if(data.getString("BILL_NO")!=null&&!"".equals(data.getString("BILL_NO"))){ //�ɷѱ��
				sql.append("AND BILL_NO LIKE '%"+data.getString("BILL_NO")+"%' ");
			}
			if(data.getString("PAR_VALUE")!=null&&!"".equals(data.getString("PAR_VALUE"))){ //Ʊ����
				sql.append("AND PAR_VALUE = '"+data.getString("PAR_VALUE")+"' ");
			}
			if(data.getString("TRANSFER_CODE")!=null&&!"".equals(data.getString("TRANSFER_CODE"))){ //Ʊ����
                sql.append("AND TRANSFER_CODE = '"+data.getString("TRANSFER_CODE")+"' ");
            }
			if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
	            sql.append(" ORDER BY  ");
	            sql.append(compositor);
	        }
	        if(ordertype!=null&&!"".equals(ordertype)){ //������
	            sql.append(" ");
	            sql.append(ordertype);
	        }
			System.out.println(sql);
	        DataList dl = ide.find(sql.toString(), pageSize, page);
			return dl;
		}
		 /**
		     * ��ѯ��Ӱ��ú󱨸潻�ӵ��б�
		     * @param conn
		     * @param data
		     * @param pageSize
		     * @param page
		     * @param compositor
		     * @param ordertype
		     * @return
		     * @throws DBException
		     */
			 public DataList transferMannualArchiveList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException{
				IDataExecute ide = DataBaseFactory.getDataBase(conn);
				StringBuffer sql = new StringBuffer();
				//�ı����ӣ��ƽ���ϸ��TRANSFER_INFO_DETAIL�������ú󱨸��¼��PFR_FEEDBACK_RECORD�������ú󱨸���Ϣ��PFR_FEEDBACK_INFO������������������Ϣ��NCM_ARCHIVE_INFO��
				sql.append("SELECT TD.TID_ID AS TID_ID, NI.COUNTRY_CODE AS COUNTRY_CODE,NI.NAME_CN AS NAME_CN,NI.ARCHIVE_NO AS ARCHIVE_NO ,MALE_NAME,FEMALE_NAME,NAME,SIGN_DATE,REPORT_DATE,NUM ");
				sql.append("FROM TRANSFER_INFO_DETAIL TD JOIN PFR_FEEDBACK_RECORD PR ON TD.APP_ID = PR.FB_REC_ID ");
				sql.append(" JOIN  PFR_FEEDBACK_INFO PI ON PR.FEEDBACK_ID=PI.FEEDBACK_ID ");
				sql.append(" JOIN  NCM_ARCHIVE_INFO NI ON PI.ARCHIVE_ID = NI.ARCHIVE_ID ");
				sql.append("WHERE 1 = 1 ");
				sql.append("AND TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' ");//ȷ���ƽ�ҵ��
				sql.append("AND TRANSFER_STATE = '0' "); //δ�ƽ�״̬
				if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //���Ҵ���
					sql.append("AND NI.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
				}
				if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //������֯�������
					sql.append("AND NI.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
				}
				if(data.getString("ARCHIVE_NO")!=null&&!"".equals(data.getString("ARCHIVE_NO"))){ //������
					sql.append("AND NI.ARCHIVE_NO LIKE '%"+data.getString("ARCHIVE_NO")+"%' ");
				}
				if(data.getString("MALE_NAME")!=null&&!"".equals(data.getString("MALE_NAME"))){ //������������
					sql.append("AND NI.MALE_NAME LIKE '%"+data.getString("MALE_NAME")+"%' ");
				}
				if(data.getString("FEMALE_NAME")!=null&&!"".equals(data.getString("FEMALE_NAME"))){ //Ů����������
					sql.append("AND NI.FEMALE_NAME LIKE '%"+data.getString("FEMALE_NAME")+"%' ");
				}
				if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //��ͯ����
					sql.append("AND NI.NAME LIKE '%"+data.getString("NAME")+"%' ");
				}
				if(data.getString("SIGN_DATE_STRART")!=null&&!"".equals(data.getString("SIGN_DATE_STRART"))){ //ǩ���տ�ʼ
					sql.append("AND SIGN_DATE>= to_date('"+data.getString("SIGN_DATE_STRART")+"','yyyy-MM-DD') ");
				}
				if(data.getString("SIGN_DATE_END")!=null&&!"".equals(data.getString("SIGN_DATE_END"))){ //ǩ�����ڽ���
					sql.append("AND SIGN_DATE<= to_date('"+data.getString("SIGN_DATE_END")+"','yyyy-MM-DD') ");
				}
				if(data.getString("REPORT_DATE_STRART")!=null&&!"".equals(data.getString("REPORT_DATE_STRART"))){ //��������տ�ʼ
					sql.append("AND REPORT_DATE>= to_date('"+data.getString("REPORT_DATE_STRART")+"','yyyy-MM-DD') ");
				}
				if(data.getString("REPORT_DATE_END")!=null&&!"".equals(data.getString("REPORT_DATE_END"))){ //����������ڽ���
					sql.append("AND REPORT_DATE<= to_date('"+data.getString("REPORT_DATE_END")+"','yyyy-MM-DD') ");
				}
				if(data.getString("NUM")!=null&&!"".equals(data.getString("NUM"))){ //����
					sql.append("AND NUM = '"+data.getString("NUM")+"' ");
				}
				if(compositor!=null&&!"".equals(compositor)){ //�����ֶ�
	                sql.append(" ORDER BY  ");
	                sql.append(compositor);
	            }
	            if(ordertype!=null&&!"".equals(ordertype)){ //������
	                sql.append(" ");
	                sql.append(ordertype);
	            }
				System.out.println(sql);
		        DataList dl = ide.find(sql.toString(), pageSize, page);
				return dl;
			}
		/**
		 * �ж��ļ��Ƿ�����������ͯ���ļ������������ͯ����true��δ��������false
		 * @param conn
		 * @param fi_id
		 * @return
		 * @throws DBException 
		 */
		public boolean isTFile(Connection conn, String af_id) throws DBException {
			boolean flag =false;
			IDataExecute ide = DataBaseFactory.getDataBase(conn);
			String sql ="SELECT AF_ID FROM FFS_AF_INFO WHERE AF_ID = '"+af_id+"' AND FILE_TYPE IN ('20','21','22','23')";
			DataList dl= ide.find(sql);
			if(dl!=null&&dl.size()!=0){
				flag =true;
			}
			return flag;
		}
		/**
		 * @throws DBException  
		 * @Title: updateFamChequeInfo 
		 * @Description: TODO(������һ�仰�����������������)
		 * @author: yangrt;
		 * @param conn
		 * @param pjData    �趨�ļ� 
		 * @return void    �������� 
		 * @throws 
		 */
		public boolean updateFamChequeInfo(Connection conn, Data pjData) throws DBException {
			pjData.setConnection(conn);
			pjData.setEntityName("FAM_CHEQUE_INFO");
			pjData.setPrimaryKey("CHEQUE_ID");
			pjData.store();
			
			return true;
		}
		
		
		/**
		 * ���ݽ�����ϸID��ö�Ӧ�����ļ�����ͣ��־
	     * @param conn
	     * @param String TID_ID ������ϸID
	     * @return Data  [IS_PAUSE,FILE_NO] 
	     * @throws DBException
	     */
	    public Data getFilePauseStatusByTIDID(Connection conn,String TID_ID)
	            throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
			String sql = getSql("getFilePauseStatusByTIDID",TID_ID);
			//System.out.println("getFilePauseStatusByTIDIDSql---->"+sql);
			
			Data data = new Data();
			String is_pause="";
			String file_no="";
			data.add("IS_PAUSE", is_pause);
			data.add("FILE_NO",file_no);
			
			DataList dl = ide.find(sql);
			
			if(dl.size()>0){
				data = (Data)dl.get(0);
			}
			return data;
	    }
	    /**
	     * 
	     * @Title: saveTransferInfo
	     * @Description: ���潻�ӵ���Ϣ
	     * @author: xugy
	     * @date: 2014-11-21����6:24:23
	     * @param conn
	     * @param data
	     * @return
	     * @throws DBException
	     */
	    public Data saveTransferInfo(Connection conn, Data data) throws DBException{
	        Data dataadd = new Data(data);
	        dataadd.setConnection(conn);
	        dataadd.setEntityName("TRANSFER_INFO");
	        dataadd.setPrimaryKey("TI_ID");
	        if("".equals(dataadd.getString("TI_ID", ""))){
	            return  dataadd.create();
	        }else{
	            return  dataadd.store();
	        }
	    }
	    /**
	     * 
	     * @Title: saveTransferInfoDetail
	     * @Description: ���潻����ϸ
	     * @author: xugy
	     * @date: 2014-11-24����10:24:05
	     * @param conn
	     * @param data
	     * @return
	     * @throws DBException
	     */
	    public Data saveTransferInfoDetail(Connection conn, Data data) throws DBException{
	        Data dataadd = new Data(data);
	        dataadd.setConnection(conn);
	        dataadd.setEntityName("TRANSFER_INFO_DETAIL");
	        dataadd.setPrimaryKey("TID_ID");
	        if("".equals(dataadd.getString("TID_ID", ""))){
	            return  dataadd.create();
	        }else{
	            return  dataadd.store();
	        }
	    }
	    /**
	     * 
	     * @Title: getTransferInfoDetail
	     * @Description: 
	     * @author: xugy
	     * @date: 2014-12-8����7:24:50
	     * @param conn
	     * @param TID_ID
	     * @return 
	     * @throws DBException 
	     */
        public Data getTransferInfoDetail(Connection conn, String TID_ID) throws DBException {
            IDataExecute ide = DataBaseFactory.getDataBase(conn);
            Data data=new Data();
            data.setEntityName("TRANSFER_INFO_DETAIL");
            data.setPrimaryKey("TID_ID");
            data.add("TID_ID", TID_ID);
            Data resda= ide.findByPrimaryKey(data);
            return resda;
        }
}
