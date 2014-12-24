package com.hx.cms.util;

import java.util.ResourceBundle;

/**
 * ��ȡcms�����ļ�
 * @author lij
 *
 */
public class CmsConfigUtil {

	private static ResourceBundle properties = ResourceBundle.getBundle(Constants.CMS_CONFIG_FILE);
	
	private CmsConfigUtil(){}
	
	public static ResourceBundle getCmsConfig(){
		return properties;
	}
	
	public static String getValue(String key){
		return properties.getString(key);
	}
	
	/**
	 * �Ƿ�ּ�����ģʽ
	 * @return
	 */
	public static boolean isMultistageAdminMode(){
		if(properties == null){
			return false;
		}
		String adminM = properties.getString(Constants.ADMIN_MODE);
		return Constants.ADMIN_MODE_MULTISTAGE.equals(adminM);
	}
	
	/**
	 * �Ƿ���Ա����ģʽ
	 * @return
	 */
	public static boolean isThreeAdminMode(){
		if(properties == null){
			return false;
		}
		String adminM = properties.getString(Constants.ADMIN_MODE);
		return Constants.ADMIN_MODE_THREE_MEMBER.equals(adminM);
	}
	
	/**
	 * �Ƿ�һ��Nģʽ
	 * @return
	 */
	public static boolean is1nMode(){
		if(properties == null){
			return false;
		}
		String nMode = properties.getString(Constants.N_MODE);
		return "true".equals(nMode);
	}
	
	public static void main(String[] args) {
		System.out.println(is1nMode());
	}
}
