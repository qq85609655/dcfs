package com.dcfs.fam.billRegistration;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import hx.ajax.AjaxExecute;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.log.Log;
import hx.log.UtilLog;

public class BillRegistrationAjax extends AjaxExecute {

	private static Log log = UtilLog.getLog(BillRegistrationAjax.class);
	public boolean run(HttpServletRequest request) {
		//��ȡҳ��ѡ����ļ��б�    	
    	String choiceuuid = request.getParameter("uuid");
		String[] uuid = choiceuuid.split("#");
		//��ȡҳ���ѯ�����ļ��б�DataList		
		HttpSession session =request.getSession();
		DataList dList=(DataList)session.getAttribute("newFileList");
		
		//�Ա�ҳ���ѯ�������ѡ����������ȡ�û�ѡ��ѡ����ļ�
		//���list
		DataList resList=(DataList)session.getAttribute("fileList");
		if(resList==null){
			resList=new DataList();
		}
		DataList addlist=new DataList();
		
		//��ȡҳ��ѡ�������
		for(int i=0;i<uuid.length;i++){
			for(int j=0;j<dList.size();j++){
				Data data=dList.getData(j);
				if(uuid[i]!=null&&uuid[i].equals(data.get("AF_ID"))){
					addlist.add(data);
				}
			}
		}
		
		//ȥ���ظ�ѡ��
		for(int i=0;i<addlist.size();i++){
			for(int j=0;j<resList.size();j++){
				if(addlist.size()!=0&&addlist.getData(i).getString("AF_ID").equals(resList.getData(j).getString("AF_ID"))){
					addlist.remove(i);
				}
			}
		}
		
		for(int i=0;i<addlist.size();i++){
			resList.add(addlist.getData(i));
		}
		session.setAttribute("fileList", resList);
		Data data=new Data();
		data.add("flag", true);
		JSONObject json =JSONObject.fromObject(data);
		setReturnValue(json.toString());
		return true;
	}
	
	

}
