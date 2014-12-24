package com.hx.cms.tags;

import hx.database.databean.Data;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.channel.vo.Channel;

/**
 * 
 * @Title: ChannelUrlLinkTag.java
 * @Description: Ƶ���ⲿ���ӵ�ַ<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelUrlLinkTag extends TagSupport {
    
    /**
     * ���л�
     */
    private static final long serialVersionUID = 330680087521827763L;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * ��ʼ��ǩ
     */
    @Override
    public int doStartTag() throws JspException {
        Tag tag = getParent();
        //�������
        String html = "";
        
        try {
            if(tag instanceof ChannelListTag){
                ChannelListTag channelListTag = (ChannelListTag) tag;
                //�õ���ǰѭ������DataԪ��
                Data data = channelListTag.getData();
                //����
                html = data.getString(Channel.URL_LINK);
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
