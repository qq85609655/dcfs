/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.util.ArrayList;
import java.util.List;

/**
 * @Title: MessageService.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 ����02:08:39
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MessageService {

    /** ��ȡ������Ա
     * @param users
     * @param BSF
     * @return
     */
    public static List getUser(String users,String BSF){
        List list=new ArrayList();
        String[] usersArray=users.split(BSF);
        for(int i=0;i<usersArray.length;i++){
            usersArray[i]=usersArray[i].trim();
            if(!usersArray[i].equals("")){
                int p=usersArray[i].indexOf("(");
                int q=usersArray[i].indexOf(")");
                if(p!=-1){//�����ַ����в�����()
                    if(list.contains(usersArray[i].substring(p+1, q))){}else{
                        list.add(usersArray[i].substring(p+1, q));
                    }
                }else{
                    if(list.contains(usersArray[i])){}else{
                        list.add(usersArray[i]);
                    }
                }
            }
        }
        return list;
    }
    
    /**
     * ���˵��ַ����еĲ�����Ϊ�ļ����������ַ�
     * @param conn
     * @param xhid
     * @return
     */
  public static String eqcharfilter(String str){
      String str2=str;
      str2=str2.replaceAll("/","");
      //str2=str2.replaceAll("\\\\",""); 
      //str2=str2.replaceAll(":","");
      str2=str2.replaceAll("[*]","");
      str2=str2.replaceAll("[?]","");
      str2=str2.replaceAll("\"","");
      str2=str2.replaceAll("<","");
      str2=str2.replaceAll(">","");
      str2=str2.replaceAll("[|]","");
      return str2;
  }
    
}
