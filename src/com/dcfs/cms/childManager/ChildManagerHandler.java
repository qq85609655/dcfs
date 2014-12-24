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
     *儿童材料记录查询列表
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
    	
    	//查询条件
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
       
    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //调整查询语句sql,使福利院查询sql与安置部代录sql语句分开；如果是福利院查询，对于未提交的儿童材料只能看到福利院录入的，不包括省厅或安置部代录的未提交儿童材料
        String sql="";
        if(IS_DAILU==null){//福利院“材料报送”
        	 sql = getSql("findListFLY",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END);
        }else{//安置部材料代录
        	 sql = getSql("findList",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END,IS_DAILU);
        }
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *儿童材料综合查询
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
    	
    	//查询条件
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

    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("ChildInfoSynQuery",NAME,SEX,CHILD_TYPE,SN_TYPE,AUD_STATE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype,IS_PLAN,IS_HOPE,REG_USERNAME,REG_DATE_START,REG_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,PROVINCE_ID,PUB_STATE,MATCH_STATE,WELFARE_NAME_CN,WELFARE_ID,UPDATE_NUM_START,UPDATE_NUM_END,SEND_DATE_START,SEND_DATE_END,IS_DAILU,IS_OVERAGE,CI_GLOBAL_STATE);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *省厅审核寄送查询列表
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
    	//查询条件
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

    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("ST_CI_AUDIT_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,SN_TYPE,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,IS_PLAN,IS_HOPE,SEND_DATE_START,SEND_DATE_END,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,AUD_STATE,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     *安置部审核查询列表
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
    	//查询条件
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); //省份
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);//福利院
    	String NAME							= data.getString("NAME", null);//姓名
    	String SEX								= data.getString("SEX", null);//性别
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);//儿童类型         
    	String SN_TYPE						= data.getString("SN_TYPE", null);//疾病类型            
    	String AUD_STATE					= data.getString("AUD_STATE", null);//审核状态
    	String BIRTHDAY_START			= data.getString("BIRTHDAY_START", null);//出生日期
    	String BIRTHDAY_END				= data.getString("BIRTHDAY_END", null);//出生日期      
    	String CHECKUP_DATE_START	= data.getString("CHECKUP_DATE_START", null);//体检日期 
    	String CHECKUP_DATE_END		= data.getString("CHECKUP_DATE_END", null); //体检日期  
    	String IS_PLAN							= data.getString("IS_PLAN", null); //明天计划           
    	String IS_HOPE							= data.getString("IS_HOPE", null); //希望之旅
    	String SPECIAL_FOCUS			= data.getString("SPECIAL_FOCUS", null);//特别关注
    	String RECEIVE_DATE_START	= data.getString("RECEIVE_DATE_START", null);//接收日期 
    	String RECEIVE_DATE_END		= data.getString("RECEIVE_DATE_END", null);//接收日期
    	String DISEASE_CN					= data.getString("DISEASE_CN", null);//病残诊断
    	String HAVE_VIDEO					= data.getString("HAVE_VIDEO", null);//视频
    	String PUB_STATE						= data.getString("PUB_STATE", null);//发布状态
    	String MATCH_STATE				= data.getString("MATCH_STATE", null);//匹配状态    	
    	String TRANSLATION_STATE= data.getString("TRANSLATION_STATE", null);//翻译状态  
    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AZB_CI_AUDIT_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,CHECKUP_DATE_START,CHECKUP_DATE_END,SN_TYPE,DISEASE_CN,HAVE_VIDEO,IS_PLAN,IS_HOPE,SPECIAL_FOCUS,RECEIVE_DATE_START,RECEIVE_DATE_END,PUB_STATE,AUD_STATE,MATCH_STATE,TRANSLATION_STATE,compositor,ordertype,CHILD_TYPE);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *儿童材料接收查询列表
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
    	
    	//查询条件
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
    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AZB_CI_RECEIVE_LIST",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,SN_TYPE,BIRTHDAY_START,BIRTHDAY_END,
        		CHECKUP_DATE_START,CHECKUP_DATE_END,IS_PLAN,IS_HOPE,POST_DATE_START,POST_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,
        		RECEIVE_STATE,compositor,ordertype);
        System.out.print(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 儿童材料审核处理
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
	public boolean childInfoAudit(Connection conn, Data ciData,Data auditData) throws DBException {
		
		//保存儿童材料信息
		Data cdata = new Data(ciData);
		cdata.setConnection(conn);
		cdata.setEntityName("CMS_CI_INFO");
		cdata.setPrimaryKey("CI_ID");
		cdata = cdata.store();
		
		//保存儿童审核记录信息
		Data adata = new Data(auditData);
		adata.setConnection(conn);
		adata.setEntityName("CMS_CI_ADUIT");
		adata.setPrimaryKey("CA_ID");
		adata = adata.store();
		return true;
	}
    
    /**
     *儿童材料记录查询列表
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildInfoList(Connection conn, Data data)
            throws DBException {
    	
    	//查询条件
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);    
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String BIRTHDAY		= data.getString("BIRTHDAY", null);     
    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildList",WELFARE_ID,NAME,SEX,BIRTHDAY);
        DataList dl = ide.find(sql);        
        return dl;
    }
    /**
     *判断是否存在重复儿童
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getRepeatChildList(Connection conn, Data data)
            throws DBException {
    	
    	//查询条件  
    	String   CI_ID      = data.getString("CI_ID");    
    	String WELFARE_ID	= data.getString("WELFARE_ID", null);    
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String BIRTHDAY		= data.getString("BIRTHDAY", null);     
    	//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildList1",CI_ID,WELFARE_ID,NAME,SEX,BIRTHDAY);
        DataList dl = ide.find(sql);        
        return dl;
    }
    /**
     * 根据儿童材料ID获取儿童材料记录查询列表
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
     * 根据儿童材料ID和儿童类型获取儿童材料记录列表
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
     * 保存儿童材料信息
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
	public Data save(Connection conn, Data data) throws DBException {
		// ***保存数据*****
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
	 * 保存材料审核记录
	 * 
	 */
	public boolean saveCIAduit(Connection conn, Data data) throws DBException {
		// ***保存数据*****
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
     * 删除儿童材料
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
     * 设置同胞信息
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
     * 获得同胞儿童编号，编号间以，号分割
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
     * 获取儿童编号最大值，如没有则返回null
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
     * 创建儿童材料翻译记录，此方法用于儿童材料送翻交接使用
     * @param conn
     * @param DataList
     * 其中data格式为：
     * CI_ID 儿童材料ID
     * TRANSLATION_TYPE 翻译类型
     * NOTICE_DATE 翻译通知日期
     * NOTICE_USERID 翻译通知人ID
     * NOTICE_USERNAME 翻译通知人姓名
     * TRANSLATION_STATE 翻译状态（初始化应为TRANSLATION_STATE_TODO="0";//	待翻译）
     */
    
   public void initCITranslation(Connection conn,DataList dataList) throws DBException{ 
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   ide.batchCreate(dataList);	   
   }
   
   /**
    * 更新儿童材料状态，此方法用于儿童材料翻译交接使用
    * @param conn
    * @param dataList
    * 其中data格式为：
    * CI_ID 儿童材料ID
    * @throws DBException
    */
   public void updateCIState(Connection conn,DataList dataList)throws DBException{ 
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList ciDataList = new DataList();
	   /*根据接收的翻译后材料进行判断
	   如果是正常材料，则状态更新为“待匹配”
	   如果是特需材料，则状态更新为“待发布”
	   */
	   for(int i=0;i<dataList.size();i++){
		   Data d = dataList.getData(i);
		   String sql = getSql("getChildTypeByCIID",d.getString("CI_ID"));
		   Data rd = ide.find(sql).getData(0);
		   rd.setEntityName("CMS_CI_INFO");
		   rd.setPrimaryKey("CI_ID");
		   if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(rd.getString("CHILD_TYPE"))){//正常儿童
			   rd.put("MATCH_STATE", ChildStateManager.CHILD_MATCH_STATE_TODO);
		   }
		   if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(rd.getString("CHILD_TYPE"))){//特需儿童
			   rd.put("PUB_STATE", ChildStateManager.CHILD_PUB_STATE_TODO);
		   }
		   ciDataList.add(rd);
	   }
	   ide.batchStore(ciDataList);	   
   }
   
    
    /**
     * 生成儿童编号
     * @param conn
     * @param data
     * @param operType
     * @return
     * @throws DBException
     */
    public boolean createChildNO(Connection conn, Data data,String operType) throws DBException{
    	// ***保存数据*****
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
     * 根据儿童编号获取同胞儿童信息
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
     * 根据儿童材料主ID集合获取儿童信息
     * @param conn
     * @param MainCIIDS（主ID集合，如(1,2,3)）
     * @return 儿童材料集合dataList
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
     * 根据儿童材料ID集合获取儿童信息
     * @param conn
     * @param CIID
     * @return 儿童材料集合dataList
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
     * 获得有效儿童信息列表
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
    	
    	//查询条件
    	String WELFARE_ID = data.getString("WELFARE_ID", null);   
    	String NAME = data.getString("NAME", null);   
    	String SEX = data.getString("SEX", null);   
    	String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   
    	String BIRTHDAY_END = data.getString("BIRTHDAY_END", null); 
    	String CI_ID = data.getString("CI_ID");
    	String CHILD_NO = data.getString("CHILD_NO");
    	
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getValidChildList",WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,compositor,ordertype,CI_ID,CHILD_NO);
        System.out.println("getValidChildList:"+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 查看
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
     * 儿童材料查看(儿童信息收养组织统一查看)
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
     * 儿童材料附件信息查看(附件查看页面包括中英文)
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
     * 查看审核记录
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
     * 根据CIID获取该儿童的审核记录
     * 审核记录只显示审核完成的记录
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
     * 根据省份机构代码获取所属省份的福利院基本信息
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
     * 获取所有的福利院信息
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
     * 获取根据福利院id获取福利院相关信息
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
    * 福利院批量提交
    * @param conn
    * @param dataList 儿童材料集合
    * @param aduitDataList 审核记录集合
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
     * 省厅批量寄送
     * @param conn
     * @param uuid 材料id集合
     * @return
     * @throws DBException
     */
     public boolean stBatchPost(Connection conn, String[] uuid) throws DBException {
         IDataExecute ide = DataBaseFactory.getDataBase(conn);
         //材料记录list
         DataList dataList = new DataList();
         ChildCommonManager ccm = new ChildCommonManager();
         
         for (int i = 0; i < uuid.length; i++) {
         	//更新儿童材料状态
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
             
             //儿童材料全局状态
            ccm.stAuditPost(data, null);             
             dataList.add(data);
         }
         ide.batchStore(dataList);
         
         return true;
     }
     
     
     /**
      * 安置部批量接收
      * @param conn
      * @param uuid 材料id集合
      * @return
      * @throws DBException
      */
      public boolean azbBatchReceive(Connection conn, String[] uuid) throws DBException {
          IDataExecute ide = DataBaseFactory.getDataBase(conn);

          //材料记录list
          DataList dataList = new DataList();
          //审核记录list
          DataList auddataList = new DataList();
          ChildCommonManager ccm = new ChildCommonManager();
          
          for (int i = 0; i < uuid.length; i++) {
          	  //更新儿童材料状态
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
              
              //儿童材料全局状态
              ccm.zxReceiveChildInfo(data, curuser.getCurOrgan());
              dataList.add(data);
              
              //创建安置部审核记录
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
       * 安置部代录批量提交
       * @param conn
       * @param uuid 材料id集合
       * @param state 材料状态
       * state=1 批量送翻
       * state=2 批量送审
       * @return
       * @throws DBException
       */
       public boolean azbBatchSubmit(Connection conn, String[] uuid,String state) throws DBException {
           IDataExecute ide = DataBaseFactory.getDataBase(conn);
           //材料记录list
          // DataList dataList = new DataList();
           //材料审核记录list
           DataList aduitDataList = new DataList();
           //材料送翻移交记录list
           DataList transferDataList = new DataList();
           
           for (int i = 0; i < uuid.length; i++) {           	
        	   /*//更新儿童材料状态
               Data data = new Data();
               data.setConnection(conn);
               data.setEntityName("CMS_CI_INFO");
               data.setPrimaryKey("CI_ID");
               data.add("CI_ID", uuid[i]);
               data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_YJS);
               dataList.add(data);*/
               
               if("1".equals(state)){//送翻
            	   //创建儿童材料移交记录
            	   Data dataTransfer =new Data();
            		dataTransfer.put("APP_ID",uuid[i]);
            		dataTransfer.put("TRANSFER_CODE", TransferCode.CHILDINFO_AZB_FYGS);
            		dataTransfer.put("TRANSFER_STATE","0");
            		transferDataList.add(dataTransfer);            		
               }
               
               if("2".equals(state)){//送审
					// 创建儿童材料审核记录
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
           if("2".equals(state)){//送审
        	   ide.batchCreate(aduitDataList);
           }
           if("1".equals(state)){//送翻
        	   FileCommonManager fm = new FileCommonManager();
   				fm.transferDetailInit(conn, transferDataList);
           }
           return true;
       }
       
       
       /**
        * 根据移交单ID批量更新儿童材料全局状态
        * @param conn
        * @param TI_ID 交接单ID
        * @param status 全局状态
        * @param orgCode 材料位置
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
