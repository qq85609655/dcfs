package com.dcfs.cms.childManager;

import java.sql.Connection;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

public class ChildManagerHandler extends BaseHandler{
	 
	/**
     *��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 
    	String WELFARE_NAME_CN		= data.getString("WELFARE_NAME_CN", null);
    	String WELFARE_ID					= data.getString("WELFARE_ID", null);    
    	String NAME							= data.getString("NAME", null);               
    	String SEX								= data.getString("SEX", null);                
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);         
    	String SN_TYPE						= data.getString("SN_TYPE", null);            
    	String AUD_STATE					= data.getString("AUD_STATE", null);        
    	String PUB_STATE						= data.getString("PUB_STATE", null);          
    	String MATCH_STATE				= data.getString("MATCH_STATE", null);        
    	String BIRTHDAY_START			= data.getString("BIRTHDAY_START", null);     
    	String BIRTHDAY_END				= data.getString("BIRTHDAY_END", null);       
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null); 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null);   
    	String IS_PLAN							= data.getString("IS_PLAN", null);            
    	String IS_HOPE							= data.getString("IS_HOPE", null);            
    	String REG_USERNAME			= data.getString("REG_USERNAME", null);       
    	String REG_DATE_START			= data.getString("REG_DATE_START", null);     
    	String REG_DATE_END				= data.getString("REG_DATE_END", null);       
    	String POST_DATE_START			= data.getString("POST_DATE_START", null);    
    	String POST_DATE_END			= data.getString("POST_DATE_END", null);      
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null); 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);
    	String UPDATE_NUM_START 	= data.getString("UPDATE_NUM_START",null);
    	String UPDATE_NUM_END 		= data.getString("UPDATE_NUM_END",null);
    	String SEND_DATE_START 		= data.getString("SEND_DATE_START",null);
    	String SEND_DATE_END 			= data.getString("SEND_DATE_END",null);
    	String IS_DAILU 						= data.getString("IS_DAILU",null);
       
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //������ѯ���sql,ʹ����Ժ��ѯsql�밲�ò���¼sql���ֿ�������Ǹ���Ժ��ѯ������δ�ύ�Ķ�ͯ����ֻ�ܿ�������Ժ¼��ģ�������ʡ�����ò���¼��δ�ύ��ͯ����
        String sql="";
        if(IS_DAILU==null){//����Ժ�����ϱ��͡�
        	 sql = getSql("findListFLY",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END);
        }else{//���ò����ϴ�¼
        	 sql = getSql("findList",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END,IS_DAILU);
        }
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *��ͯ�����ۺϲ�ѯ
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList ChildInfoSynQuery(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 
    	String WELFARE_NAME_CN		= data.getString("WELFARE_NAME_CN", null);
    	String WELFARE_ID					= data.getString("WELFARE_ID", null);    
    	String NAME							= data.getString("NAME", null);               
    	String SEX								= data.getString("SEX", null);                
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);         
    	String SN_TYPE						= data.getString("SN_TYPE", null);            
    	String AUD_STATE					= data.getString("AUD_STATE", null);        
    	String PUB_STATE						= data.getString("PUB_STATE", null);          
    	String MATCH_STATE				= data.getString("MATCH_STATE", null);        
    	String BIRTHDAY_START			= data.getString("BIRTHDAY_START", null);     
    	String BIRTHDAY_END				= data.getString("BIRTHDAY_END", null);       
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null); 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null);   
    	String IS_PLAN							= data.getString("IS_PLAN", null);            
    	String IS_HOPE							= data.getString("IS_HOPE", null);            
    	String REG_USERNAME			= data.getString("REG_USERNAME", null);       
    	String REG_DATE_START			= data.getString("REG_DATE_START", null);     
    	String REG_DATE_END				= data.getString("REG_DATE_END", null);       
    	String POST_DATE_START			= data.getString("POST_DATE_START", null);    
    	String POST_DATE_END			= data.getString("POST_DATE_END", null);      
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null); 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);
    	String UPDATE_NUM_START 	= data.getString("UPDATE_NUM_START",null);
    	String UPDATE_NUM_END 		= data.getString("UPDATE_NUM_END",null);
    	String SEND_DATE_START 		= data.getString("SEND_DATE_START",null);
    	String SEND_DATE_END 			= data.getString("SEND_DATE_END",null);
    	String IS_DAILU 						= data.getString("IS_DAILU",null);
    	String IS_OVERAGE					= data.getString("IS_OVERAGE",null);
    	String CI_GLOBAL_STATE			= data.getString("CI_GLOBAL_STATE",null);

    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("ChildInfoSynQuery",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END,IS_DAILU,IS_OVERAGE,CI_GLOBAL_STATE);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *ʡ����˼��Ͳ�ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList STAuditList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String CHILD_TYPE		= data.getString("CHILD_TYPE", null);         
    	String SN_TYPE			= data.getString("SN_TYPE", null);            
    	String AUD_STATE		= data.getString("AUD_STATE", null);        
    	String BIRTHDAY_START		= data.getString("BIRTHDAY_START", null);     
    	String BIRTHDAY_END		= data.getString("BIRTHDAY_END", null);       
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null); 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null);   
    	String IS_PLAN			= data.getString("IS_PLAN", null);            
    	String IS_HOPE			= data.getString("IS_HOPE", null);            
    	String POST_DATE_START		= data.getString("POST_DATE_START", null);    
    	String POST_DATE_END		= data.getString("POST_DATE_END", null);      
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null); 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);
    	String SEND_DATE_START = data.getString("SEND_DATE_START",null);
    	String SEND_DATE_END = data.getString("SEND_DATE_END",null);
    	String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);
    	String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);

    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("ST_CI_AUDIT_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,SN_TYPE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,IS_PLAN,IS_HOPE,SEND_DATE_START,SEND_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,AUD_STATE,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     *���ò���˲�ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList AZBAuditList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); //ʡ��
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);//����Ժ
    	String NAME							= data.getString("NAME", null);//����
    	String SEX								= data.getString("SEX", null);//�Ա�
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);//��ͯ����         
    	String SN_TYPE						= data.getString("SN_TYPE", null);//��������            
    	String AUD_STATE					= data.getString("AUD_STATE", null);//���״̬
    	String BIRTHDAY_START			= data.getString("BIRTHDAY_START", null);//��������
    	String BIRTHDAY_END				= data.getString("BIRTHDAY_END", null);//��������      
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null);//������� 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null); //�������  
    	String IS_PLAN							= data.getString("IS_PLAN", null); //����ƻ�           
    	String IS_HOPE							= data.getString("IS_HOPE", null); //ϣ��֮��
    	String SPECIAL_FOCUS			= data.getString("SPECIAL_FOCUS", null);//�ر��ע
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null);//�������� 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);//��������
    	String DISEASE_CN					= data.getString("DISEASE_CN", null);//�������
    	String HAVE_VIDEO					= data.getString("HAVE_VIDEO", null);//��Ƶ
    	String PUB_STATE						= data.getString("PUB_STATE", null);//����״̬
    	String MATCH_STATE				= data.getString("MATCH_STATE", null);//ƥ��״̬    	
    	String TRANSLATION_STATE= data.getString("TRANSLATION_STATE", null);//����״̬  
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AZB_CI_AUDIT_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,SN_TYPE,DISEASE_CN,HAVE_VIDEO,IS_PLAN,IS_HOPE,SPECIAL_FOCUS,RECEIVE_DATE_START,RECEIVE_DATE_END,PUB_STATE,AUD_STATE,MATCH_STATE,TRANSLATION_STATE,compositor,ordertype,CHILD_TYPE);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *��ͯ���Ͻ��ղ�ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList childReceiveList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String CHILD_TYPE		= data.getString("CHILD_TYPE", null);         
    	String SN_TYPE			= data.getString("SN_TYPE", null);            
    	String BIRTHDAY_START		= data.getString("BIRTHDAY_START", null);     
    	String BIRTHDAY_END		= data.getString("BIRTHDAY_END", null);       
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null); 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null);   
    	String IS_PLAN			= data.getString("IS_PLAN", null);            
    	String IS_HOPE			= data.getString("IS_HOPE", null);            
    	String POST_DATE_START		= data.getString("POST_DATE_START", null);    
    	String POST_DATE_END		= data.getString("POST_DATE_END", null);      
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null); 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);
    	String RECEIVE_STATE = data.getString("RECEIVE_STATE", null);
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AZB_CI_RECEIVE_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,SN_TYPE,BIRTHDAY_START,BIRTHDAY_END,
        		CHECKUP_DATE_START,CHECKUP_DATE_END,IS_PLAN,IS_HOPE,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,
        		RECEIVE_STATE,compositor,ordertype);
        System.out.print(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * ��ͯ������˴���
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
	public boolean childInfoAudit(Connection conn, Data ciData,Data auditData) throws DBException {
		
		//�����ͯ������Ϣ
		Data cdata = new Data(ciData);
		cdata.setConnection(conn);
		cdata.setEntityName("CMS_CI_INFO");
		cdata.setPrimaryKey("CI_ID");
		cdata = cdata.store();
		
		//�����ͯ��˼�¼��Ϣ
		Data adata = new Data(auditData);
		adata.setConnection(conn);
		adata.setEntityName("CMS_CI_ADUIT");
		adata.setPrimaryKey("CA_ID");
		adata = adata.store();
		return true;
	}
    
    /**
     *��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildInfoList(Connection conn, Data data)
            throws DBException {
    	
    	//��ѯ����
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);    
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String BIRTHDAY		= data.getString("BIRTHDAY", null);     
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildList",WELFARE_ID,NAME,SEX,BIRTHDAY);
        DataList dl = ide.find(sql);        
        return dl;
    }
    /**
     *�ж��Ƿ�����ظ���ͯ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getRepeatChildList(Connection conn, Data data)
            throws DBException {
    	
    	//��ѯ����  
    	String   CI_ID      = data.getString("CI_ID");    
    	String WELFARE_ID	= data.getString("WELFARE_ID", null);    
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String BIRTHDAY		= data.getString("BIRTHDAY", null);     
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildList1",CI_ID,WELFARE_ID,NAME,SEX,BIRTHDAY);
        DataList dl = ide.find(sql);        
        return dl;
    }
    /**
     * ���ݶ�ͯ����ID��ȡ��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildListByCIID(Connection conn, String[] uuid)
            throws DBException {
    	
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,IS_HOPE,IS_PLAN,SN_TYPE FROM CMS_CI_INFO WHERE");
        sb.append(" CI_ID='").append(uuid[0]).append("'");
        for (int i = 1; i < uuid.length; i++) {
        	sb.append(" OR CI_ID='").append(uuid[i]).append("'");
        }
        DataList dl = ide.find(sb.toString());
        return dl;
    }
    /**
     * ���ݶ�ͯ����ID�Ͷ�ͯ���ͻ�ȡ��ͯ���ϼ�¼�б�
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildListByCIIDAndChildType(Connection conn, String[] uuid,String child_type)
            throws DBException {
    	
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,IS_HOPE,IS_PLAN,SN_TYPE FROM CMS_CI_INFO WHERE");
        sb.append(" CHILD_TYPE='").append(child_type).append("'").append(" AND (");
        sb.append(" CI_ID='").append(uuid[0]).append("'");
        for (int i = 1; i < uuid.length; i++) {
        	sb.append(" OR CI_ID='").append(uuid[i]).append("'");
        }
        sb.append(")");
        System.out.println(sb.toString());
        DataList dl = ide.find(sb.toString());
        return dl;
    }
    
	  /**
     * �����ͯ������Ϣ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
	public Data save(Connection conn, Data data) throws DBException {
		// ***��������*****
		Data dataadd = new Data(data);

		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_INFO");
		dataadd.setPrimaryKey("CI_ID");
		if ("".equals(dataadd.getString("CI_ID", ""))) {
			dataadd = dataadd.create();			
		} else {
			dataadd = dataadd.store();
		}
		return dataadd;
	}
	
	/**
	 * ���������˼�¼
	 * 
	 */
	public boolean saveCIAduit(Connection conn, Data data) throws DBException {
		// ***��������*****
		Data dataadd = new Data(data);

		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_ADUIT");
		dataadd.setPrimaryKey("CA_ID");
		if ("".equals(dataadd.getString("CA_ID", ""))) {
			dataadd.create();
		} else {
			dataadd.store();
		}
		return true;
	}
    
    /**
     * ɾ����ͯ����
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
            data.setEntityName("CMS_CI_INFO");
            data.setPrimaryKey("CI_ID");
            data.add("CI_ID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
    
    /**
     * ����ͬ����Ϣ
     * @param conn
     * @param childList
     * @return
     * @throws DBException
     */
    public void setTwins(Connection conn, DataList childList) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);        
	    ide.batchStore(childList);	        
    }
    
    /**
     * ���ͬ����ͯ��ţ���ż��ԣ��ŷָ�
     * @param cnos
     * @param childno
     * @return
     */
    public String getTWINS_IDS(String cnos,String childno){
    	String s = ","+childno;
    	String sc = ","+cnos + ",";
    	sc = sc.replace(s, "");
    	if(sc.length()==1){
    		sc = "";
    	}else{
    		sc = sc.substring(1,sc.length()-1);
    	}
    	return sc;    	
    }
    
    /**
     * ��ȡ��ͯ������ֵ����û���򷵻�null
     * @throws DBException 
     * 
     */
    public Data getMaxChildNO(Connection conn, String proviceId,String year) throws DBException{    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMaxChildNO",proviceId,year);
        DataList dl = ide.find(sql);
        if(dl.size()!=0){
        	return dl.getData(0);
        }else{
        	return null;
        }
    }
    
    /**
     * ������ͯ���Ϸ����¼���˷������ڶ�ͯ�����ͷ�����ʹ��
     * @param conn
     * @param DataList
     * ����data��ʽΪ��
     * CI_ID ��ͯ����ID
     * TRANSLATION_TYPE ��������
     * NOTICE_DATE ����֪ͨ����
     * NOTICE_USERID ����֪ͨ��ID
     * NOTICE_USERNAME ����֪ͨ������
     * TRANSLATION_STATE ����״̬����ʼ��ӦΪTRANSLATION_STATE_TODO="0";//	�����룩
     */
    
   public void initCITranslation(Connection conn,DataList dataList) throws DBException{ 
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   ide.batchCreate(dataList);	   
   }
   
   /**
    * ���¶�ͯ����״̬���˷������ڶ�ͯ���Ϸ��뽻��ʹ��
    * @param conn
    * @param dataList
    * ����data��ʽΪ��
    * CI_ID ��ͯ����ID
    * @throws DBException
    */
   public void updateCIState(Connection conn,DataList dataList)throws DBException{ 
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList ciDataList = new DataList();
	   /*���ݽ��յķ������Ͻ����ж�
	   ������������ϣ���״̬����Ϊ����ƥ�䡱
	   �����������ϣ���״̬����Ϊ����������
	   */
	   for(int i=0;i<dataList.size();i++){
		   Data d = dataList.getData(i);
		   String sql = getSql("getChildTypeByCIID",d.getString("CI_ID"));
		   Data rd = ide.find(sql).getData(0);
		   rd.setEntityName("CMS_CI_INFO");
		   rd.setPrimaryKey("CI_ID");
		   if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(rd.getString("CHILD_TYPE"))){//������ͯ
			   rd.put("MATCH_STATE", ChildStateManager.CHILD_MATCH_STATE_TODO);
		   }
		   if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(rd.getString("CHILD_TYPE"))){//�����ͯ
			   rd.put("PUB_STATE", ChildStateManager.CHILD_PUB_STATE_TODO);
		   }
		   ciDataList.add(rd);
	   }
	   ide.batchStore(ciDataList);	   
   }
   
    
    /**
     * ���ɶ�ͯ���
     * @param conn
     * @param data
     * @param operType
     * @return
     * @throws DBException
     */
    public boolean createChildNO(Connection conn, Data data,String operType) throws DBException{
    	// ***��������*****
		Data dataadd = new Data(data);

		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_CHILDNO");
		dataadd.setPrimaryKey("YEAR","PROVINCE_ID");
		if ("new".equals(operType)) {
			dataadd.create();
		} else {
			dataadd.store();
		}
		return true;
    }
    
    /**
     * ���ݶ�ͯ��Ż�ȡͬ����ͯ��Ϣ
     * @param conn
     * @param childNO
     * @return
     * @throws DBException
     */
    public DataList getTwinsByChildNO(Connection conn, String childNO)
            throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTwinsByChildNO",childNO);
        DataList dl = ide.find(sql);        
        return dl;
    }
    
    /**
     * ���ݶ�ͯ������ID���ϻ�ȡ��ͯ��Ϣ
     * @param conn
     * @param MainCIIDS����ID���ϣ���(1,2,3)��
     * @return ��ͯ���ϼ���dataList
     * @throws DBException
     */
    public DataList getChildListByMainCIIDS(Connection conn, String MainCIIDS)  
    	throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildListByMainCIID",MainCIIDS);
        System.out.println(sql);
        DataList dl = ide.find(sql);        
        return dl;   	
    }
    
    /**
     * ���ݶ�ͯ����ID���ϻ�ȡ��ͯ��Ϣ
     * @param conn
     * @param CIID
     * @return ��ͯ���ϼ���dataList
     * @throws DBException
     */
    public DataList getTwinListByCIID(Connection conn, String CI_ID)  
    	throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTwinListByCIID",CI_ID);
        System.out.println(sql);
        DataList dl = ide.find(sql);        
        return dl;   	
    }
   
    /**
     * �����Ч��ͯ��Ϣ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList getValidChildList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	//��ѯ����
    	String WELFARE_ID = data.getString("WELFARE_ID", null);   
    	String NAME = data.getString("NAME", null);   
    	String SEX = data.getString("SEX", null);   
    	String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   
    	String BIRTHDAY_END = data.getString("BIRTHDAY_END", null); 
    	String CI_ID = data.getString("CI_ID");
    	String CHILD_NO = data.getString("CHILD_NO");
    	
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getValidChildList",WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,compositor,ordertype,CI_ID,CHILD_NO);
        System.out.println("getValidChildList:"+sql);
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
     * ��ͯ���ϲ鿴(��ͯ��Ϣ������֯ͳһ�鿴)
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data showForAdoption(Connection conn, String uuid, String ri_state) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        String sql = null;
        if("".equals(ri_state) || "null".equals(ri_state)||!"9".equals(ri_state)){
        	sql = getSql("showForAdoption", uuid);
        }else{
        	sql = getSql("showForAdoptionInvalid", uuid);
        }
        System.out.println(sql);
        dataList = ide.find(sql);
        return dataList.getData(0);
    }
    /**
     * ��ͯ���ϸ�����Ϣ�鿴(�����鿴ҳ�������Ӣ��)
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public DataList childAttShowList(Connection conn, String packageId,String smallType) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("childAttShowList", packageId,smallType));
        return dataList;
    }
    /**
     * �鿴��˼�¼
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getChildInfoAuditData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("CI_AUDIT_ITEM", uuid));
        return dataList.getData(0);
    }
    
    /**
     * ����CIID��ȡ�ö�ͯ����˼�¼
     * ��˼�¼ֻ��ʾ�����ɵļ�¼
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public DataList getAuditListByCIID(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("CI_AUDIT_RECORDER", uuid));
        return dataList;
    }
    
    /**
     * ����ʡ�ݻ��������ȡ����ʡ�ݵĸ���Ժ������Ϣ
     * @param conn
     * @param orgCode
     * @return
     * @throws DBException
     */
    public DataList getWelfareByProvinceCode(Connection conn,String orgCode) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getFlyByProvinceID", orgCode.substring(0,2)));
        return dataList;
    }
    
    /**
     * ��ȡ���еĸ���Ժ��Ϣ
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList getAllWelfareList(Connection conn)throws DBException {    	
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getAllWelfareList"));
        return dataList;
    }
    
    /**
     * ��ȡ���ݸ���Ժid��ȡ����Ժ�����Ϣ
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList getOrgDeitail(Connection conn,String org_code)throws DBException {    	
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getOrgDeitailByCode",org_code));
        return dataList;
    }
    
   /**
    * ����Ժ�����ύ
    * @param conn
    * @param dataList ��ͯ���ϼ���
    * @param aduitDataList ��˼�¼����
    * @return
    * @throws DBException
    */
    public boolean flyBatchSubmit(Connection conn, DataList dataList,DataList aduitDataList) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchStore(dataList);
        ide.batchCreate(aduitDataList);
        return true;
    }
    
    /**
     * ʡ����������
     * @param conn
     * @param uuid ����id����
     * @return
     * @throws DBException
     */
     public boolean stBatchPost(Connection conn, String[] uuid) throws DBException {
         IDataExecute ide = DataBaseFactory.getDataBase(conn);
         //���ϼ�¼list
         DataList dataList = new DataList();
         ChildCommonManager ccm = new ChildCommonManager();
         
         for (int i = 0; i < uuid.length; i++) {
         	//���¶�ͯ����״̬
             Data data = new Data();
             data.setConnection(conn);
             data.setEntityName("CMS_CI_INFO");
             data.setPrimaryKey("CI_ID");
             data.add("CI_ID", uuid[i]);
             UserInfo curuser = SessionInfo.getCurUser();	
             data.add("POST_USERID", curuser.getPerson().getPersonId());
             data.add("POST_USERNAME", curuser.getPerson().getCName());
             data.add("POST_DATE", DateUtility.getCurrentDate());
             data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_YJS);
             data.add("RECEIVE_STATE", ChildStateManager.CHILD_RECEIVE_STATE_TODO);
             
             //��ͯ����ȫ��״̬
            ccm.stAuditPost(data, null);             
             dataList.add(data);
         }
         ide.batchStore(dataList);
         
         return true;
     }
     
     
     /**
      * ���ò���������
      * @param conn
      * @param uuid ����id����
      * @return
      * @throws DBException
      */
      public boolean azbBatchReceive(Connection conn, String[] uuid) throws DBException {
          IDataExecute ide = DataBaseFactory.getDataBase(conn);

          //���ϼ�¼list
          DataList dataList = new DataList();
          //��˼�¼list
          DataList auddataList = new DataList();
          ChildCommonManager ccm = new ChildCommonManager();
          
          for (int i = 0; i < uuid.length; i++) {
          	  //���¶�ͯ����״̬
              Data data = new Data();
              data.setConnection(conn);
              data.setEntityName("CMS_CI_INFO");
              data.setPrimaryKey("CI_ID");
              data.add("CI_ID", uuid[i]);
              data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_YJIES);
              data.add("RECEIVE_STATE", ChildStateManager.CHILD_RECEIVE_STATE_DONE);
              UserInfo curuser = SessionInfo.getCurUser();	
              data.add("RECEIVE_USERID", curuser.getPerson().getPersonId());
              data.add("RECEIVE_USERNAME",curuser.getPerson().getCName());
              data.add("RECEIVE_DATE", DateUtility.getCurrentDate()); 
              
              //��ͯ����ȫ��״̬
              ccm.zxReceiveChildInfo(data, curuser.getCurOrgan());
              dataList.add(data);
              
              //�������ò���˼�¼
              Data auddata = new Data();
              auddata.setConnection(conn);
              auddata.setEntityName("CMS_CI_ADUIT");
              auddata.setPrimaryKey("CA_ID");
              auddata.add("CI_ID", uuid[i]);
              auddata.add("AUDIT_LEVEL", ChildInfoConstants.LEVEL_CCCWA);
              auddata.add("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
              auddataList.add(auddata);            
              
          }
          ide.batchStore(dataList);
          ide.batchCreate(auddataList);
          return true;
      }
      
      /**
       * ���ò���¼�����ύ
       * @param conn
       * @param uuid ����id����
       * @param state ����״̬
       * state=1 �����ͷ�
       * state=2 ��������
       * @return
       * @throws DBException
       */
       public boolean azbBatchSubmit(Connection conn, String[] uuid,String state) throws DBException {
           IDataExecute ide = DataBaseFactory.getDataBase(conn);
           //���ϼ�¼list
          // DataList dataList = new DataList();
           //������˼�¼list
           DataList aduitDataList = new DataList();
           //�����ͷ��ƽ���¼list
           DataList transferDataList = new DataList();
           
           for (int i = 0; i < uuid.length; i++) {           	
        	   /*//���¶�ͯ����״̬
               Data data = new Data();
               data.setConnection(conn);
               data.setEntityName("CMS_CI_INFO");
               data.setPrimaryKey("CI_ID");
               data.add("CI_ID", uuid[i]);
               data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_YJS);
               dataList.add(data);*/
               
               if("1".equals(state)){//�ͷ�
            	   //������ͯ�����ƽ���¼
            	   Data dataTransfer =new Data();
            		dataTransfer.put("APP_ID",uuid[i]);
            		dataTransfer.put("TRANSFER_CODE", TransferCode.CHILDINFO_AZB_FYGS);
            		dataTransfer.put("TRANSFER_STATE","0");
            		transferDataList.add(dataTransfer);            		
               }
               
               if("2".equals(state)){//����
					// ������ͯ������˼�¼
					Data aduitData = new Data();
					aduitData.setConnection(conn);
					aduitData.setEntityName("CMS_CI_ADUIT");
					aduitData.setPrimaryKey("CA_ID");
					aduitData.put("CI_ID", uuid[i]);
					aduitData.put("AUDIT_LEVEL", ChildInfoConstants.LEVEL_CCCWA);
					aduitData.put("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
					aduitDataList.add(aduitData);
               }
           }
           
           //ide.batchStore(dataList);
           if("2".equals(state)){//����
        	   ide.batchCreate(aduitDataList);
           }
           if("1".equals(state)){//�ͷ�
        	   FileCommonManager fm = new FileCommonManager();
   				fm.transferDetailInit(conn, transferDataList);
           }
           return true;
       }
       
       
       /**
        * �����ƽ���ID�������¶�ͯ����ȫ��״̬
        * @param conn
        * @param TI_ID ���ӵ�ID
        * @param status ȫ��״̬
        * @param orgCode ����λ��
        * @throws DBException
        */
       public boolean updateChildGlobalStatusByTiID(Connection conn,String TI_ID,String status,String orgCode)throws DBException{ 
    	   IDataExecute ide = DataBaseFactory.getDataBase(conn);    	   
    		ide = DataBaseFactory.getDataBase(conn);
        	StringBuffer sql=new StringBuffer();
        	sql.append("UPDATE CMS_CI_INFO SET CI_GLOBAL_STATE='").append(status).append("',");
        	sql.append(" CI_POSITION='").append(orgCode).append("'");        	
        	sql.append(" WHERE CI_ID IN (");
        	sql.append(" SELECT APP_ID FROM TRANSFER_INFO_DETAIL WHERE TI_ID = '"+TI_ID+"' )");
        	System.out.println(sql);
        	return ide.execute(sql.toString());
       }
}
