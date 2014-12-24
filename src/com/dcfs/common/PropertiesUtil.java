package com.dcfs.common;

import hx.log.Log;
import hx.log.UtilLog;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Properties;


/**
 * @Title: PropertiesUtil.java
 * @Description:Properties�ļ���ȡ��
 * @Company: 21softech
 * @Created on 2014-10-31
 * @author mayun
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PropertiesUtil {
    
 private static Log log=UtilLog.getLog(PropertiesUtil.class);
 
 String url = this.getClass().getResource("/").getPath();
 
 
  //����key��ȡvalue
    public  String readValue(String fileName,String key) {
     Properties props = new Properties();
           try {
        	   InputStream in = new BufferedInputStream (new FileInputStream(url+fileName));
        	   props.load(in);
        	   String value = props.getProperty (key);
               //System.out.println("key="+key+",Value="+value);
               return value;
           } catch (Exception e) {
            e.printStackTrace();
            return null;
           }
    }
    
    //��ȡproperties��ȫ����Ϣ
      public  void readProperties(String fileName) {
        Properties props = new Properties();
           try {
            InputStream in = new BufferedInputStream (new FileInputStream(url+fileName));
            props.load(in);
               Enumeration en = props.propertyNames();
                while (en.hasMoreElements()) {
                 String key = (String) en.nextElement();
                       String Property = props.getProperty (key);
                       System.out.println(key+Property);
                   }
           } catch (Exception e) {
            e.printStackTrace();
           }
       }

      //д��properties��Ϣ
      public  void writeProperties(String fileName,String parameterName,String parameterValue) {
        Properties prop = new Properties();
        try {
         InputStream fis = new FileInputStream(url+fileName);
               //���������ж�ȡ�����б�����Ԫ�ضԣ�
              prop.load(fis);
               //���� Hashtable �ķ��� put��ʹ�� getProperty �����ṩ�����ԡ�
              //ǿ��Ҫ��Ϊ���Եļ���ֵʹ���ַ���������ֵ�� Hashtable ���� put �Ľ����
              OutputStream fos = new FileOutputStream(fileName);
               prop.setProperty(parameterName, parameterValue);
               //���ʺ�ʹ�� load �������ص� Properties ���еĸ�ʽ��
              //���� Properties ���е������б�����Ԫ�ضԣ�д�������
              prop.store(fos, "Update '" + parameterName + "' value");
           } catch (IOException e) {
            System.err.println("Visit "+fileName+" for updating "+parameterName+" value error");
           }
       }

      public static void main(String[] args) {
        //readValue("D:/newworkspace/dcfs/src/filemodifyhistorycodename-config.properties","IS_ALERT");
          // writeProperties("info.properties","age","21");
           //readProperties("info.properties" );
           //System.out.println("OK");
       }

    
}
