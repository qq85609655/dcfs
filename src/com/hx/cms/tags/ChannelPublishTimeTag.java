package com.hx.cms.tags;

import hx.database.databean.Data;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.channel.vo.Channel;

/**
 * 
 * @Title: ChannelPublishTimeTag.java
 * @Description: Ƶ������ʱ��<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelPublishTimeTag extends TagSupport {
    
    /**
     * ���л�
     */
    private static final long serialVersionUID = 330680087521827763L;

    /**
     * ���ڸ�ʽ��
     */
    private String dateFormat;
    
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
                //ʱ��
                String createTime = data.getString(Channel.CREATE_TIME);
                if(dateFormat != null && !"".equals(dateFormat)){
                    Date createTime_ = (Date)new SimpleDateFormat(dateFormat).parse(createTime);
                    createTime = new SimpleDateFormat(dateFormat).format(createTime_);
                }
                html = createTime;
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    /**
     * @return Returns the dateFormat.
     */
    public String getDateFormat() {
        return dateFormat;
    }

    /**
     * @param dateFormat The dateFormat to set.
     */
    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }
}
