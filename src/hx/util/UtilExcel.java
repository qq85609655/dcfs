package hx.util;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.database.databean.BaseDataExecute;
import hx.database.databean.Data;
import hx.tools.export.FieldType;
import hx.util.AES;
 
import java.awt.Label;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java_cup.internal_error;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.tools.ant.types.resources.comparators.Size;

public class UtilExcel {
	/**
	 * ���ݲ����õ��ֶ����͵���Ϣ
	 * 
	 * @param fieldName
	 *            �ֶ������������Ϣ,����:�ֶ����Ƨ����ı�����ֶ����Ƨ����ı���
	 * @param fieldCode
	 *            �ֶ�������Ϣ,Ĭ��Ϊ�ַ���,����:�ֶ����Ƨ����ͧ���뼯���Ƨ��ֶ����Ƨ����ͧ���뼯����
	 * @return FieldType����ļ���
	 */
	
	private static boolean haveNo = true;
	
	private static List<FieldType> getFieldTypes(String fieldName, String fieldCode, List<String> allCode) {
		List<FieldType> fields = new ArrayList<FieldType>();
		if (fieldName == null || "".equals(fieldName)) {
			return fields;
		}
		String[] fs = fieldName.split(FieldType.SPLIT_CHAR_ROW);
		for (int i = 0; i < fs.length; i++) {
			String[] f = fs[i].split(FieldType.SPLIT_CHAR1);
			if (f.length == 2) {
				FieldType ft = new FieldType();
				ft.setName(f[0]);
				String[] f1 = f[1].split(FieldType.SPLIT_CHAR2);
				if (f1.length > 0) {
					ft.setTitle(f1[0]);
				} else {
					ft.setTitle(f[1]);
				}
				if (f1.length > 1) {
					ft.setWidth(Integer.parseInt(f1[1]));
				}
				if (f1.length > 2) {
					ft.setHeight(Integer.parseInt(f1[2]));
				}

				setFieldType(ft, fieldCode, allCode);
				fields.add(ft);
			}
		}
		return fields;
	}

	/**
	 * �����ֶε�����
	 * 
	 * @param name
	 *            �ֶ�
	 * @param fieldCode
	 *            ����
	 * @return
	 */
	private static void setFieldType(FieldType ft, String fieldCode, List<String> allCode) {
		String[] fs = fieldCode.split(FieldType.SPLIT_CHAR_ROW);
		boolean isSet = false;
		for (int i = 0; i < fs.length; i++) {
			String[] f = fs[i].split(FieldType.SPLIT_CHAR1);
			if (f.length >= 2) {
				if (ft.getName().equalsIgnoreCase(f[0])) {
					String[] f1 = f[1].split(FieldType.SPLIT_CHAR2);
					if (f1.length > 0) {
						ft.setType(f1[0]);
					}
					if (f1.length > 1) {
						ft.setExpInfo(f1[1]);
						if (FieldType.TYPE_CODE.equalsIgnoreCase(f1[0])) {
							allCode.add(f1[1]);
						}
					}
					isSet = true;
					break;
				}
			}
		}
		if (!isSet) {
			ft.setType(FieldType.TYPE_STRING);
		}
	}

	/**
	 * �õ����������ʽ
	 * 
	 * @param wb
	 * @return
	 */
	private static CellStyle getThStyle(Workbook wb) {
		CellStyle cs = wb.createCellStyle();
		Font f = wb.createFont();
		f.setFontHeightInPoints((short) 12);
		f.setBoldweight(Font.BOLDWEIGHT_BOLD);
		f.setFontName("����");
		cs.setFont(f);
		cs.setBorderBottom(CellStyle.BORDER_THIN);
		cs.setBorderLeft(CellStyle.BORDER_THIN);
		cs.setBorderRight(CellStyle.BORDER_THIN);
		cs.setBorderTop(CellStyle.BORDER_THIN);
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cs.setAlignment(CellStyle.ALIGN_LEFT);
		cs.setFillBackgroundColor(HSSFColor.GREY_40_PERCENT.index);
		return cs;
	}

	/**
	 * �õ����ĵ���ʽ
	 * 
	 * @param wb
	 * @return
	 */
	private static CellStyle getTdStyle(Workbook wb) {
		CellStyle cs = wb.createCellStyle();
		Font f = wb.createFont();
		f.setFontHeightInPoints((short) 12);
		// f.setBoldweight(Font.BOLDWEIGHT_BOLD);
		f.setFontName("����");
		
		cs.setFont(f);
		//cs.setBorderBottom(CellStyle.BORDER_THIN);
		//cs.setBorderLeft(CellStyle.BORDER_THIN);
		//cs.setBorderRight(CellStyle.BORDER_THIN);
		//cs.setBorderTop(CellStyle.BORDER_THIN);
		//cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		//cs.setAlignment(CellStyle.ALIGN_LEFT);
		// cs.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
		return cs;
	}

	/**
	 * �õ��������ʽ
	 * 
	 * @param wb
	 * @return
	 */
	private static CellStyle getTitleStyle(Workbook wb) {
		CellStyle cs = wb.createCellStyle();
		Font f = wb.createFont();
		f.setFontHeightInPoints((short) 16);
		f.setBoldweight(Font.BOLDWEIGHT_BOLD);
		f.setFontName("����");
		cs.setFont(f);
		cs.setBorderBottom(CellStyle.BORDER_NONE);
		cs.setBorderLeft(CellStyle.BORDER_NONE);
		cs.setBorderRight(CellStyle.BORDER_NONE);
		cs.setBorderTop(CellStyle.BORDER_NONE);
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cs.setAlignment(CellStyle.ALIGN_CENTER);
		cs.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
		return cs;
	}

	public static void createXls(Connection conn, OutputStream out, String key, String title, String fieldName, String fieldCode,String isShowEN)
			throws IOException {
		Statement stmt = null;
		ResultSet rs = null;
		String sql = AES.decryptStr(key, BaseDataExecute.countPassword);
		// �ֶ����Ƨ����ı����
		List<String> allCode = new ArrayList<String>();
		List<FieldType> fts = getFieldTypes(fieldName, fieldCode, allCode);
		int ftsLen = fts.size();
		HSSFWorkbook wb = new HSSFWorkbook();
		// Iterator<FieldType> ite = fts.iterator();
		// for (;ite.hasNext();){
		// FieldType ft = ite.next();
		//
		// }
		Map<String, CodeList> codeLists = new HashMap<String, CodeList>();
		int len = allCode.size();
		if (len > 0) {
			String[] s = new String[len];
			for (int i = 0; i < len; i++) {
				s[i] = allCode.get(i);
			}
			codeLists = UtilCode.getCodeLists(conn, s);
		}
		
		HSSFCellStyle style1 = wb.createCellStyle();
        style1.setBorderBottom((short)1);
        style1.setBorderLeft((short)1);
        style1.setBorderRight((short)1);
        style1.setBorderTop((short)1);
        style1.setAlignment((short) Label.CENTER);
        
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			int j = 2;
			int m = 0;
			int n = 0;
			Sheet sheet = null;
			while (rs.next()) {
				// ����60000�����ݲ��
				if (m / 60000 - n == 0) {
					String exp = "";
					if (n > 0) {
						exp = "(" + (n+1) + ")";
					}
					String sheetTitle=title + exp;
//					sheetTitle=sheetTitle.replaceAll("'\'","");
//					sheetTitle=sheetTitle.replaceAll("/","");
//					sheetTitle=sheetTitle.replaceAll("[","��");
//					sheetTitle=sheetTitle.replaceAll("]","��");
//					sheetTitle=sheetTitle.replaceAll(":","��");
//					sheetTitle=sheetTitle.replaceAll("<","��");
//					sheetTitle=sheetTitle.replaceAll(">","��");
//					sheetTitle=sheetTitle.replaceAll("\"","��");
//					sheetTitle=sheetTitle.replaceAll("\\|","");
//					sheetTitle=sheetTitle.replaceAll("'*'","");
//					sheetTitle=sheetTitle.replaceAll("'?'","");
					sheet = wb.createSheet(title + exp);
					n++;
					Row rowTitle = sheet.createRow(0);
					Cell cellTitle = rowTitle.createCell(0);
					cellTitle.setCellValue(title + exp);
					cellTitle.setCellStyle(getTitleStyle(wb));
					// ������ʽ
					//rowTitle.setRowStyle(getTitleStyle(wb));
					rowTitle.setHeight((short) (35*20));
					sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, ftsLen));
					
					Row trTitle = sheet.createRow(1);
					//trTitle.setRowStyle(getThStyle(wb));
					//trTitle.setHeight((short) 18);
					if (ftsLen>0){
						FieldType ftTemp = fts.get(0);
						int h = ftTemp.getHeight();
						if (h>0){
							trTitle.setHeight((short)h);
						}
					}
					
					//���������
					if(haveNo){
						Cell trCellNo = trTitle.createCell(0);
						sheet.setColumnWidth(0, 1280);
						sheet.setDefaultColumnStyle(0, getTdStyle(wb));
						trCellNo.setCellStyle(getThStyle(wb));
						trCellNo.setCellValue("���");
					}
					
					for (int i = 0; i < ftsLen; i++) {
						FieldType ft = fts.get(i);
						// ���ӵ�Ԫ��,������Ԫ�����
						Cell trCell = trTitle.createCell(i+1);
						int width = ft.getWidth();
						if (width>0){
							sheet.setColumnWidth(i+1, width);
							sheet.setDefaultColumnStyle(i+1, getTdStyle(wb));
						}
						trCell.setCellStyle(getThStyle(wb));
						trCell.setCellValue(ft.getTitle());
					}
					j=2;
				}
				// ����������
				Row row = sheet.createRow(j);
				//row.setRowStyle(getTdStyle(wb));
				if (ftsLen>0){
					FieldType ftTemp = fts.get(0);
					int h = ftTemp.getHeight();
					if (h>0){
						row.setHeight((short)h);
					}
				}
				
				
				//row.setHeight((short) 18);
	            
	          //���������
				if(haveNo){
					Cell CellNo = row.createCell(0);					
					CellNo.setCellStyle(style1);
					CellNo.setCellValue(m+1);
				}
				System.out.println("row:"+j+" style:"+style1);
				for (int i = 0; i < ftsLen; i++) {
					FieldType ft = fts.get(i);
					// ���ӵ�Ԫ��,������Ԫ��ֵ
					String type = ft.getType();
					Cell cell = row.createCell(i+1);
					cell.setCellStyle(style1);
					
					//cell.setCellStyle(getTdStyle(wb));
					if (FieldType.TYPE_STRING.equals(type)) {
						cell.setCellValue(rs.getString(ft.getName()));
					} else if (FieldType.TYPE_CODE.equals(type)) {
						String codeName = ft.getExpInfo();
						if (codeName != null && !"".equals(codeName)) {
							// Code code
							// =UtilCode.getCode(codeName,rs.getString(ft.getName()),conn);
							CodeList codeList = codeLists.get(codeName);
							String codeValue = rs.getString(ft.getName());
							if (codeValue == null) {
								cell.setCellValue("");
							} else if (codeList == null) {
								cell.setCellValue(codeValue);
							} else {
								Code code = codeList.getCodeByValue(codeValue);
								if (code != null) {
									if("true"==isShowEN||"true".equals(isShowEN)){
										cell.setCellValue(code.getLetter());
									}else{
										cell.setCellValue(code.getName());
									}
								} else {
									String codeNames = codeList.getNames(codeValue)[0];
									if("".equals(codeNames)||null==codeNames){
										cell.setCellValue(codeValue);
									}else{
										cell.setCellValue(codeNames);
									}
									
									
								}

							}

						} else {
							cell.setCellValue(rs.getString(ft.getName()));
						}

					} else if (FieldType.TYPE_DATE.equals(type)) {
						String formatString = ft.getExpInfo();
						if(null==formatString){
							formatString="yyyy-MM-dd";
						}
						Data d = new Data();
						d.add("KEY", rs.getObject(ft.getName()));
						cell.setCellValue(d.getDate("KEY",formatString));
					} else if (FieldType.TYPE_DATETIME.equals(type)) {
						Data d = new Data();
						d.add("KEY", rs.getObject(ft.getName()));
						cell.setCellValue(d.getDateTime("KEY"));
					} else if (FieldType.TYPE_INT.equals(type)) {
						cell.setCellValue(rs.getInt(ft.getName()));
					} else if ("FLAG".equals(type)) {
						String expInfo = ft.getExpInfo();
						String [] flagArray = expInfo.split("&");
						String colValue = rs.getString(ft.getName());
						for(int num=0;num<flagArray.length;num++){
							String [] tempArray = flagArray[num].split(":");
							String tempkey = tempArray[0];
							String tempValue = tempArray[1];
							if(tempkey.equals(colValue)||tempkey==colValue){
								colValue=tempValue;
								break;
							}
						}
						cell.setCellValue(colValue);
						
					} 
					else {
						cell.setCellValue(rs.getString(ft.getName()));
					}
				}
				j++;
				m++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		}
		wb.write(out);
	}

	public static void createXlsx(Connection conn, OutputStream out, String key, String title, String fieldName, String fieldCode)
			throws IOException {
		Statement stmt = null;
		ResultSet rs = null;
		String sql = AES.decryptStr(key, BaseDataExecute.countPassword);
		// �ֶ����Ƨ����ı����
		List<String> allCode = new ArrayList<String>();
		List<FieldType> fts = getFieldTypes(fieldName, fieldCode, allCode);
		Map<String, CodeList> codeLists = new HashMap<String, CodeList>();
		int len = allCode.size();
		if (len > 0) {
			String[] s = new String[len];
			for (int i = 0; i < len; i++) {
				s[i] = allCode.get(i);
			}
			codeLists = UtilCode.getCodeLists(conn, s);
		}
		int ftsLen = fts.size();
		Workbook wb = new HSSFWorkbook();
		// Iterator<FieldType> ite = fts.iterator();
		// for (;ite.hasNext();){
		// FieldType ft = ite.next();
		//
		// }
		Sheet sheet = null;
		sheet = wb.createSheet(title);
		Row rowTitle = sheet.createRow(0);
		// ������ʽ
//		rowTitle.setRowStyle(getTitleStyle(wb));
		rowTitle.setHeight((short) 35);
		Cell cellTitle = rowTitle.createCell(0);
		cellTitle.setCellStyle(getTitleStyle(wb));
		cellTitle.setCellValue(title);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, ftsLen - 1));
		Row trTitle = sheet.createRow(1);
		//trTitle.setRowStyle(getThStyle(wb));
		if (ftsLen>0){
			FieldType ftTemp = fts.get(0);
			int h = ftTemp.getHeight();
			if (h>0){
				trTitle.setHeight((short)h);
			}
		}
		//trTitle.setHeight((short) 18);
		for (int i = 0; i < ftsLen; i++) {
			FieldType ft = fts.get(i);
			// ���ӵ�Ԫ��,������Ԫ�����
			int width = ft.getWidth();
			if (width>0){
				sheet.setColumnWidth(i, width);
				sheet.setDefaultColumnStyle(i, getTdStyle(wb));
			}
			Cell titleCell = trTitle.createCell(i);
			titleCell.setCellStyle(getThStyle(wb));
			titleCell.setCellValue(ft.getTitle());
		}
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			int j = 2;
			int m = 0;

			while (rs.next()) {
				// ����������
				Row row = sheet.createRow(j);
				//row.setRowStyle(getTdStyle(wb));
				if (ftsLen>0){
					FieldType ftTemp = fts.get(0);
					int h = ftTemp.getHeight();
					if (h>0){
						row.setHeight((short)h);
					}
				}
				//row.setHeight((short) 18);
				for (int i = 0; i < ftsLen; i++) {
					FieldType ft = fts.get(i);
					// ���ӵ�Ԫ��,������Ԫ��ֵ
					String type = ft.getType();
					if (FieldType.TYPE_STRING.equals(type)) {
						row.createCell(i).setCellValue(rs.getString(ft.getName()));
					} else if (FieldType.TYPE_CODE.equals(type)) {
						String codeName = ft.getExpInfo();
						if (codeName != null && !"".equals(codeName)) {
							CodeList codeList = codeLists.get(codeName);
							String codeValue = rs.getString(ft.getName());
							if (codeValue == null) {
								row.createCell(i).setCellValue("");
							} else if (codeList == null) {
								row.createCell(i).setCellValue(codeValue);
							} else {
								Code code = codeList.getCodeByValue(codeValue);
								if (code != null) {
									row.createCell(i).setCellValue(code.getName());
								} else {
									row.createCell(i).setCellValue(codeValue);
								}

							}
						} else {
							row.createCell(i).setCellValue(rs.getString(ft.getName()));
						}

					} else if (FieldType.TYPE_DATE.equals(type)) {
						Data d = new Data();
						d.add("KEY", rs.getObject(ft.getName()));
						row.createCell(i).setCellValue(d.getDate("KEY"));
					} else if (FieldType.TYPE_DATETIME.equals(type)) {
						Data d = new Data();
						d.add("KEY", rs.getObject(ft.getName()));
						row.createCell(i).setCellValue(d.getDateTime("KEY"));
					} else if (FieldType.TYPE_INT.equals(type)) {
						row.createCell(i).setCellValue(rs.getInt(ft.getName()));
					} else {
						row.createCell(i).setCellValue(rs.getString(ft.getName()));
					}
				}
				j++;
				m++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		}
		wb.write(out);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO �Զ����ɵķ������

	}

}
