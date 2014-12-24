/*****************��ռ�ͥ�ļ���ر���Ϣbegin ******************/
/* Table: FFS_AF_INFO          01.�����ļ���Ϣ��      */
DELETE FROM FFS_AF_INFO;
/* Table: FFS_AF_ADDITIONAL    02.�����ļ�������Ϣ��      */
DELETE FROM FFS_AF_ADDITIONAL;
/* Table: FFS_AF_TRANSLATION   03.�ļ������¼��      */
DELETE FROM FFS_AF_TRANSLATION;
/* Table: FFS_AF_AUDIT         04.�ļ���˼�¼��      */
DELETE FROM FFS_AF_AUDIT;
/* Table: FFS_AF_PAUSE         06.�ļ���ͣ��¼��      */
DELETE FROM FFS_AF_PAUSE;
/* Table: FFS_AF_REVISE        09.�ļ��޸ļ�¼��      */
DELETE FROM FFS_AF_REVISE;
/* Table: FFS_AF_SEQNO         10.�ļ���ˮ�ż�¼��      */
DELETE FROM FFS_AF_SEQNO;
/* Table: FFS_AF_FILENO        11.�ļ����ı�ż�¼��      */
DELETE FROM FFS_AF_FILENO;
/* Table: RFM_AF_REVOCATION    12.�����ļ����ļ�¼��      */
DELETE FROM RFM_AF_REVOCATION;
/*****************��ռ�ͥ�ļ���ر���Ϣend *********************/

/*****************�������Ԥ����ر���Ϣbegin********************/
/* Table: SCE_PUB_RECORD       01.�����ͯ������¼��      */
DELETE FROM SCE_PUB_RECORD;
/* Table: SCE_PUB_PLAN         02.�����ͯ�����ƻ���      */
DELETE FROM SCE_PUB_PLAN;
/* Table: SCE_REQ_INFO         03.����Ԥ��������Ϣ��      */
DELETE FROM SCE_REQ_INFO;
/* Table: SCE_REQ_ADUIT        04.����Ԥ��������˼�¼��      */
DELETE FROM SCE_REQ_ADUIT;
/* Table: SCE_REQ_ADDITIONAL   05.����Ԥ�����벹����Ϣ��      */
DELETE FROM SCE_REQ_ADDITIONAL;
/* Table: SCE_REQ_DEFERRED     06.�������������¼��      */
DELETE FROM SCE_REQ_DEFERRED;
/* Table: SCE_REQ_REMINDER     07.����Ԥ���߰�֪ͨ��¼��      */
DELETE FROM SCE_REQ_REMINDER;
/* Table: SCE_REQ_TRANSLATION  08.����Ԥ�����뷭���¼��      */
DELETE FROM SCE_REQ_TRANSLATION;
/* Table: SCE_PUB_PLAN_SEQNO   10.�����ƻ����ż�¼��      */
DELETE FROM SCE_PUB_PLAN_SEQNO;
/* Table: SCE_REQ_SEQNO        11.Ԥ�������ż�¼��      */
DELETE FROM SCE_REQ_SEQNO;
/*****************�������Ԥ����ر���Ϣend***********************/

/*****************��ս�����ر���Ϣbegin************************/
/* Table: TRANSFER_INFO        07.���ӵ���Ϣ��      */
DELETE FROM TRANSFER_INFO;
/* Table: TRANSFER_INFO_DETAIL 08.������ϸ��      */
DELETE FROM TRANSFER_INFO_DETAIL;
/* Table: TRANSFER_CONNECT_NO  09.���ӵ���ˮ�ż�¼��     */
DELETE FROM TRANSFER_CONNECT_NO;
/*****************��ս�����ر���Ϣend**************************/

/*****************��շ�����ر���Ϣbegin************************/
/* Table: FAM_CHEQUE_INFO        01.Ʊ�ݵǼ���Ϣ��      */
DELETE FROM FAM_CHEQUE_INFO;
/* Table: FAM_ACCOUNT_LOG        03.����˻�������¼��      */
DELETE FROM FAM_ACCOUNT_LOG;
/* Table: FAM_COST_REMINDER      04.���ô߽�֪ͨ��¼��     */
DELETE FROM FAM_COST_REMINDER;
/* Table: FAM_CHEQUE_COLLECTION  05.Ʊ�����յ���¼��      */
DELETE FROM FAM_CHEQUE_COLLECTION;
/* Table: FAM_CHEQUE_PAYNO      06.�ɷѱ�ż�¼��     */
DELETE FROM FAM_CHEQUE_PAYNO;
/*****************��շ�����ر���Ϣend**************************/

/*****************��ն�ͯ������ر���Ϣbegin*********************/
/*01.��ͯ������Ϣ��*/
DELETE FROM CMS_CI_INFO;
/*02.��ͯ���ϲ�����Ϣ��*/
DELETE FROM CMS_CI_ADDITIONAL;
/*03.��ͯ������˼�¼��*/
DELETE FROM CMS_CI_ADUIT;
/*04.��ͯ���Ϸ����¼��*/
DELETE FROM CMS_CI_TRANSLATION;
/*05.��ͯ���ϸ��¼�¼��*/
DELETE FROM CMS_CI_UPDATE_INFO;
/*06.��ͯ���ϸ�����ϸ��*/
DELETE FROM CMS_CI_UPDATE_DETAIL;
/*07.��ͯ���ϸ�����˼�¼��*/
DELETE FROM CMS_CI_UPDATE_ADUIT;
/*09.��ͯ��ż�¼��*/
DELETE FROM CMS_CI_CHILDNO;
/*10.��ͯ�����˲��ϼ�¼��*/
DELETE FROM RFM_CI_REVOCATION;
/*****************��ն�ͯ������ر���Ϣend*********************/

/******************���ƥ�������Ϣbegin***********************/
/*Table:NCM_MATCH_INFO  ��ͥƥ����Ϣ��*/
delete from NCM_MATCH_INFO;
/*Table:NCM_MATCH_AUDIT  ƥ����˼�¼��*/
delete from NCM_MATCH_AUDIT;
/*Table:NCM_ARCHIVE_INFO  ��������������Ϣ��*/
delete from NCM_ARCHIVE_INFO;
/*Table:NCM_COUNTRY_SIGN_SN  ǩ���ż�¼��_1*/
delete from NCM_COUNTRY_SIGN_SN;
/*Table:NCM_NOTICE_YEAR_SN  ǩ���ż�¼��_2*/
delete from NCM_NOTICE_YEAR_SN;
/*Table:NCM_ARCHIVE_NO  �����ż�¼��*/
delete from NCM_ARCHIVE_NO;
/******************���ƥ�������Ϣend************************/

/******************��������Ǽ������Ϣbegin******************/
/*Table:FAR_APPOINTMENT_RECORD  ����ԤԼ�����¼��*/
delete from FAR_APPOINTMENT_RECORD;
/*Table:FAR_REGISTRATION_SN  �����Ǽ�֤�ż�¼��*/
delete from FAR_REGISTRATION_SN;
/******************��������Ǽ������Ϣend********************/

/*��հ��ú󱨸������Ϣbegin*/
/*Table:PFR_FEEDBACK_INFO  ���ú󱨸���Ϣ��*/
delete from PFR_FEEDBACK_INFO;
/*Table:PFR_FEEDBACK_RECORD  ���ú󱨸��¼��*/
delete from PFR_FEEDBACK_RECORD;
/*Table:PFR_FEEDBACK_ADDITONAL  ���ú󱨸油����Ϣ��*/
delete from PFR_FEEDBACK_ADDITONAL;
/*Table:PFR_FEEDBACK_AUDIT  ���ú󱨸���˼�¼��*/
delete from PFR_FEEDBACK_AUDIT;
/*Table:PFR_FEEDBACK_TRANSLATION  ���ú󱨸淭���¼��*/
delete from PFR_FEEDBACK_TRANSLATION;
/*��հ��ú󱨸������Ϣend*/

/*������ ATT_AR*/
delete from ATT_AR;
