/*****************清空家庭文件相关表信息begin ******************/
/* Table: FFS_AF_INFO          01.收养文件信息表      */
DELETE FROM FFS_AF_INFO;
/* Table: FFS_AF_ADDITIONAL    02.收养文件补充信息表      */
DELETE FROM FFS_AF_ADDITIONAL;
/* Table: FFS_AF_TRANSLATION   03.文件翻译记录表      */
DELETE FROM FFS_AF_TRANSLATION;
/* Table: FFS_AF_AUDIT         04.文件审核记录表      */
DELETE FROM FFS_AF_AUDIT;
/* Table: FFS_AF_PAUSE         06.文件暂停记录表      */
DELETE FROM FFS_AF_PAUSE;
/* Table: FFS_AF_REVISE        09.文件修改记录表      */
DELETE FROM FFS_AF_REVISE;
/* Table: FFS_AF_SEQNO         10.文件流水号记录表      */
DELETE FROM FFS_AF_SEQNO;
/* Table: FFS_AF_FILENO        11.文件收文编号记录表      */
DELETE FROM FFS_AF_FILENO;
/* Table: RFM_AF_REVOCATION    12.收养文件退文记录表      */
DELETE FROM RFM_AF_REVOCATION;
/*****************清空家庭文件相关表信息end *********************/

/*****************清空特需预批相关表信息begin********************/
/* Table: SCE_PUB_RECORD       01.特需儿童发布记录表      */
DELETE FROM SCE_PUB_RECORD;
/* Table: SCE_PUB_PLAN         02.特需儿童发布计划表      */
DELETE FROM SCE_PUB_PLAN;
/* Table: SCE_REQ_INFO         03.特需预批申请信息表      */
DELETE FROM SCE_REQ_INFO;
/* Table: SCE_REQ_ADUIT        04.特需预批申请审核记录表      */
DELETE FROM SCE_REQ_ADUIT;
/* Table: SCE_REQ_ADDITIONAL   05.特需预批申请补充信息表      */
DELETE FROM SCE_REQ_ADDITIONAL;
/* Table: SCE_REQ_DEFERRED     06.交文延期申请记录表      */
DELETE FROM SCE_REQ_DEFERRED;
/* Table: SCE_REQ_REMINDER     07.特需预批催办通知记录表      */
DELETE FROM SCE_REQ_REMINDER;
/* Table: SCE_REQ_TRANSLATION  08.特需预批申请翻译记录表      */
DELETE FROM SCE_REQ_TRANSLATION;
/* Table: SCE_PUB_PLAN_SEQNO   10.发布计划批号记录表      */
DELETE FROM SCE_PUB_PLAN_SEQNO;
/* Table: SCE_REQ_SEQNO        11.预批申请编号记录表      */
DELETE FROM SCE_REQ_SEQNO;
/*****************清空特需预批相关表信息end***********************/

/*****************清空交接相关表信息begin************************/
/* Table: TRANSFER_INFO        07.交接单信息表      */
DELETE FROM TRANSFER_INFO;
/* Table: TRANSFER_INFO_DETAIL 08.交接明细表      */
DELETE FROM TRANSFER_INFO_DETAIL;
/* Table: TRANSFER_CONNECT_NO  09.交接单流水号记录表     */
DELETE FROM TRANSFER_CONNECT_NO;
/*****************清空交接相关表信息end**************************/

/*****************清空费用相关表信息begin************************/
/* Table: FAM_CHEQUE_INFO        01.票据登记信息表      */
DELETE FROM FAM_CHEQUE_INFO;
/* Table: FAM_ACCOUNT_LOG        03.余额账户操作记录表      */
DELETE FROM FAM_ACCOUNT_LOG;
/* Table: FAM_COST_REMINDER      04.费用催缴通知记录表     */
DELETE FROM FAM_COST_REMINDER;
/* Table: FAM_CHEQUE_COLLECTION  05.票据托收单记录表      */
DELETE FROM FAM_CHEQUE_COLLECTION;
/* Table: FAM_CHEQUE_PAYNO      06.缴费编号记录表     */
DELETE FROM FAM_CHEQUE_PAYNO;
/*****************清空费用相关表信息end**************************/

/*****************清空儿童材料相关表信息begin*********************/
/*01.儿童材料信息表*/
DELETE FROM CMS_CI_INFO;
/*02.儿童材料补充信息表*/
DELETE FROM CMS_CI_ADDITIONAL;
/*03.儿童材料审核记录表*/
DELETE FROM CMS_CI_ADUIT;
/*04.儿童材料翻译记录表*/
DELETE FROM CMS_CI_TRANSLATION;
/*05.儿童材料更新记录表*/
DELETE FROM CMS_CI_UPDATE_INFO;
/*06.儿童材料更新明细表*/
DELETE FROM CMS_CI_UPDATE_DETAIL;
/*07.儿童材料更新审核记录表*/
DELETE FROM CMS_CI_UPDATE_ADUIT;
/*09.儿童编号记录表*/
DELETE FROM CMS_CI_CHILDNO;
/*10.儿童材料退材料记录表*/
DELETE FROM RFM_CI_REVOCATION;
/*****************清空儿童材料相关表信息end*********************/

/******************清空匹配相关信息begin***********************/
/*Table:NCM_MATCH_INFO  家庭匹配信息表*/
delete from NCM_MATCH_INFO;
/*Table:NCM_MATCH_AUDIT  匹配审核记录表*/
delete from NCM_MATCH_AUDIT;
/*Table:NCM_ARCHIVE_INFO  涉外收养档案信息表*/
delete from NCM_ARCHIVE_INFO;
/*Table:NCM_COUNTRY_SIGN_SN  签批号记录表_1*/
delete from NCM_COUNTRY_SIGN_SN;
/*Table:NCM_NOTICE_YEAR_SN  签批号记录表_2*/
delete from NCM_NOTICE_YEAR_SN;
/*Table:NCM_ARCHIVE_NO  档案号记录表*/
delete from NCM_ARCHIVE_NO;
/******************清空匹配相关信息end************************/

/******************清空收养登记相关信息begin******************/
/*Table:FAR_APPOINTMENT_RECORD  来华预约申请记录表*/
delete from FAR_APPOINTMENT_RECORD;
/*Table:FAR_REGISTRATION_SN  收养登记证号记录表*/
delete from FAR_REGISTRATION_SN;
/******************清空收养登记相关信息end********************/

/*清空安置后报告相关信息begin*/
/*Table:PFR_FEEDBACK_INFO  安置后报告信息表*/
delete from PFR_FEEDBACK_INFO;
/*Table:PFR_FEEDBACK_RECORD  安置后报告记录表*/
delete from PFR_FEEDBACK_RECORD;
/*Table:PFR_FEEDBACK_ADDITONAL  安置后报告补充信息表*/
delete from PFR_FEEDBACK_ADDITONAL;
/*Table:PFR_FEEDBACK_AUDIT  安置后报告审核记录表*/
delete from PFR_FEEDBACK_AUDIT;
/*Table:PFR_FEEDBACK_TRANSLATION  安置后报告翻译记录表*/
delete from PFR_FEEDBACK_TRANSLATION;
/*清空安置后报告相关信息end*/

/*附件表 ATT_AR*/
delete from ATT_AR;
