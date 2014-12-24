package com.dcfs;

import hx.common.Exception.DBException;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.ncm.MatchAction;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class pdfTest1 {
    private static Log log=UtilLog.getLog(pdfTest1.class);
    
    public boolean iTextTest() {
        try {
            //ʵ�����ĵ�����  
            Document document = new Document(PageSize.A4, 84, 85, 92, 50);//A4ֽ���������¿հ�
            
            String PDFpath = "C://Users//xugaoyang//Desktop//11111111.pdf";//����ļ�·��
            // PdfWriter����
            PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
            float width = document.getPageSize().getWidth() - 169;
            document.open();// ���ĵ�
          //pdf�ĵ���������������ã�ע��һ��Ҫ���iTextAsian.jar��
            //��������
            BaseFont bfHEI = BaseFont.createFont("C:\\Windows\\Fonts\\SIMHEI.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
            //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//��ͨ����
            //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
            //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
            BaseFont bfSONG = BaseFont.createFont("C:\\Windows\\Fonts\\SIMSUN.TTC,0",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
            //���� ����
            Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//���� 10 ����
            //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//���� 11 ����
            Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//���� 12 ����
            Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//���� 16 ����
            
            //���� ����
            
            //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//���� 9 ����
            Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//���� 9.5 ����
            Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//���� 10 ����
            Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//���� 10.5 ����
            Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//���� 11 ����
            Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
            Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//���� 12.5 ����
            
            //���� ����
            Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//���� 10 ����
            Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//���� 10.5 ����
            Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//���� 11 ����
            //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//���� 12 ����
            
            //���� б��
            Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//���� 10 б��
            
            
            //��������
            //times new Roman ����
            Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 ����
            
            //times new Roman ����
            Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 ����
            //Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 ����
            Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 ����
            Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 ����
            //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 ����
            
            //times new Roman б��
            Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 б��
            
            //���ı���
            Paragraph ParagraphTitleCN = new Paragraph("�� �� �� �� �� �� �� ��", FontCN_HEI16B);
            ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleCN);
            //Ӣ�ı���
            Paragraph ParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation from Adopter", FontEN_T14B);
            ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
            ParagraphTitleEN.setSpacingAfter(4);
            document.add(ParagraphTitleEN);
            //�ļ����
            Paragraph ParagraphFileCode = new Paragraph("2012-0164-06-03-0299   ", FontEN_T14B);
            ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
            ParagraphFileCode.setSpacingAfter(5);
            document.add(ParagraphFileCode);
            //�����˳ƺ�
            Paragraph ParagraphMaleName = new Paragraph("MR. SERGIO ZHANICHELLI", FontCN_SONG11N);
            document.add(ParagraphMaleName);
            Paragraph ParagraphFemaleName = new Paragraph("MRS.MICHELA PIAZZOLI:", FontCN_SONG12N);
            ParagraphFemaleName.setSpacingAfter(10);//���¶����
            document.add(ParagraphFemaleName);
            //��������
            Paragraph ParagraphContextCN = new Paragraph();
            ParagraphContextCN.setFirstLineIndent(20);//��������
            Phrase PhraseContextCN1 = new Phrase("�������ǵ��������뼰���л����񹲺͹����������Ĺ涨���й���ͯ��������������Ϊ����ѡ����һ����ͯ���ֽ��й�����ת����������������뽫�Ƿ�ͬ�����������ǩ���������ʵ���λ�ã�����������齻����Ϊ���ǵݽ������ļ��Ļ���", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN1);
            Phrase PhraseContextCN2 = new Phrase("�������������ʶ�ͯ��ͥ���ġ�", FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN2);
            ParagraphContextCN.setLeading(15f);
            ParagraphContextCN.setSpacingAfter(10);//���¶����
            document.add(ParagraphContextCN);
            //Ӣ������
            Paragraph ParagraphContextEN = new Paragraph();
            ParagraphContextEN.setFirstLineIndent(20);//��������
            Phrase PhraseContextEN1 = new Phrase("Based on your application and in accordance with the ", FontCN_SONG10N);
            ParagraphContextEN.add(PhraseContextEN1);
            Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China,", FontCN_SONG10I);
            ParagraphContextEN.add(PhraseContextEN2);
            Phrase PhraseContextEN3 = new Phrase("the China Center for Children's welfare and Adoption ", FontEN_T10B);
            ParagraphContextEN.add(PhraseContextEN3);
            Phrase PhraseContextEN4 = new Phrase("matched a child with you��Herein.we send the information about the child to you.You are kindly requested to make you decision.sign in the proper place below.and deliver this letter as soon as possible to the adoption organization which submitted your application file,", FontCN_SONG10N);
            ParagraphContextEN.add(PhraseContextEN4);
            Phrase PhraseContextEN5 = new Phrase("CENTRO INTERNAZIONALE PER I'INFANZIA E LA FAMIGLIA.", FontEN_T10B);
            ParagraphContextEN.add(PhraseContextEN5);
            ParagraphContextEN.setLeading(14f);
            ParagraphContextEN.setSpacingAfter(25);//���¶����
            document.add(ParagraphContextEN);
            
            //���Ķ�ͯ��Ϣ
            //��һ����Ϣ
            float[] widths1 = {0.13f,0.30f,0.25f,0.32f};//��������ͱ���
            PdfPTable Table1 = new PdfPTable(widths1);//�������
            Table1.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table1_cell1 = new PdfPCell(new Paragraph("�������ˣ�", FontCN_SONG10N));
            Table1_cell1.setBorderWidth(0);//cell��borderΪ0
            Table1_cell1.setLeading(2f, 1f);
            Table1.addCell(Table1_cell1);
            //�ڶ���cell
            PdfPCell Table1_cell2 = new PdfPCell(new Paragraph("�����������", FontCN_SONG10N));
            Table1_cell2.setBorderWidth(0);//cell��borderΪ0
            Table1_cell2.setLeading(2f, 1f);
            Table1.addCell(Table1_cell2);
            //������cell
            PdfPCell Table1_cell3 = new PdfPCell(new Paragraph("�Ա���", FontCN_SONG10N));
            Table1_cell3.setBorderWidth(0);
            Table1_cell3.setLeading(2f, 1f);
            Table1.addCell(Table1_cell3);
            //���ĸ�cell
            PdfPCell Table1_cell4 = new PdfPCell(new Paragraph("�������ڣ�2008��03��15��", FontCN_SONG10N));
            Table1_cell4.setBorderWidth(0);
            Table1_cell4.setLeading(2f, 1f);
            Table1.addCell(Table1_cell4);
            document.add(Table1);
            //�ڶ�����Ϣ
            float[] widths2 = {0.13f,0.13f,0.74f};//��������ͱ���
            PdfPTable Table2 = new PdfPTable(widths2);//�������
            Table2.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table2_cell1 = new PdfPCell();
            Table2_cell1.setBorderWidth(0);//cell��borderΪ0
            Table2_cell1.setLeading(2f, 1f);
            Table2.addCell(Table2_cell1);
            //�ڶ���cell
            PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("����״����", FontCN_SONG10N));
            Table2_cell2.setBorderWidth(0);//cell��borderΪ0
            Table2_cell2.setLeading(2f, 1f);
            Table2.addCell(Table2_cell2);
            //������cell
            PdfPCell Table2_cell3 = new PdfPCell(new Paragraph("����", FontCN_SONG10N));
            Table2_cell3.setBorderWidth(0);
            Table2_cell3.setLeading(2f, 1f);
            Table2.addCell(Table2_cell3);
            document.add(Table2);
            //��������Ϣ
            float[] widths3 = {0.13f,0.08f,0.79f};//��������ͱ���
            PdfPTable Table3 = new PdfPTable(widths3);//�������
            Table3.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table3_cell1 = new PdfPCell();
            Table3_cell1.setBorderWidth(0);//cell��borderΪ0
            Table3_cell1.setLeading(2f, 1f);
            Table3.addCell(Table3_cell1);
            //�ڶ���cell
            PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("��ݣ�", FontCN_SONG10N));
            Table3_cell2.setBorderWidth(0);//cell��borderΪ0
            Table3_cell2.setLeading(2f, 1f);
            Table3.addCell(Table3_cell2);
            //������cell
            PdfPCell Table3_cell3 = new PdfPCell(new Paragraph("����ĸ����������������������Ů", FontCN_SONG10N));
            Table3_cell3.setBorderWidth(0);
            Table3_cell3.setLeading(2f, 1f);
            Table3.addCell(Table3_cell3);
            document.add(Table3);
            
            //Ӣ�Ķ�ͯ��Ϣ
            //��һ����Ϣ
            PdfPTable Table4 = new PdfPTable(widths1);//�������
            Table4.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table4_cell1 = new PdfPCell(new Paragraph("Adoptee:", FontCN_SONG10B));
            Table4_cell1.setBorderWidth(0);//cell��borderΪ0
            Table4_cell1.setLeading(2f, 1f);
            Table4.addCell(Table4_cell1);
            //�ڶ���cell
            Paragraph Paragraph_name = new Paragraph();
            Phrase Phrase_N = new Phrase("Name:", FontCN_SONG10B);
            Paragraph_name.add(Phrase_N);
            Phrase Phrase_Name = new Phrase("LEI SHU JIE", FontCN_SONG10N);
            Paragraph_name.add(Phrase_Name);
            PdfPCell Table4_cell2 = new PdfPCell(Paragraph_name);
            Table4_cell2.setBorderWidth(0);//cell��borderΪ0
            Table4_cell2.setLeading(2f, 1f);
            Table4.addCell(Table4_cell2);
            //������cell
            Paragraph Paragraph_sex = new Paragraph();
            Phrase Phrase_S = new Phrase("Sex:", FontCN_SONG10B);
            Paragraph_sex.add(Phrase_S);
            Phrase Phrase_Sex = new Phrase("M", FontCN_SONG10N);
            Paragraph_sex.add(Phrase_Sex);
            PdfPCell Table4_cell3 = new PdfPCell(Paragraph_sex);
            Table4_cell3.setBorderWidth(0);//cell��borderΪ0
            Table4_cell3.setLeading(2f, 1f);
            Table4.addCell(Table4_cell3);
            //���ĸ�cell
            Paragraph Paragraph_birthday = new Paragraph();
            Phrase Phrase_B = new Phrase("Date of birth:", FontCN_SONG10B);
            Paragraph_birthday.add(Phrase_B);
            Phrase Phrase_birthday = new Phrase("2008/03/15", FontCN_SONG10N);
            Paragraph_birthday.add(Phrase_birthday);
            PdfPCell Table4_cell4 = new PdfPCell(Paragraph_birthday);
            Table4_cell4.setBorderWidth(0);//cell��borderΪ0
            Table4_cell4.setLeading(2f, 1f);
            Table4.addCell(Table4_cell4);
            document.add(Table4);
            //�ڶ�����Ϣ
            float[] widths5 = {0.13f,0.18f,0.69f};//��������ͱ���
            PdfPTable Table5 = new PdfPTable(widths5);//�������
            Table5.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table5_cell1 = new PdfPCell();
            Table5_cell1.setBorderWidth(0);//cell��borderΪ0
            Table5_cell1.setLeading(2f, 1f);
            Table5.addCell(Table5_cell1);
            //�ڶ���cell
            PdfPCell Table5_cell2 = new PdfPCell(new Paragraph("Health Status:", FontCN_SONG10B));
            Table5_cell2.setBorderWidth(0);//cell��borderΪ0
            Table5_cell2.setLeading(2f, 1f);
            Table5.addCell(Table5_cell2);
            //������cell
            PdfPCell Table5_cell3 = new PdfPCell(new Paragraph("NORMAL", FontCN_SONG10N));
            Table5_cell3.setBorderWidth(0);
            Table5_cell3.setLeading(2f, 1f);
            Table5.addCell(Table5_cell3);
            document.add(Table5);
            //��������Ϣ
            float[] widths6 = {0.13f,0.12f,0.75f};//��������ͱ���
            PdfPTable Table6 = new PdfPTable(widths6);//�������
            Table6.setWidthPercentage(100);//��񳤶�100%
            //��һ��cell
            PdfPCell Table6_cell1 = new PdfPCell();
            Table6_cell1.setBorderWidth(0);//cell��borderΪ0
            Table6_cell1.setLeading(2f, 1f);
            Table6.addCell(Table6_cell1);
            //�ڶ���cell
            PdfPCell Table6_cell2 = new PdfPCell(new Paragraph("Identity:", FontCN_SONG10B));
            Table6_cell2.setBorderWidth(0);//cell��borderΪ0
            Table6_cell2.setLeading(2f, 1f);
            Table6.addCell(Table6_cell2);
            //������cell
            Paragraph Paragraph_identityEN = new Paragraph("child whose parents are not capable of nurturing due to special difficulties", FontCN_SONG10N);
            PdfPCell Table6_cell3 = new PdfPCell(Paragraph_identityEN);
            Table6_cell3.setBorderWidth(0);
            Table6_cell3.setLeading(2f, 1f);
            Table6.addCell(Table6_cell3);
            document.add(Table6);
            
            //����������
            PdfPTable Table7 = new PdfPTable(1);//�������
            Table7.setWidthPercentage(100);//��񳤶�100%
            PdfPCell Table7_cell1 = new PdfPCell(new Paragraph("���������������ƣ���������", FontCN_SONG10N));
            Table7_cell1.setBorderWidth(0);
            Table7_cell1.setLeading(2f, 1f);
            Table7.addCell(Table7_cell1);
            document.add(Table7);
            //������Ӣ��
            float[] widths8 = {0.08f,0.92f};//��������ͱ���
            PdfPTable Table8 = new PdfPTable(widths8);//�������
            Table8.setWidthPercentage(100);//��񳤶�100%
            PdfPCell Table8_cell1 = new PdfPCell(new Paragraph("From:", FontCN_SONG10B));
            Table8_cell1.setBorderWidth(0);
            Table8_cell1.setLeading(2f, 1f);
            Table8.addCell(Table8_cell1);
            PdfPCell Table8_cell2 = new PdfPCell(new Paragraph("LEI LIU WU", FontCN_SONG10N));
            Table8_cell2.setBorderWidth(0);
            Table8_cell2.setLeading(2f, 1f);
            Table8.addCell(Table8_cell2);
            document.add(Table8);
            
            //���
            float[] widths9 = {0.42f,0.58f};//��������ͱ���
            PdfPTable Table9 = new PdfPTable(widths9);//�������
            Table9.setTotalWidth(width);
            Table9.setLockedWidth(true);
            //��һ��cell
            PdfPCell Table9_cell1 = new PdfPCell(new Paragraph());
            Table9_cell1.setFixedHeight(22f);
            Table9_cell1.setBorder(0);
            Table9.addCell(Table9_cell1);
            //�ڶ���cell
            PdfPCell Table9_cell2 = new PdfPCell(new Paragraph("      �й���ͯ��������������", FontCN_SONG12_5N));
            Table9_cell2.setBorder(0);
            Table9_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table9.addCell(Table9_cell2);
            //������cell
            PdfPCell Table9_cell3 = new PdfPCell(new Paragraph());
            Table9_cell3.setFixedHeight(20f);
            Table9_cell3.setBorder(0);
            Table9.addCell(Table9_cell3);
            //���ĸ�cell
            PdfPCell Table9_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontCN_SONG9_5N));
            Table9_cell4.setBorder(0);
            Table9_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table9.addCell(Table9_cell4);
            //�����cell
            PdfPCell Table9_cell5 = new PdfPCell(new Paragraph("�����������", FontCN_SONG11B));
            Table9_cell5.setBorder(0);
            Table9.addCell(Table9_cell5);
            //������cell
            String inscribeDate = "    2013/02/18";//�������Ĭ������Ϊ�����������ͨ��������MATCH_PASSDATE
            PdfPCell Table9_cell6 = new PdfPCell(new Paragraph(inscribeDate, FontCN_SONG12N));
            Table9_cell6.setBorder(0);
            Table9_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table9.addCell(Table9_cell6);
            Table8.setSpacingAfter(40);
            Table9.writeSelectedRows(0, -1, 84, 290, writer.getDirectContent());
            
            //���������
            float[] widths10 = {0.04f,0.96f};
            PdfPTable Table10 = new PdfPTable(widths10);
            Table10.setTotalWidth(width);
            Table10.setLockedWidth(true);
            //��һ��cell
            PdfPCell Table10_cell1 = new PdfPCell(new Paragraph("Decision of Adopter:", FontCN_SONG10_5B));
            Table10_cell1.setFixedHeight(16f);
            Table10_cell1.setBorderWidth(0);
            Table10_cell1.setColspan(2);
            Table10.addCell(Table10_cell1);
            //�ڶ���cell
            PdfPCell Table10_cell2 = new PdfPCell(new Paragraph("��", FontCN_SONG10_5N));
            Table10_cell2.setBorderWidth(0);
            Table10.addCell(Table10_cell2);
            //������cell
            PdfPCell Table10_cell3 = new PdfPCell(new Paragraph("����ͬ������������ͯ��", FontCN_SONG10_5N));
            Table10_cell3.setBorderWidth(0);
            Table10.addCell(Table10_cell3);
            //���ĸ�cell
            PdfPCell Table10_cell5 = new PdfPCell(new Paragraph("   We accept the adoptee mentiioned above.", FontCN_SONG10N));
            Table10_cell5.setColspan(2);
            Table10_cell5.setBorderWidth(0);
            Table10.addCell(Table10_cell5);
            //�����cell
            PdfPCell Table10_cell6 = new PdfPCell(new Paragraph("��", FontCN_SONG10_5N));
            Table10_cell6.setBorderWidth(0);
            Table10.addCell(Table10_cell6);
            //������cell
            PdfPCell Table10_cell7 = new PdfPCell(new Paragraph("���ǲ�ͬ������������ͯ�������ǣ�", FontCN_SONG10_5N));
            Table10_cell7.setBorderWidth(0);
            Table10.addCell(Table10_cell7);
            //���߸�cell
            PdfPCell Table10_cell9 = new PdfPCell(new Paragraph("   We cannot accept the adoptee mentiioned above��the reason is:", FontCN_SONG10N));
            Table10_cell9.setColspan(2);
            Table10_cell9.setBorderWidth(0);
            Table10.addCell(Table10_cell9);
            Table10.writeSelectedRows(0, -1, 84, 218, writer.getDirectContent());
            
            //������ǩ��
            float[] widths11 = {0.72f,0.28f};
            PdfPTable Table11 = new PdfPTable(widths11);
            Table11.setTotalWidth(width);
            Table11.setLockedWidth(true);
            
            PdfPCell Table11_cell1 = new PdfPCell(new Paragraph("�����˸���ǩ��:", FontCN_SONG10B));
            Table11_cell1.setBorderWidth(0);
            Table11_cell1.setColspan(2);
            Table11.addCell(Table11_cell1);
            
            PdfPCell Table11_cell2 = new PdfPCell(new Paragraph("Signature of Adoptive Father ��", FontCN_SONG10B));
            Table11_cell2.setBorderWidth(0);
            Table11.addCell(Table11_cell2);
            
            PdfPCell Table11_cell3 = new PdfPCell(new Paragraph("���ڣ�", FontCN_SONG10B));
            Table11_cell3.setBorderWidth(0);
            Table11.addCell(Table11_cell3);
            
            PdfPCell Table11_cell4 = new PdfPCell(new Paragraph("������ĸ��ǩ��:", FontCN_SONG10B));
            Table11_cell4.setBorderWidth(0);
            Table11_cell4.setColspan(2);
            Table11.addCell(Table11_cell4);
            
            PdfPCell Table11_cell5 = new PdfPCell(new Paragraph("Signature of Adoptive Mother ��", FontCN_SONG10B));
            Table11_cell5.setBorderWidth(0);
            Table11.addCell(Table11_cell5);
            
            PdfPCell Table11_cell6 = new PdfPCell(new Paragraph("Date��year/month/date", FontCN_SONG10B));
            Table11_cell6.setBorderWidth(0);
            Table11.addCell(Table11_cell6);
            Table11.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
            
            String IS_CONVENTION_ADOPT = "0";
            if("1".equals(IS_CONVENTION_ADOPT)){//��Լ����
                document.newPage();
                //���ı���
                Paragraph SParagraphTitleCN = new Paragraph("�� �� �� �� �� �� ��", FontCN_HEI16B);
                SParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
                document.add(SParagraphTitleCN);
                //Ӣ�ı���
                Paragraph SParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation", FontEN_T14B);
                SParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
                SParagraphTitleEN.setSpacingAfter(4);
                document.add(SParagraphTitleEN);
                //�ļ����
                Paragraph SParagraphFileCode = new Paragraph("2012-0164-06-03-0299      ", FontEN_T14B);
                SParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
                SParagraphFileCode.setSpacingAfter(4);
                document.add(SParagraphFileCode);
                //�������������
                Paragraph SParagraphMaleName = new Paragraph("������������أ�", FontCN_HEI12B);
                document.add(SParagraphMaleName);
                Paragraph SParagraphFemaleName = new Paragraph("Central Authority of Receiving State:", FontEN_T12B);
                SParagraphFemaleName.setSpacingAfter(20);//���¶����
                document.add(SParagraphFemaleName);
                //��������
                Paragraph SParagraphContextCN = new Paragraph("���ݡ��л����񹲺͹�����������������������汣����ͯ��������Լ����ʮ�����Ĺ涨���й�����ͯ��������������Ϊ������MR.SERGIO ZHANICHELLI & MRS.MICHELA PIAZZOLIѡ����һ����ͯ�� ����࣬�У�2008��03�� 15�ճ��������溯���ϸö�ͯ����Ƭ�������ɳ����档�뽫���ǵ����ǩ���������ʵ���λ�á�", FontCN_SONG11N);
                SParagraphContextCN.setFirstLineIndent(20);//��������
                SParagraphContextCN.setSpacingAfter(50);//���¶����
                document.add(SParagraphContextCN);
                //Ӣ������
                Paragraph SParagraphContextEN = new Paragraph();
                SParagraphContextEN.setFirstLineIndent(20);//��������
                Phrase SPhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
                SParagraphContextEN.add(SPhraseContextEN1);
                Phrase SPhraseContextEN2 = new Phrase("Adoption law of the People's Republic of China ", FontEN_T11I);
                SParagraphContextEN.add(SPhraseContextEN2);
                Phrase SPhraseContextEN3 = new Phrase("And the Article 17 of the ", FontEN_T11N);
                SParagraphContextEN.add(SPhraseContextEN3);
                Phrase SPhraseContextEN4 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption,", FontEN_T11I);
                SParagraphContextEN.add(SPhraseContextEN4);
                Phrase SPhraseContextEN5 = new Phrase("the China Center for Children's welfare and Adoption matched a child(Name:LEI SHU JIE,Sex:M,D.O.B:2008/03/15)with the adoption applicants MR.SERGIO ZHANICHELLI & MRS.MICHELA PIAZZOLI.Enclosed please find the pictures,medical examination from,and growth report of the child,Please sign in the proper place underneath to present your opinion.", FontEN_T11N);
                SParagraphContextEN.add(SPhraseContextEN5);
                SParagraphContextEN.setLeading(14f);
                //ParagraphContextEN.setSpacingAfter(25);//���¶����
                document.add(SParagraphContextEN);
                
                //���
                float[] Swidths1 = {0.42f,0.58f};//��������ͱ���
                PdfPTable STable1 = new PdfPTable(Swidths1);//�������
                STable1.setTotalWidth(width);
                STable1.setLockedWidth(true);
                //��һ��cell
                PdfPCell STable1_cell1 = new PdfPCell(new Paragraph());
                STable1_cell1.setFixedHeight(20f);
                STable1_cell1.setBorder(0);
                STable1.addCell(STable1_cell1);
                //�ڶ���cell
                PdfPCell STable1_cell2 = new PdfPCell(new Paragraph("      �й���ͯ��������������", FontCN_SONG12_5N));
                STable1_cell2.setBorder(0);
                STable1_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
                STable1.addCell(STable1_cell2);
                //������cell
                PdfPCell STable1_cell3 = new PdfPCell(new Paragraph());
                STable1_cell3.setFixedHeight(18f);
                STable1_cell3.setBorder(0);
                STable1.addCell(STable1_cell3);
                //���ĸ�cell
                PdfPCell STable1_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontCN_SONG9_5N));
                STable1_cell4.setBorder(0);
                STable1_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
                STable1.addCell(STable1_cell4);
                //�����cell
                PdfPCell STable1_cell5 = new PdfPCell(new Paragraph());
                STable1_cell5.setBorder(0);
                STable1.addCell(STable1_cell5);
                //������cell
                PdfPCell STable1_cell6 = new PdfPCell(new Paragraph(inscribeDate, FontCN_SONG12N));
                STable1_cell6.setBorder(0);
                STable1_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
                STable1.addCell(STable1_cell6);
                STable1.writeSelectedRows(0, -1, 84, 285, writer.getDirectContent());
                
                //���������
                PdfPTable STable2 = new PdfPTable(1);
                STable2.setTotalWidth(width);
                STable2.setLockedWidth(true);
                //��һ��cell
                PdfPCell STable2_cell1 = new PdfPCell(new Paragraph("������������������", FontCN_HEI10B));
                STable2_cell1.setBorderWidth(0);
                STable2_cell1.setColspan(2);
                STable2.addCell(STable2_cell1);
                //�ڶ���cell
                PdfPCell STable2_cell2 = new PdfPCell(new Paragraph("Opinion of the Central Authority of Receiving State:", FontEN_T10B));
                STable2_cell2.setBorderWidth(0);
                STable2.addCell(STable2_cell2);
                //������cell
                PdfPCell STable2_cell3 = new PdfPCell(new Paragraph("�� ����ͬ���й���ͯ�������������ĸ����ͯ���þ�����", FontCN_SONG10N));
                STable2_cell3.setBorderWidth(0);
                STable2.addCell(STable2_cell3);
                //���ĸ�cell
                PdfPCell STable2_cell5 = new PdfPCell(new Paragraph("   We agree with the decision made by CCCWA.", FontCN_SONG10N));
                STable2_cell5.setColspan(2);
                STable2_cell5.setBorderWidth(0);
                STable2.addCell(STable2_cell5);
                //�����cell
                PdfPCell STable2_cell6 = new PdfPCell(new Paragraph("�� ���ǲ�ͬ���й���ͯ�������������ĸ����ͯ���þ����������ǣ�", FontCN_SONG10N));
                STable2_cell6.setBorderWidth(0);
                STable2.addCell(STable2_cell6);
                //������cell
                PdfPCell STable2_cell7 = new PdfPCell(new Paragraph("   We don't agree with the decision made by CCCWA��the reason is��", FontCN_SONG10_5N));
                STable2_cell7.setBorderWidth(0);
                STable2.addCell(STable2_cell7);
                STable2.writeSelectedRows(0, -1, 84, 230, writer.getDirectContent());
                
                //������ǩ��
                float[] Swidths3 = {0.72f,0.28f};
                PdfPTable STable3 = new PdfPTable(Swidths3);
                STable3.setTotalWidth(width);
                STable3.setLockedWidth(true);
                
                PdfPCell STable3_cell1 = new PdfPCell(new Paragraph("ǩ���ˣ�", FontCN_SONG10B));
                STable3_cell1.setBorderWidth(0);
                STable3_cell1.setColspan(2);
                STable3.addCell(STable3_cell1);
                
                PdfPCell STable3_cell2 = new PdfPCell(new Paragraph("Signature:", FontEN_T10B));
                STable3_cell2.setBorderWidth(0);
                STable3_cell2.setColspan(2);
                STable3.addCell(STable3_cell2);
                
                PdfPCell STable3_cell3 = new PdfPCell(new Paragraph("������������أ�", FontCN_SONG10B));
                STable3_cell3.setBorderWidth(0);
                STable3.addCell(STable3_cell3);
                
                PdfPCell STable3_cell4 = new PdfPCell(new Paragraph("���ڣ�", FontCN_SONG10B));
                STable3_cell4.setBorderWidth(0);
                STable3.addCell(STable3_cell4);
                
                PdfPCell STable3_cell5 = new PdfPCell(new Paragraph("Central Authority of Receiving State:", FontEN_T10B));
                STable3_cell5.setBorderWidth(0);
                STable3.addCell(STable3_cell5);
                
                PdfPCell STable3_cell6 = new PdfPCell(new Paragraph(" Date��year/month/date", FontEN_T10B));
                STable3_cell6.setBorderWidth(0);
                STable3.addCell(STable3_cell6);
                STable3.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
            }
            document.close();
            /*File file = new File(PDFpath);
            String attTypeCode = "AR";
            String packageId = UUID.getUUID();
            
            AttHelper.manualUploadAtt(file, "OTHER", packageId);*/
            
            return true;
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (DocumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    /**
     * @Title: main
     * @Description: 
     * @author: xugy
     * @date: 2014-9-16����5:33:27
     * @param args
     */

    public static void main(String[] args) {
        MatchAction ma = new MatchAction();
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            String MI_ID = "7dbda188-0be5-4396-bdca-014a1967835d";
            ma.letterOfSeekingConfirmation(conn, MI_ID, "1");
            //ma.waterMark("C:/Users/xugaoyang/Desktop/qwqwqw/20142100029.pdf", "C:/Users/xugaoyang/Desktop/qwqwqw/20142100029.pdf", "simple");
        } catch (DBException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
        
        //System.out.println(new pdfTest1().iTextTest()); 

    }

}
