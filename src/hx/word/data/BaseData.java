/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.word.data;

import java.sql.Connection;
import java.util.Map;

/**
 * @Title: BaseData.java
 * @Description:���ݻ�ȡ������
 * @Company: 21softech
 * @Created on 2014-11-5 08:19:47
 * @author �غ���
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public abstract class BaseData{
    
    /**
     * ģ�����ݻ�ȡ
     * @param classpath
     * @return
     * @throws Exception 
     */
    public abstract Map<String, Object> getData(Connection conn, String id) throws Exception;
}
