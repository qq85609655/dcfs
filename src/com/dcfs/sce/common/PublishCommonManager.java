package com.dcfs.sce.common;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dcfs.sce.REQInfo.REQInfoHandler;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.util.UUID;


/**
 * 
 * @description ������������
 * @author MaYun
 * @date 2014-9-26
 * @return
 */
public class PublishCommonManager{
	private static Log log = UtilLog.getLog(PublishCommonManager.class);
	private PublishCommonManagerHandler handler = new PublishCommonManagerHandler();
	private REQInfoHandler reqHandler= new REQInfoHandler();
	private Connection conn = null;//���ݿ�����
	private DBTransaction dt = null;//������
	
	/**
	 * @description ���ɷ����ƻ���ˮ��(�������9λ���֣�����4λ���+5λ��ˮ��)
	 * @author MaYun
	 * @date 2014-9-26
	 * @return String pubPlanSeqNO �����ƻ���ˮ��
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createPubPlanSeqNO(Connection conn) throws SQLException, DBException{
		String pubPlanSeqNO="";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPubPlanSeqNo(conn, year);//�õ���ǰ�����ˮ
			String maxNoStr = (String)data.get("no");
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="0000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="000"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				maxNoStr="00"+maxNo;
			}else if(maxNo>999&&maxNo<10000){
				maxNoStr="0"+maxNo;
			}else {
				maxNoStr=""+maxNo;
			}
			pubPlanSeqNO=year+maxNoStr;//���ɷ����ƻ���ˮ��
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",pubPlanSeqNO);
			this.handler.saveMaxPubPlanSeqNo(conn, data2);//�򷢲��ƻ���ˮ�ű������ˮ�������Ϣ
		}
		return pubPlanSeqNO;
	}
	
	/**
	 * @Title: createPreApproveApplyNo 
	 * @Description: ����Ԥ��������
	 * @author: yangrt;
	 * @param conn
	 * @param orgCode ��֯code
	 * @return String 
	 * @throws SQLException
	 * @throws DBException
	 */
	public String createPreApproveApplyNo(Connection conn,String orgCode) throws SQLException, DBException{
		String ApplyNo = "";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPreApproveApplyNo(conn,year,orgCode);
			String maxNoStr = (String)data.get("NO");//�õ����5λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="0000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="000"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				maxNoStr="00"+maxNo;
			}else if(maxNo>999&&maxNo<10000){
				maxNoStr="0"+maxNo;
			}else if(maxNo>9999){
				maxNoStr=""+maxNo;
			}
			
			ApplyNo=year.substring(2,year.length())+orgCode+maxNoStr;//����Ԥ��������
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("ORG_CODE",orgCode);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",ApplyNo);
			this.handler.saveMaxPreApproveApplyNo(conn, data2);//�����ı�ű�������ı�������Ϣ
		}
		return ApplyNo;
	}
	
	//���ƥ�䣬�޸�Ԥ����Ϣ��
	public void Removeprebatch(Connection conn,String ciid){
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	//����Ԥ��ID����Ԥ����¼
	 	try {
	 		//����ci_id��Ԥ�����в���ri_id;
	 		Data ypdata = reqHandler.findYPByCiid(conn,ciid);
	 		String RI_ID = ypdata.getString("RI_ID");
	 		//��ȡԤ��Data
    		Data ypwjData = reqHandler.getRIData(conn, RI_ID);
    		String AF_ID = ypwjData.getString("AF_ID");
	    	if(AF_ID!=null){
	    		//��ȡ�ļ�data
	    		Data wjData = reqHandler.getAFData(conn,AF_ID);
	    		//�����ļ������ж�
	    		String FILE_TYPE = wjData.getString("FILE_TYPE");
	    		if(FILE_TYPE.equals("20")||FILE_TYPE.equals("22")){  //���պ��ؼ�
	    			
	    			wjData.add("RI_ID", null);   //Ԥ����¼Ϊnull
	    			wjData.add("RI_STATE", null);  //Ԥ��״̬null
	    			wjData.add("CI_ID", null);   //��ͯ����null
	    			
	    		}else if(FILE_TYPE.equals("21")){   //��ת
	    			
	    			wjData.add("RI_ID", null);   //Ԥ����¼Ϊnull
	    			wjData.add("RI_STATE", null);  //Ԥ��״̬null
	    			wjData.add("CI_ID", null);   //��ͯ����null
	    			wjData.add("FILE_TYPE", "10");  //�ļ����͸�Ϊ����
	    			
	    		}else if(FILE_TYPE.equals("23")){  //��˫
	    			
	    			wjData.add("FILE_TYPE", "20");   //�ļ����͸�Ϊ����
	    			String yp_id = wjData.getString("RI_ID");   //����Ԥ��ID
	    			String id1=yp_id.split(",")[0];
	    			String id2=yp_id.split(",")[1];
	    			if(RI_ID.equals(id1)){
	    				wjData.add("RI_ID",id2);   //Ԥ����¼����Ԥ��������ID
	    			}else if(RI_ID.equals(id2)){
	    				wjData.add("RI_ID",id1);   //Ԥ����¼����Ԥ��������ID
	    			}
	    			//����CI_ID�ж��Ƿ��Ƕ��̥��ͯ
	    			Data isTwinsData =  handler.getCIData(conn, ciid);
	    			String IS_TWINS = isTwinsData.getString("IS_TWINS");
	    			String[] et_id = wjData.getString("CI_ID").split(",");  //CI_ID
    				String str="";
	    			if(IS_TWINS.equals("1")){  //1��yes��ͬ��̥�ֵ�
	    				//��ȡ����ͬ����ͯ���
	    				String[] TWINS_IDS = isTwinsData.getString("TWINS_IDS").split(",");
	    				//����ͬ����ͯ�ı�ţ�����������ͯCI_ID��������Ϣ
	    				DataList twinsList = new DataList();
	    				for(int i=0;i<TWINS_IDS.length;i++){
	    					Data d = new Data();
	    					String CHILD_NO = TWINS_IDS[i];
	    					d=reqHandler.getCHILDNOData(conn, CHILD_NO);
	    					twinsList.add(d);
	    				}
	    				Data erData = new Data();
	    				erData.add("CI_ID",ciid);
	    				twinsList.add(erData);
	    				for(int i=0;i<et_id.length;i++){
	    					boolean flag = true;
	    					for(int j=0;j<twinsList.size();j++){
	    						String temp=twinsList.getData(j).getString("CI_ID");
	    						if(et_id[i].equals(temp)){
	    							flag = false;
	    							continue;
	    						}
	    					}
	    					if(flag){
	    						str+=et_id[i]+",";
	    					}
	    				}
	    			}else{
	    				for(int i=0;i<et_id.length;i++){
	    					if(!et_id[i].equals(ciid)){
	    						str+=et_id[i]+",";
	    					}
	    				}
	    			}
	    			str=str.substring(0, str.length()-1);
    				wjData.add("CI_ID", str);
	    		}
	    		//�����ļ���
	    		reqHandler.saveFfsData(conn, wjData);
	    	}
			Data RIData =handler.getRIData(conn, RI_ID);
			RIData.add("RI_ID",RI_ID );
			RIData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX); //Ԥ������״̬��Ϊ��Ч9
			String REVOKE_STATE = RIData.getString("REVOKE_STATE","");  //Ԥ������״̬
			if(REVOKE_STATE.equals("0")){
				RIData.add("REVOKE_TYPE", "0");//��������Ϊ"��֯����"
			}else{
				RIData.add("REVOKE_TYPE", "1");//��������Ϊ"���ĳ���"
			}
			RIData.add("REVOKE_CFM_USERID", personId);	//��������ȷ����id
			RIData.add("REVOKE_CFM_USERNAME", personName);	//��������ȷ��������
			RIData.add("REVOKE_CFM_DATE", curDate);	//��������ȷ������
			RIData.add("UNLOCKER_ID", personId);	//���������id
			RIData.add("UNLOCKER_NAME", personName);	//�������������
			RIData.add("UNLOCKER_DATE", curDate);	//�����������
			RIData.add("UNLOCKER_TYPE", "2");	//����������ͣ����Ľ����UNLOCKER_TYPE��0��
			//������¼��
			String PUB_ID = RIData.getString("PUB_ID");  //������¼ID
			Data PubData = handler.getPubData(conn,PUB_ID);
			//��ͯ���ϱ�
			String CI_ID = PubData.getString("CI_ID");
			Data CIData = handler.getCIData(conn,CI_ID);
			
			//��ȡ��������
			String SETTLE_DATE = PubData.getString("SETTLE_DATE");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
			Date curDate1 = sdf.parse(curDate);
			if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
				PubData.add("PUB_STATE","2");  //������¼������״̬��Ϊ�ѷ���
				CIData.add("PUB_STATE", "2");  //��ͯ���ϱ�����״̬��Ϊ�ѷ���
			}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
				PubData.add("PUB_STATE","9");  //������¼������״̬��Ϊ������
				CIData.add("PUB_STATE", "0");  //��ͯ���ϱ�����״̬��Ϊ������
			}
			RIData.add("PUB_ID", "");  //Ԥ�����еķ���IDΪ�ա�
			handler.savePubData(conn,PubData);  //������¼��
			handler.saveCIData(conn,CIData);  //��ͯ���ϱ�
			handler.saveRIData(conn,RIData);  //Ԥ����¼��
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * �ļ���˲�ͨ��������Ԥ��
	 * @param conn
	 * @param ciid
	 */
	public void RemoveByRIID(Connection conn,String RIIDS){
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	//����Ԥ��ID����Ԥ����¼
	 	String[] RI_IDS=RIIDS.split(",");
	 	String RI_ID="";
	 	try {
			for(int i=0;i<RI_IDS.length;i++){
				RI_ID=RI_IDS[i];
				//��ȡԤ��Data
				Data ypwjData = reqHandler.getRIData(conn, RI_ID);
				String AF_ID = ypwjData.getString("AF_ID");
				if(AF_ID!=null){
					//��ȡ�ļ�data
					Data wjData = reqHandler.getAFData(conn,AF_ID);
					//�����ļ������ж�
					wjData.add("RI_ID", null);   //Ԥ����¼Ϊnull
					wjData.add("RI_STATE", null);  //Ԥ��״̬null
					wjData.add("CI_ID", null);   //��ͯ����null
					reqHandler.saveFfsData(conn, wjData);
				}
				Data RIData =handler.getRIData(conn, RI_ID);
				RIData.add("RI_ID",RI_ID );
				RIData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX); //Ԥ������״̬��Ϊ��Ч9
				String REVOKE_STATE = RIData.getString("REVOKE_STATE","");  //Ԥ������״̬
				if(REVOKE_STATE.equals("0")){
					RIData.add("REVOKE_TYPE", "0");//��������Ϊ"��֯����"
				}else{
					RIData.add("REVOKE_TYPE", "1");//��������Ϊ"���ĳ���"
				}
				RIData.add("REVOKE_CFM_USERID", personId);	//��������ȷ����id
				RIData.add("REVOKE_CFM_USERNAME", personName);	//��������ȷ��������
				RIData.add("REVOKE_CFM_DATE", curDate);	//��������ȷ������
				RIData.add("UNLOCKER_ID", personId);	//���������id
				RIData.add("UNLOCKER_NAME", personName);	//�������������
				RIData.add("UNLOCKER_DATE", curDate);	//�����������
				RIData.add("UNLOCKER_TYPE", "2");	//����������ͣ����Ľ����UNLOCKER_TYPE��0��
				//������¼��
				String PUB_ID = RIData.getString("PUB_ID");  //������¼ID
				Data PubData = handler.getPubData(conn,PUB_ID);
				//��ͯ���ϱ�
				String CI_ID = PubData.getString("CI_ID");
				Data CIData = handler.getCIData(conn,CI_ID);
				
				//��ȡ��������
				String SETTLE_DATE = PubData.getString("SETTLE_DATE");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
				Date curDate1 = sdf.parse(curDate);
				if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
					PubData.add("PUB_STATE","2");  //������¼������״̬��Ϊ�ѷ���
					CIData.add("PUB_STATE", "2");  //��ͯ���ϱ�����״̬��Ϊ�ѷ���
				}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
					PubData.add("PUB_STATE","9");  //������¼������״̬��Ϊ������
					CIData.add("PUB_STATE", "0");  //��ͯ���ϱ�����״̬��Ϊ������
				}
				handler.savePubData(conn,PubData);  //������¼��
				handler.saveCIData(conn,CIData);  //��ͯ���ϱ�
				handler.saveRIData(conn,RIData);  //Ԥ����¼��
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * @Title: translationInit 
	 * @Description: ��ʼ��Ԥ�������¼
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * 			ri_id 				Ԥ��id
	 * 			TRANSLATION_TYPE	��������
	 * 			RA_ID				Ԥ��������ϢID
	 * 			AT_TYPE				Ԥ��������Դ
	 * @throws DBException
	 * @throws SQLException
	 * @return void
	 */
	public void translationInit(Connection conn, Data data) throws DBException {
		UserInfo userinfo = SessionInfo.getCurUser();
		String userid = userinfo.getPersonId();
		String username = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		data.add("TRANSLATION_STATE", "0"); 	//����״̬��������=0
		data.add("NOTICE_USERID", userid);
		data.add("NOTICE_USERNAME", username);
		data.add("NOTICE_DATE", curDate);
		data.setConnection(conn);
		data.setEntityName("SCE_REQ_TRANSLATION");
		data.setPrimaryKey("AT_ID");
		data.create();
	}
	
	/**
	 * @Title: approveAuditInit 
	 * @Description: ��ʼ��Ԥ����˼�¼
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id	Ԥ�������¼id
	 * @throws DBException    �趨�ļ� 
	 * @return void    �������� 
	 * @throws
	 */
	public void approveAuditInit(Connection conn, String ri_id) throws DBException {
		//��ʼ�����ò�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:2)
		Data azbdata = new Data();
		azbdata.add("RI_ID", ri_id);
		azbdata.add("AUDIT_TYPE", "2");
		azbdata.add("OPERATION_STATE", "0");	//������
		azbdata.setConnection(conn);
        azbdata.setEntityName("SCE_REQ_ADUIT");
        azbdata.setPrimaryKey("RAU_ID");
        azbdata.create();
		
		//��ʼ����˲�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:1)
		Data shbdata = new Data();
		shbdata.add("RI_ID", ri_id);
		shbdata.add("AUDIT_TYPE", "1");
		shbdata.add("AUDIT_LEVEL", "0");		//���������
		shbdata.add("OPERATION_STATE", "0");	//������
		shbdata.setConnection(conn);
		shbdata.setEntityName("SCE_REQ_ADUIT");
		shbdata.setPrimaryKey("RAU_ID");
		shbdata.create();
	}
	
	public static void main(String[] args){
		/*String year = DateUtility.getCurrentYear();
		String month = DateUtility.getCurrentMonth();
		String day = DateUtility.getCurrentDay();
		int dayInt = Integer.parseInt(day);
		if(0<dayInt&&dayInt<10){
			day="0"+day;
		}
		System.out.println(year+month+day);*/
		
		for(int i=0;i<10;i++){
			System.out.println(UUID.getUUID());
		}

		
	}

}
