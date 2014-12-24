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
     * 保存交接单方法,返回创建交接单主键
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
     * 保存\提交 方法 用TRANSFER_STATE确定操作类型是保存或提交
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
     * 批量更新交接单表方法
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
     * 删除保存状态（拟移交）的交接单
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
     * 删除交接单后更新交接明细表数据
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
    	sql.append("UPDATE TRANSFER_INFO_DETAIL SET TRANSFER_STATE='0'，TI_ID = '' WHERE ");
    	sql.append(" TI_ID = '"+TI_ID+"' ");
    	sql.append("AND TRANSFER_CODE='"+TRANSFER_CODE+"' ");
    	sql.append("AND TRANSFER_STATE = '1' ");
    	return ide.execute(sql.toString());
    }
    /**
     * 批量更新交接明细表
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
     * 查询交接单表
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
		//查询条件
		String CONNECT_NO = data.getString("CONNECT_NO", null);//交接单编号
		String COPIES = data.getString("COPIES", null);//份数
		String TRANSFER_USERNAME = data.getString("TRANSFER_USERNAME", null);//移交人
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//移交日期开始
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//移交日期截止
		String RECEIVER_USERNAME = data.getString("RECEIVER_USERNAME", null);//接收人
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//接收时间开始
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//接收时间截止
		String AT_STATE = data.getString("AT_STATE", null);//移交状态
		String OPER_TYPE =data.getString("OPER_TYPE",null);    //操作类型
		String TRANSFER_CODE =data.getString("TRANSFER_CODE",null);    //业务环节（交接代码）
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferList",CONNECT_NO,COPIES,TRANSFER_USERNAME,TRANSFER_DATE_START,TRANSFER_DATE_END,RECEIVER_USERNAME,RECEIVER_DATE_START,RECEIVER_DATE_END,AT_STATE,compositor,ordertype,TRANSFER_CODE,OPER_TYPE);
        System.out.println(sql);
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
     * 删除
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
     * 初始化交接详细表（TRANSFER_INFO_DETAIL）方法 
     * Data 封装内容  如下：
     * 1、APP_ID 业务实体的uuid 
     * 2、TRANSFER_CODE 交接类型代码 具体内容参见 com.dcfs.common.transfercode.transfercode.java
     * 3、TRANSFER_STATE 移交状态 设置为“0”
     * @param conn
     * @param dl
     * @return
     */
    public boolean TransferDetailInit(Connection conn, DataList dl) throws DBException {
    	 //***保存数据*****
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        for(int i=0;i<dl.size();i++){
        	      	
        	dl.getData(i).setEntityName("TRANSFER_INFO");
        	dl.getData(i).setPrimaryKey("TID_ID");
        	
        }
        ide.batchCreate(dl);
        
        return true;
    }
    /**
     * 查询手工添加文件交接 单列表
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
    	
		//查询条件
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//国家Code
    	String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//收文组织Code
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//收文日期起始
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//收文日期截止
		String FILE_NO = data.getString("FILE_NO", null);//文件编号
		String FILE_TYPE = data.getString("FILE_TYPE", null);//文件类型
		String MALE_NAME = data.getString("MALE_NAME", null);//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//女收养人姓名
		String TRANSFER_CODE = data.getString("TRANSFER_CODE", null);//业务环节
		String HANDLE_TYPE = data.getString("HANDLE_TYPE",null); //退文处理方式
		String RETURN_STATE = null;
		String sql="";
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//如果业务代码以“5”开始，则是退文业务，则设置可查询的退文记录状态为“1：以确认”
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
     * 获取指定交接单ID的交接明细列表
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
        //拼写sql语句 按照不同的业务流程差异变更连接表与条件
        //当transfer_code为“13”时需要连接儿童材料表 查询特需儿童姓名
        //当transfer_code为“5*”是需要连接退文信息表查询退文原因与处置方式
        sql.append("SELECT TID_ID,COUNTRY_CN,NAME_CN,FAI.REGISTER_DATE AS REGISTER_DATE,FAI.FILE_NO AS FILE_NO,FAI.FILE_TYPE AS FILE_TYPE,FAI.MALE_NAME AS MALE_NAME,FAI.FEMALE_NAME AS FEMALE_NAME");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
        	//当业务编码为13事查询特需儿童姓名
        	sql.append(",CI.NAME AS NAME ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
        	//当业务编码为5*时查询退文原因
        	sql.append(",RA.RETURN_REASON AS RETURN_REASON,RA.HANDLE_TYPE AS HANDLE_TYPE,RA.APPLE_TYPE as APPLE_TYPE,RA.RETREAT_DATE as RETREAT_DATE");
        }
        sql.append(" FROM TRANSFER_INFO_DETAIL TID LEFT JOIN FFS_AF_INFO FAI ON TID.APP_ID = FAI.AF_ID ");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
        	//当业务编码为13时连接儿童材料信息表
        	sql.append(" LEFT JOIN CMS_CI_INFO CI ON FAI.CI_ID = CI.CI_ID ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
        	//当业务编码为5*时连接退文表
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
     * @date: 2014-12-9下午12:01:15
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
        //拼写sql语句 按照不同的业务流程差异变更连接表与条件
        //当transfer_code为“13”时需要连接儿童材料表 查询特需儿童姓名
        //当transfer_code为“5*”是需要连接退文信息表查询退文原因与处置方式
        sql.append("SELECT TID_ID,COUNTRY_CN,NAME_CN,FAI.REGISTER_DATE AS REGISTER_DATE,FAI.FILE_NO AS FILE_NO,FAI.FILE_TYPE AS FILE_TYPE,FAI.MALE_NAME AS MALE_NAME,FAI.FEMALE_NAME AS FEMALE_NAME");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
            //当业务编码为13事查询特需儿童姓名
            sql.append(",CI.NAME AS NAME ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
            //当业务编码为5*时查询退文原因
            sql.append(",RA.RETURN_REASON AS RETURN_REASON,RA.HANDLE_TYPE AS HANDLE_TYPE,RA.APPLE_TYPE as APPLE_TYPE ");
        }
        sql.append(" FROM TRANSFER_INFO_DETAIL TID LEFT JOIN FFS_AF_INFO FAI ON TID.APP_ID = FAI.AF_ID ");
        if(transfer_code!=null&&TransferCode.FILE_SHB_DAB.equals(transfer_code)){
            //当业务编码为13时连接儿童材料信息表
            sql.append(" LEFT JOIN CMS_CI_INFO CI ON FAI.CI_ID = CI.CI_ID ");
        }else if(transfer_code!=null&&TransferCode.RFM_FILE_DAB.equals(transfer_code.substring(0,1))){
            //当业务编码为5*时连接退文表
            sql.append(" LEFT JOIN RFM_AF_REVOCATION RA ON TID.APP_ID = RA.AF_ID ");
        }
        sql.append("WHERE  TID_ID='"+TID_ID+"' ");
        
        DataList dl = ide.find(sql.toString());
        return dl;
    }
    /**
     * 获取指定交接单ID的材料交接明细列表
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
     * @date: 2014-12-9上午11:55:58
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
     * 安置部到档案部的材料需要取得匹配信息
     * @Title: TransferEditDetailChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午4:54:53
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
     * @date: 2014-12-9上午11:57:25
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
     * 获取指定交接单ID的票据交接明细列表
     * @Title: TransferEditDetailChequeinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-24上午11:25:06
     * @param conn
     * @param TI_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailChequeinfoList(Connection conn, String TI_ID,String transfer_code)
            throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailChequeinfoList", TI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 获取指定交接单ID的安置后报告交接明细列表
     * @Title: TransferEditDetailArchiveinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18上午11:29:52
     * @param conn
     * @param TI_ID
     * @param transfer_code
     * @return
     * @throws DBException
     */
    public DataList TransferEditDetailArchiveinfoList(Connection conn, String TI_ID,String transfer_code)
            throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("TransferEditDetailArchiveinfoList", TI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    
    /**
     * 获取指定交接单ID的票据交接明细列表
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
     * @date: 2014-12-9上午11:15:01
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
     * 获取指定交接单ID的安置后报告交接明细列表
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
     * @Description: 获取指定交接明细ID的安置后报告交接明细列表
     * @author: xugy
     * @date: 2014-12-8下午5:09:49
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
     * 通过主键获取交接单（TRANSFER_INFO）表信息
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
     * 交接点修改移除更新数据方法
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
     * **************************************以下为接受环节方法**********************************************
     */
    /**
     * 查询交接单表-接收
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
		//查询条件
		String CONNECT_NO = data.getString("CONNECT_NO", null);//交接单编号
		String COPIES = data.getString("COPIES", null);//份数
		String TRANSFER_USERNAME = data.getString("TRANSFER_USERNAME", null);//移交人
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//移交日期开始
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//移交日期截止
		String RECEIVER_USERNAME = data.getString("RECEIVER_USERNAME", null);//接收人
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//接收时间开始
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//接收时间截止
		String AT_STATE = data.getString("AT_STATE", null);//移交状态
		

		//String OPER_TYPE =data.getString("OPER_TYPE",null);    //操作类型
		String OPER_TYPE = "1";//操作类型为接收
		String TRANSFER_CODE =data.getString("TRANSFER_CODE",null);    //业务环节（交接代码）
		boolean flag = false;
		//如果是档案的退文处置接收则处理所有业务处室到档案部的退文
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
     * 接收文件确认方法
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
	 * 接收文件确认方法-更新交接文件详细
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
	 * 查询交接单详细表信息
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
	 * 查询交接单详细表信息
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
     * 接收文件退回方法
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
    	data.add("AT_STATE", "0"); //状态设置成拟移交
    	data.add("OPER_TYPE", "1"); //操作类型设置为移交
    	Data resda= ide.store(data);
    	return resda;
		
	}
	/**
	 * 接收文件退回方法-更新交接文件详细
	 * @param conn
	 * @param TI_ID
	 * @return
	 */
	public boolean ReceiveReturnDetail(Connection conn, String TI_ID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	StringBuffer sql = new StringBuffer();
    	sql.append("UPDATE TRANSFER_INFO_DETAIL T SET T.TRANSFER_STATE = '1' "); //状态设置成拟移交
    	sql.append("WHERE T.TI_ID ='"+TI_ID+"' ");
    	return ide.execute(sql.toString());
		
	}
	/**
	 * 详细查询方法
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
		//查询条件
		String TRANSFER_CODE = data.getString("TRANSFER_CODE", null);//业务节点代码
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//国家代码
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//收养机构代码
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//收文起始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//收文结束日期
		String MALE_NAME = data.getString("MALE_NAME", null);//男收养人
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//女收养人
		String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);//移交起始日期
		String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);//移交截止日期
		String FILE_NO = data.getString("FILE_NO", null);//文件编号
		String CONNECT_NO = data.getString("CONNECT_NO", null);//交接单编号RECEIVER_DATE
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);//接收起始日期
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);//接收结束日期
		String FILE_TYPE = data.getString("FILE_TYPE", null);//文件类型
		String TRANSFER_STATE = data.getString("TRANSFER_STATE", null);//文件类型
		String OPER_TYPE=data.getString("OPER_TYPE", null);//操作类型
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
	 * 详细查询方法——材料
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 */
	public DataList FindChildinfoDetailList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype)  throws DBException {
		String OPER_TYPE=data.getString("OPER_TYPE", TransferConstant.OPER_TYPE_SEND);//操作类型
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
		
		if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //儿童材料编号
			sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
		}
		if(data.getString("PROVINCE_ID")!=null&&!"".equals(data.getString("PROVINCE_ID"))){ //省份ID
			sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
		}
		if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //福利院ID
			sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
			sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //性别
			sql.append("AND SEX = '"+data.getString("SEX")+"' ");
		}
		if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //儿童生日开始
			sql.append("AND BIRTHDAY >= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //儿童生日结束
			sql.append("AND BIRTHDAY <= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //儿童类别
			sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
		}
		if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //特别关注
			sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
		}
		if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //交接单编号
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
		if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //交接状态
			sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
		}else{
			 if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){
				sql.append("AND TRANSFER_STATE IN ('2','3')");
			 }
		}
		if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //移交日期开始
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //移交日期结束
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //接收日期开始
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //接收日期结束
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
		
		if(compositor!=null&&!"".equals(compositor)){ //排序字段
			sql.append(" ORDER BY  ");
			sql.append(compositor);
		}
		if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
			sql.append(" ");
			sql.append(ordertype);
		}
		System.out.println(sql);
		ide = DataBaseFactory.getDataBase(conn);
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
	}
	/**
	 * 详细查询方法——材料（匹配）
	 * @Title: FindChildMatchinfoDetailList
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-11-26下午6:48:36
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
        String OPER_TYPE=data.getString("OPER_TYPE", TransferConstant.OPER_TYPE_SEND);//操作类型
        StringBuffer sql =new StringBuffer();        
        sql.append("SELECT TID_ID,CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,SPECIAL_FOCUS,CONNECT_NO,TRANSFER_DATE,TI.RECEIVER_DATE AS RECEIVER_DATE,TD.TRANSFER_STATE AS TRANSFER_STATE," + 
                "COUNTRY_CODE,COUNTRY_CN,ADOPT_ORG_ID,NAME_CN,FILE_NO,FILE_TYPE "+
                "FROM TRANSFER_INFO_DETAIL TD RIGHT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID JOIN TRANSFER_INFO TI ON TD.TI_ID=TI.TI_ID "+
                "LEFT JOIN (SELECT AF_ID,CI_ID FROM NCM_MATCH_INFO WHERE  MATCH_STATE <> '4' AND MATCH_STATE <> '9' ) A ON A.CI_ID=TD.APP_ID "+
                "LEFT JOIN FFS_AF_INFO AF ON AF.AF_ID=A.AF_ID "+
                "WHERE 1=1 AND TD.TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' ");
        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家
            sql.append("AND COUNTRY_CODE='"+data.getString("COUNTRY_CODE")+"' ");
        }
        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织
            sql.append("AND ADOPT_ORG_ID='"+data.getString("ADOPT_ORG_ID")+"' ");
        }
        if(data.getString("FILE_NO")!=null&&!"".equals(data.getString("FILE_NO"))){ //文件编号
            sql.append("AND FILE_NO LIKE '%"+data.getString("FILE_NO")+"%' ");
        }
        if(data.getString("FILE_TYPE")!=null&&!"".equals(data.getString("FILE_TYPE"))){ //文件类型
            sql.append("AND FILE_TYPE='"+data.getString("FILE_TYPE")+"' ");
        }
        if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //儿童材料编号
            sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
        }
        if(data.getString("PROVINCE_ID")!=null&&!"".equals(data.getString("PROVINCE_ID"))){ //省份ID
            sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
        }
        if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //福利院ID
            sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
        }
        if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
            sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
        }
        if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //性别
            sql.append("AND SEX = '"+data.getString("SEX")+"' ");
        }
        if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //儿童生日开始
            sql.append("AND BIRTHDAY >= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //儿童生日结束
            sql.append("AND BIRTHDAY <= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
        }
        if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //儿童类别
            sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
        }
        if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //特别关注
            sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
        }
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //交接单编号
            sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
        }
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //交接状态
            sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
        }else{
             if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){
                sql.append("AND TRANSFER_STATE IN ('2','3')");
             }
        }
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //移交日期开始
            sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //移交日期结束
            sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
        }
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //接收日期开始
            sql.append("AND TI.RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
        }
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //接收日期结束
            sql.append("AND TI.RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
        }
        
        if(compositor!=null&&!"".equals(compositor)){ //排序字段
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
            sql.append(" ");
            sql.append(ordertype);
        }
        System.out.println(sql);
        ide = DataBaseFactory.getDataBase(conn);
        DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
    }
	
	/**
	 * 详细查询方法——票据
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
		
        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家
			sql.append("AND F.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
		}
        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织
			sql.append("AND F.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
		}
        if(data.getString("PAID_WAY")!=null&&!"".equals(data.getString("PAID_WAY"))){ //缴费方式
            sql.append("AND F.PAID_WAY = '"+data.getString("PAID_WAY")+"' ");
        }
        if(data.getString("PAID_NO")!=null&&!"".equals(data.getString("PAID_NO"))){ //缴费编号
			sql.append("AND F.PAID_NO LIKE '%"+data.getString("PAID_NO")+"%' ");
		}
        if(data.getString("BILL_NO")!=null&&!"".equals(data.getString("BILL_NO"))){ //票号
			sql.append("AND F.BILL_NO LIKE '%"+data.getString("BILL_NO")+"%' ");
		}
        if(data.getString("PAR_VALUE_START")!=null&&!"".equals(data.getString("PAR_VALUE_START"))){ //票面金额起始值
			sql.append("AND F.PAR_VALUE >= "+data.getString("PAR_VALUE_START")+" ");
		}
        if(data.getString("PAR_VALUE_END")!=null&&!"".equals(data.getString("PAR_VALUE_END"))){ //票面金额截止值
			sql.append("AND F.PAR_VALUE <= "+data.getString("PAR_VALUE_END")+" ");
		}
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //移交单编号
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //移交日期起始值
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //移交日期截止值
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //接收日期起始值
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //移交日期截止值
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
        String OPER_TYPE=data.getString("OPER_TYPE");//操作类型
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //移交状态
            sql.append("AND TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
        }else{
            if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){//接收
                sql.append("AND TRANSFER_STATE IN ('2','3') ");
            }
            if(TransferConstant.OPER_TYPE_SEND.equals(OPER_TYPE)){//移交
                sql.append("AND TRANSFER_STATE IN ('0','1','2','3') ");
            }
        }
        
        if(compositor!=null&&!"".equals(compositor)){ //排序字段
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }else{
            sql.append(" ORDER BY TRANSFER_DATE ");
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
            sql.append(" ");
            sql.append(ordertype);
        }
		System.out.println(sql);	
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
		
	}
	/**
	 * 详细查询方法——安置后报告
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
		
		if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家代码
			sql.append("AND NI.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
		}
		if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织代码代码
			sql.append("AND NI.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
		}
		if(data.getString("ARCHIVE_NO")!=null&&!"".equals(data.getString("ARCHIVE_NO"))){ //档案号
			sql.append("AND NI.ARCHIVE_NO LIKE '%"+data.getString("ARCHIVE_NO")+"%' ");
		}
		if(data.getString("MALE_NAME")!=null&&!"".equals(data.getString("MALE_NAME"))){ //男收养人姓名
			sql.append("AND NI.MALE_NAME LIKE '%"+data.getString("MALE_NAME")+"%' ");
		}
		if(data.getString("FEMALE_NAME")!=null&&!"".equals(data.getString("FEMALE_NAME"))){ //女收养人姓名
			sql.append("AND NI.FEMALE_NAME LIKE '%"+data.getString("FEMALE_NAME")+"%' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
			sql.append("AND NI.NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SIGN_DATE_START")!=null&&!"".equals(data.getString("SIGN_DATE_START"))){ //签批日开始
			sql.append("AND SIGN_DATE >= to_date('"+data.getString("SIGN_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("SIGN_DATE_END")!=null&&!"".equals(data.getString("SIGN_DATE_END"))){ //签批日期结束
			sql.append("AND SIGN_DATE <= to_date('"+data.getString("SIGN_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("REPORT_DATE_START")!=null&&!"".equals(data.getString("REPORT_DATE_START"))){ //报告接收日开始
			sql.append("AND REPORT_DATE >= to_date('"+data.getString("REPORT_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("REPORT_DATE_END")!=null&&!"".equals(data.getString("REPORT_DATE_END"))){ //报告接收日期结束
			sql.append("AND REPORT_DATE <= to_date('"+data.getString("REPORT_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("NUM")!=null&&!"".equals(data.getString("NUM"))){ //次数
			sql.append("AND NUM = '"+data.getString("NUM")+"' ");
		}
        if(data.getString("CONNECT_NO")!=null&&!"".equals(data.getString("CONNECT_NO"))){ //移交单编号
			sql.append("AND CONNECT_NO LIKE '%"+data.getString("CONNECT_NO")+"%' ");
		}
        if(data.getString("TRANSFER_DATE_START")!=null&&!"".equals(data.getString("TRANSFER_DATE_START"))){ //移交日期起始值
			sql.append("AND TRANSFER_DATE >= to_date('"+data.getString("TRANSFER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("TRANSFER_DATE_END")!=null&&!"".equals(data.getString("TRANSFER_DATE_END"))){ //移交日期截止值
			sql.append("AND TRANSFER_DATE <= to_date('"+data.getString("TRANSFER_DATE_END")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_START")!=null&&!"".equals(data.getString("RECEIVER_DATE_START"))){ //接收日期起始值
			sql.append("AND RECEIVER_DATE >= to_date('"+data.getString("RECEIVER_DATE_START")+"','yyyy-MM-DD') ");
		}
        if(data.getString("RECEIVER_DATE_END")!=null&&!"".equals(data.getString("RECEIVER_DATE_END"))){ //接收日期截止值
			sql.append("AND RECEIVER_DATE <= to_date('"+data.getString("RECEIVER_DATE_END")+"','yyyy-MM-DD') ");
		}
        String OPER_TYPE=data.getString("OPER_TYPE");//操作类型
        if(data.getString("TRANSFER_STATE")!=null&&!"".equals(data.getString("TRANSFER_STATE"))){ //移交状态
			sql.append("AND TD.TRANSFER_STATE = '"+data.getString("TRANSFER_STATE")+"' ");
		}else{
		    if(TransferConstant.OPER_TYPE_RECEIVE.equals(OPER_TYPE)){//接收
		        sql.append("AND TD.TRANSFER_STATE IN ('2','3') ");
		    }
		    if(TransferConstant.OPER_TYPE_SEND.equals(OPER_TYPE)){//移交
		        sql.append("AND TD.TRANSFER_STATE IN ('0','1','2','3') ");
		    }
		}
        if(data.getString("TRANSFER_CODE")!=null&&!"".equals(data.getString("TRANSFER_CODE"))){ //移交状态
            sql.append("AND TD.TRANSFER_CODE = '"+data.getString("TRANSFER_CODE")+"' ");
        }
        if(compositor!=null&&!"".equals(compositor)){ //排序字段
            sql.append(" ORDER BY  ");
            sql.append(compositor);
        }else{
            sql.append(" ORDER BY TRANSFER_DATE ");
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
            sql.append(" ");
            sql.append(ordertype);
        }
		System.out.println(sql);	
		DataList dl = ide.find(sql.toString(), pageSize, page);
        return dl;
		
	}
	/**
     * 查询手工添加材料交接单列表
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
		sql.append("SELECT TID_ID," +	//移交记录ID
				"CHILD_NO," +				//儿童编号
				"PROVINCE_ID," +			//省份ID
				"WELFARE_NAME_CN," +//福利院名称
				"NAME,SEX," +					//儿童性别
				"BIRTHDAY," +					//出生日期
				"CHILD_TYPE," +				//儿童类别
				"SPECIAL_FOCUS "+		//是否特别关注
				"FROM TRANSFER_INFO_DETAIL TD LEFT JOIN CMS_CI_INFO CI ON TD.APP_ID = CI.CI_ID  " +
				"WHERE TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' "+
				"AND TRANSFER_STATE = '" + TransferConstant.TRANSFER_STATE_TODO  +"'");//未移交状态				
		
		
		if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //儿童材料编号
			sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
		}
		if(data.getString("PROVINCE_ID")!=null && !"".equals(data.getString("PROVINCE_ID"))){ //省份ID
			sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
		}
		if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //福利院ID
			sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
			sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //性别
			sql.append("AND SEX = '"+data.getString("SEX")+"' ");
		}
		if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //儿童生日开始
			sql.append("AND BIRTHDAY>= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //儿童生日结束
			sql.append("AND BIRTHDAY<= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //儿童类别
			sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
		}
		if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //特别关注
			sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
		}
		if(compositor!=null&&!"".equals(compositor)){ //排序字段
			sql.append(" ORDER BY  ");
			sql.append(compositor);
		}
		if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
			sql.append(" ");
			sql.append(ordertype);
		}
		
		System.out.println(sql);
        DataList dl = ide.find(sql.toString(), pageSize, page);
		return dl;
	}
	 /**
	  * 查询手工添加材料交接单列表（带匹配信息）
	  * @Title: TransferMannualChildMatchinfoList
	  * @Description: 
	  * @author: xugy
	  * @date: 2014-11-26下午5:22:28
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
	                "AND TRANSFER_STATE = '" + TransferConstant.TRANSFER_STATE_TODO  +"'");//未移交状态              
	        
	        if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家
                sql.append("AND COUNTRY_CODE='"+data.getString("COUNTRY_CODE")+"' ");
            }
	        if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织
                sql.append("AND ADOPT_ORG_ID='"+data.getString("ADOPT_ORG_ID")+"' ");
            }
	        if(data.getString("FILE_NO")!=null&&!"".equals(data.getString("FILE_NO"))){ //文件编号
                sql.append("AND FILE_NO LIKE '%"+data.getString("FILE_NO")+"%' ");
            }
	        if(data.getString("FILE_TYPE")!=null&&!"".equals(data.getString("FILE_TYPE"))){ //文件类型
                sql.append("AND FILE_TYPE='"+data.getString("FILE_TYPE")+"' ");
            }
	        if(data.getString("CHILD_NO")!=null&&!"".equals(data.getString("CHILD_NO"))){ //儿童材料编号
	            sql.append("AND CHILD_NO LIKE '%"+data.getString("CHILD_NO")+"%' ");
	        }
	        if(data.getString("PROVINCE_ID")!=null && !"".equals(data.getString("PROVINCE_ID"))){ //省份ID
	            sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
	        }
	        if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //福利院ID
	            sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
	        }
	        if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
	            sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
	        }
	        if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //性别
	            sql.append("AND SEX = '"+data.getString("SEX")+"' ");
	        }
	        if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //儿童生日开始
	            sql.append("AND BIRTHDAY>= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
	        }
	        if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //儿童生日结束
	            sql.append("AND BIRTHDAY<= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
	        }
	        if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //儿童类别
	            sql.append("AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
	        }
	        if(data.getString("SPECIAL_FOCUS")!=null&&!"".equals(data.getString("SPECIAL_FOCUS"))){ //特别关注
	            sql.append("AND SPECIAL_FOCUS = '"+data.getString("SPECIAL_FOCUS")+"' ");
	        }
	        if(compositor!=null&&!"".equals(compositor)){ //排序字段
	            sql.append(" ORDER BY  ");
	            sql.append(compositor);
	        }
	        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
	            sql.append(" ");
	            sql.append(ordertype);
	        }
	        
	        System.out.println(sql);
	        DataList dl = ide.find(sql.toString(), pageSize, page);
	        return dl;
	    }
	 
	 
		/**
	     * 查询添加票据交接单列表
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
			sql.append("AND TRANSFER_STATE = '0' "); //未移交状态
			if(data.getString("PAID_NO")!=null&&!"".equals(data.getString("PAID_NO"))){ //票据id
				sql.append("AND PAID_NO LIKE '%"+data.getString("PAID_NO")+"%' ");
			}
			if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家代码
				sql.append("AND COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
			}
			if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织代码代码
				sql.append("AND ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
			}
			if(data.getString("PAID_WAY")!=null&&!"".equals(data.getString("PAID_WAY"))){ //缴费方式
			    sql.append("AND PAID_WAY = '"+data.getString("PAID_WAY")+"' ");
			}
			if(data.getString("BILL_NO")!=null&&!"".equals(data.getString("BILL_NO"))){ //缴费编号
				sql.append("AND BILL_NO LIKE '%"+data.getString("BILL_NO")+"%' ");
			}
			if(data.getString("PAR_VALUE")!=null&&!"".equals(data.getString("PAR_VALUE"))){ //票面金额
				sql.append("AND PAR_VALUE = '"+data.getString("PAR_VALUE")+"' ");
			}
			if(data.getString("TRANSFER_CODE")!=null&&!"".equals(data.getString("TRANSFER_CODE"))){ //票面金额
                sql.append("AND TRANSFER_CODE = '"+data.getString("TRANSFER_CODE")+"' ");
            }
			if(compositor!=null&&!"".equals(compositor)){ //排序字段
	            sql.append(" ORDER BY  ");
	            sql.append(compositor);
	        }
	        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
	            sql.append(" ");
	            sql.append(ordertype);
	        }
			System.out.println(sql);
	        DataList dl = ide.find(sql.toString(), pageSize, page);
			return dl;
		}
		 /**
		     * 查询添加安置后报告交接单列表
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
				//四表连接，移交详细表（TRANSFER_INFO_DETAIL）、安置后报告记录表（PFR_FEEDBACK_RECORD）、安置后报告信息表（PFR_FEEDBACK_INFO）、涉外收养档案信息表（NCM_ARCHIVE_INFO）
				sql.append("SELECT TD.TID_ID AS TID_ID, NI.COUNTRY_CODE AS COUNTRY_CODE,NI.NAME_CN AS NAME_CN,NI.ARCHIVE_NO AS ARCHIVE_NO ,MALE_NAME,FEMALE_NAME,NAME,SIGN_DATE,REPORT_DATE,NUM ");
				sql.append("FROM TRANSFER_INFO_DETAIL TD JOIN PFR_FEEDBACK_RECORD PR ON TD.APP_ID = PR.FB_REC_ID ");
				sql.append(" JOIN  PFR_FEEDBACK_INFO PI ON PR.FEEDBACK_ID=PI.FEEDBACK_ID ");
				sql.append(" JOIN  NCM_ARCHIVE_INFO NI ON PI.ARCHIVE_ID = NI.ARCHIVE_ID ");
				sql.append("WHERE 1 = 1 ");
				sql.append("AND TRANSFER_CODE ='"+data.getString("TRANSFER_CODE")+"' ");//确定移交业务
				sql.append("AND TRANSFER_STATE = '0' "); //未移交状态
				if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家代码
					sql.append("AND NI.COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
				}
				if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织代码代码
					sql.append("AND NI.ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
				}
				if(data.getString("ARCHIVE_NO")!=null&&!"".equals(data.getString("ARCHIVE_NO"))){ //档案号
					sql.append("AND NI.ARCHIVE_NO LIKE '%"+data.getString("ARCHIVE_NO")+"%' ");
				}
				if(data.getString("MALE_NAME")!=null&&!"".equals(data.getString("MALE_NAME"))){ //男收养人姓名
					sql.append("AND NI.MALE_NAME LIKE '%"+data.getString("MALE_NAME")+"%' ");
				}
				if(data.getString("FEMALE_NAME")!=null&&!"".equals(data.getString("FEMALE_NAME"))){ //女收养人姓名
					sql.append("AND NI.FEMALE_NAME LIKE '%"+data.getString("FEMALE_NAME")+"%' ");
				}
				if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
					sql.append("AND NI.NAME LIKE '%"+data.getString("NAME")+"%' ");
				}
				if(data.getString("SIGN_DATE_STRART")!=null&&!"".equals(data.getString("SIGN_DATE_STRART"))){ //签批日开始
					sql.append("AND SIGN_DATE>= to_date('"+data.getString("SIGN_DATE_STRART")+"','yyyy-MM-DD') ");
				}
				if(data.getString("SIGN_DATE_END")!=null&&!"".equals(data.getString("SIGN_DATE_END"))){ //签批日期结束
					sql.append("AND SIGN_DATE<= to_date('"+data.getString("SIGN_DATE_END")+"','yyyy-MM-DD') ");
				}
				if(data.getString("REPORT_DATE_STRART")!=null&&!"".equals(data.getString("REPORT_DATE_STRART"))){ //报告接收日开始
					sql.append("AND REPORT_DATE>= to_date('"+data.getString("REPORT_DATE_STRART")+"','yyyy-MM-DD') ");
				}
				if(data.getString("REPORT_DATE_END")!=null&&!"".equals(data.getString("REPORT_DATE_END"))){ //报告接收日期结束
					sql.append("AND REPORT_DATE<= to_date('"+data.getString("REPORT_DATE_END")+"','yyyy-MM-DD') ");
				}
				if(data.getString("NUM")!=null&&!"".equals(data.getString("NUM"))){ //次数
					sql.append("AND NUM = '"+data.getString("NUM")+"' ");
				}
				if(compositor!=null&&!"".equals(compositor)){ //排序字段
	                sql.append(" ORDER BY  ");
	                sql.append(compositor);
	            }
	            if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
	                sql.append(" ");
	                sql.append(ordertype);
	            }
				System.out.println(sql);
		        DataList dl = ide.find(sql.toString(), pageSize, page);
				return dl;
			}
		/**
		 * 判断文件是否关联了特需儿童，文件关联了特需儿童返回true，未关联返回false
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
		 * @Description: TODO(这里用一句话描述这个方法的作用)
		 * @author: yangrt;
		 * @param conn
		 * @param pjData    设定文件 
		 * @return void    返回类型 
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
		 * 根据交接明细ID获得对应收养文件的暂停标志
	     * @param conn
	     * @param String TID_ID 交接明细ID
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
	     * @Description: 保存交接单信息
	     * @author: xugy
	     * @date: 2014-11-21下午6:24:23
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
	     * @Description: 保存交接明细
	     * @author: xugy
	     * @date: 2014-11-24上午10:24:05
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
	     * @date: 2014-12-8下午7:24:50
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
