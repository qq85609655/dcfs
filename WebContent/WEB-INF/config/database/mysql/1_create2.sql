CREATE TABLE IM_MESSAGE
(
   ID                   VARCHAR(64) NOT NULL,
   SENDER               VARCHAR(64) NOT NULL,
   SENDER_DEPT          VARCHAR(64),
   RECEIVER             VARCHAR(64) NOT NULL,
   RECEIVER_DEPT        VARCHAR(64),
   SEND_TIME            TIMESTAMP,
   SEND_YEAR            INT,
   SEND_MONTH           INT,
   SEND_DAY             INT,
   SENDER_IP            VARCHAR(20),
   RECEIVER_IP          VARCHAR(20),
   SESSION_CATALOG      VARCHAR(1) COMMENT '1 ��ͨ��Ϣ 2 ������Ϣ',
   SESSION_TYPE         VARCHAR(1) NOT NULL COMMENT '1��1��1��   2��Ⱥ��',
   SESSION_SEC_LEVEL    INT COMMENT '�ܼ����뼯',
   MSG_TYPE             VARCHAR(1) NOT NULL COMMENT '1������ 2 �ļ�����',
   MSG_CONTENT          VARCHAR(1000) COMMENT '�ļ�����ʱ��Ϊ�ļ�·��',
   ATT_ID               VARCHAR(64),
   ATT_SECURITY_LEVEL   INT,
   ATT_SECURITY_LEVEL_NAME VARCHAR(50),
   ATT_PROTECT_PERIOD   INT COMMENT '��λ���£��Ӵ���ʱ�俪ʼ����',
   ATT_PROTECT_PERIOD_NAME VARCHAR(50),
   RECEIVE_FLAG         VARCHAR(1) NOT NULL COMMENT '0 δ����  1 �ѽ���',
   CHAT_GROUP_ID        VARCHAR(100) COMMENT 'Ⱥ��Ựʱ��Ч'
);

ALTER TABLE IM_MESSAGE
   ADD PRIMARY KEY (ID);

CREATE TABLE IM_MESSAGE_ARCHIVE
(
   ID                   VARCHAR(64) NOT NULL,
   SENDER               VARCHAR(64) NOT NULL,
   SENDER_DEPT          VARCHAR(64),
   RECEIVER             VARCHAR(64) NOT NULL,
   RECEIVER_DEPT        VARCHAR(64),
   SEND_TIME            TIMESTAMP,
   SEND_YEAR            INT,
   SEND_MONTH           INT,
   SEND_DAY             INT,
   SENDER_IP            VARCHAR(20),
   RECEIVER_IP          VARCHAR(20),
   SESSION_CATALOG      VARCHAR(1) COMMENT '1 ��ͨ��Ϣ 2 ������Ϣ',
   SESSION_TYPE         VARCHAR(1) NOT NULL COMMENT '1��1��1��   2��Ⱥ��',
   SESSION_SEC_LEVEL    INT COMMENT '�ܼ����뼯',
   MSG_TYPE             VARCHAR(1) NOT NULL COMMENT '1������ 2 �ļ�����',
   MSG_CONTENT          VARCHAR(1000) COMMENT '�ļ�����ʱ��Ϊ�ļ�·��',
   ATT_ID               VARCHAR(64),
   ATT_SECURITY_LEVEL   INT,
   ATT_SECURITY_LEVEL_NAME VARCHAR(50),
   ATT_PROTECT_PERIOD   INT COMMENT '��λ���£��Ӵ���ʱ�俪ʼ����',
   ATT_PROTECT_PERIOD_NAME VARCHAR(50),
   RECEIVE_FLAG         VARCHAR(1) NOT NULL COMMENT '0 δ����  1 �ѽ���',
   CHAT_GROUP_ID        VARCHAR(100) COMMENT 'Ⱥ��Ựʱ��Ч'
);

ALTER TABLE IM_MESSAGE_ARCHIVE COMMENT '����ʷ����ת�ƹ����ĳ�����Ϣ��¼';

ALTER TABLE IM_MESSAGE_ARCHIVE
   ADD PRIMARY KEY (ID);

CREATE TABLE IM_MESSAGE_HISTORY
(
   ID                   VARCHAR(64) NOT NULL,
   SENDER               VARCHAR(64) NOT NULL,
   SENDER_DEPT          VARCHAR(64),
   RECEIVER             VARCHAR(64) NOT NULL,
   RECEIVER_DEPT        VARCHAR(64),
   SEND_TIME            TIMESTAMP,
   SEND_YEAR            INT,
   SEND_MONTH           INT,
   SEND_DAY             INT,
   SENDER_IP            VARCHAR(20),
   RECEIVER_IP          VARCHAR(20),
   SESSION_CATALOG      VARCHAR(1) COMMENT '1 ��ͨ��Ϣ 2 ������Ϣ',
   SESSION_TYPE         VARCHAR(1) NOT NULL COMMENT '1��1��1��   2��Ⱥ��',
   SESSION_SEC_LEVEL    INT COMMENT '�ܼ����뼯',
   MSG_TYPE             VARCHAR(1) NOT NULL COMMENT '1������ 2 �ļ�����',
   MSG_CONTENT          VARCHAR(1000) COMMENT '�ļ�����ʱ��Ϊ�ļ�·��',
   ATT_ID               VARCHAR(64),
   ATT_SECURITY_LEVEL   INT,
   ATT_SECURITY_LEVEL_NAME VARCHAR(50),
   ATT_PROTECT_PERIOD   INT COMMENT '��λ���£��Ӵ���ʱ�俪ʼ����',
   ATT_PROTECT_PERIOD_NAME VARCHAR(50),
   RECEIVE_FLAG         VARCHAR(1) NOT NULL COMMENT '0 δ����  1 �ѽ���',
   CHAT_GROUP_ID        VARCHAR(100) COMMENT 'Ⱥ��Ựʱ��Ч'
);

ALTER TABLE IM_MESSAGE_HISTORY COMMENT '��Ϣ����������ѽ��յļ�¼';

ALTER TABLE IM_MESSAGE_HISTORY
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ACCOUNT
(
   ACCOUNT_ID           VARCHAR(254) NOT NULL,
   PERSON_ID            VARCHAR(64) NOT NULL,
   PASSWORD             VARCHAR(254) NOT NULL,
   ACCOUNT_TYPE         VARCHAR(1) NOT NULL COMMENT '0,��ʱ 1,��ͨ�û� 2,guest�û�
            
            ',
   STATUS               VARCHAR(1) NOT NULL COMMENT '1,���� 2,ϵͳ����(���������̫��) 3 ɾ�� 4 �˹�����(����Ա����)',
   PASS_QUESTION        VARCHAR(254),
   PASS_ANSWER          VARCHAR(254),
   ACCOUNT_TTL          DATE,
   LOGIN_FAIL_NUM       INT NOT NULL,
   LAST_LOGIN_IP        VARCHAR(30),
   LAST_LOGIN_DATE      TIMESTAMP,
   CREATE_TIME          TIMESTAMP,
   PASS_LAST_CHG_TIME   TIMESTAMP NOT NULL,
   DEFAULT_APP          VARCHAR(64) COMMENT 'Ĭ��Ӧ��',
   AUTH_TYPE            VARCHAR(1) COMMENT '1 ���� �� 2 ����+��������  ������󶨣�ʹ������֤ ',
   IS_CHANGED_PWD       VARCHAR(1) COMMENT '1 �� 0 ��',
   ORGAN_TYPE           VARCHAR(100),
   ORGAN_RIGHT          VARCHAR(64) COMMENT 'ѡ����֯����Աʱ����ѡ��Ķ�����֯��ֻ��ѡ����֯�����µ�'
);

ALTER TABLE PUB_ACCOUNT
   ADD PRIMARY KEY (ACCOUNT_ID);

CREATE TABLE PUB_ACCOUNT_TYPE
(
   ID                 VARCHAR(64) NOT NULL,
   TYPE_CODE            VARCHAR(100) NOT NULL COMMENT 'Ψһ',
   CNAME                VARCHAR(100) NOT NULL,
   MEMO                 VARCHAR(200),
   EXT_METADATA         VARCHAR(1000) COMMENT 'xml',
   TYPE_EXT_VALUES      VARCHAR(1000) COMMENT 'xml'
);

ALTER TABLE PUB_ACCOUNT_TYPE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ADMIN
(
   ID                   VARCHAR(64) NOT NULL,
   PERSON_ID            VARCHAR(64) NOT NULL,
   ADMIN_TYPE           CHAR(1) COMMENT '0 ��������Ա����֯����Ա����ͨ��ɫ�������ɫ����Ȩ��Ӧ�á�ģ�顢��Դ���˵���
            1 ����Ա����֯����Ա����ͨ��ɫ�������ɫ�� 
            2 ����Ա����Ȩ��ͨ��ɫ��
            3 ���Ա����Ϊ��־��ϵͳ������־��ϵͳ������־����Ȩ���Ա��
            
            9 �Զ������Ա',
   MEMO                 VARCHAR(500),
   CREATE_TIME          TIMESTAMP,
   CREATOR              VARCHAR(64)
);

ALTER TABLE PUB_ADMIN
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ADMIN_APP_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   PERSON_ID            VARCHAR(64) NOT NULL,
   APP_ID               VARCHAR(64) NOT NULL,
   CREATE_TIME          TIMESTAMP,
   CREATOR              VARCHAR(64)
);

ALTER TABLE PUB_ADMIN_APP_RELA COMMENT 'Ӧ��IDΪ0ʱ����ʾӵ������Ӧ�õĹ���Ȩ��';

ALTER TABLE PUB_ADMIN_APP_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ADMIN_ORGAN_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   PUB_ID               VARCHAR(64),
   PERSON_ID            VARCHAR(64) NOT NULL,
   ORGAN_ID             VARCHAR(64) NOT NULL,
   CREATE_TIME          TIMESTAMP,
   CREATOR              VARCHAR(64)
);

ALTER TABLE PUB_ADMIN_ORGAN_RELA COMMENT '����IDΪ0ʱ����ʾӵ��������֯�Ĺ���Ȩ��';

ALTER TABLE PUB_ADMIN_ORGAN_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ADMIN_ROLE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   PERSON_ID            VARCHAR(64) NOT NULL,
   ROLE_ID              VARCHAR(64) NOT NULL,
   CREATE_TIME          TIMESTAMP,
   CREATOR              VARCHAR(64)
);

ALTER TABLE PUB_ADMIN_ROLE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_APP
(
   ID                   VARCHAR(64) NOT NULL,
   APP_NAME             VARCHAR(254) NOT NULL,
   DEVELOPER            VARCHAR(254),
   VERSION              VARCHAR(20),
   URL_PREFIX           VARCHAR(254),
   MEMO                 VARCHAR(1000),
   CREATE_TIME          TIMESTAMP
);

ALTER TABLE PUB_APP
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_APP_CONTEXT
(
   ID                   VARCHAR(64) NOT NULL,
   APP_ID               VARCHAR(254) NOT NULL,
   APP_IP               VARCHAR(254),
   APP_PORT             VARCHAR(254),
   APP_CONTEXT          VARCHAR(200),
   MEMO                 VARCHAR(1000),
   CREATE_DATE          TIMESTAMP
);

ALTER TABLE PUB_APP_CONTEXT
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_APP_NAV
(
   ID                   VARCHAR(64) NOT NULL,
   APP_ID               VARCHAR(64) NOT NULL,
   NAV_NAME             VARCHAR(100) NOT NULL,
   NAV_URL              VARCHAR(1000),
   URL_PROMPT           VARCHAR(1000),
   SEQ_NUM              INT NOT NULL,
   STATUS               CHAR(1) NOT NULL COMMENT '1 ����,0 ͣ��',
   URL_PREFIX           VARCHAR(100) COMMENT 'http:ip:port/context�����ʱ��Դ�˵���url����ƴ���ϴ�ǰ׺���ⲿ�˵���ƴ��',
   HELP_FILE_PATH       VARCHAR(200)
);

ALTER TABLE PUB_APP_NAV
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_AUDIT
(
   ACT_ID               VARCHAR(64) NOT NULL,
   ACTOR_IP             VARCHAR(128) NOT NULL,
   ACTOR_ID             VARCHAR(64) COMMENT '��ԱID',
   ACTOR_NAME           VARCHAR(100) COMMENT '��������[�˺�ID]',
   ACT_TYPE             VARCHAR(128),
   ACT_ACTION           VARCHAR(50) NOT NULL,
   ACT_OBJ_TYPE         VARCHAR(50),
   ACT_OBJ              VARCHAR(1000) NOT NULL COMMENT '����������',
   ACT_RESULT           VARCHAR(50) COMMENT '�������',
   ACT_TIME             TIMESTAMP NOT NULL,
   ACT_LEVEL            INT,
   MEMO                 VARCHAR(200)
);

ALTER TABLE PUB_AUDIT
   ADD PRIMARY KEY (ACT_ID);

CREATE TABLE PUB_AUDIT_ACT_TYPE
(
   ID                   VARCHAR(10) NOT NULL,
   CNAME                VARCHAR(100),
   MEMO                 VARCHAR(200)
);

ALTER TABLE PUB_AUDIT_ACT_TYPE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_AUDIT_ARCHIVE
(
   ACT_ID               VARCHAR(64) NOT NULL,
   ACTOR_IP             VARCHAR(128) NOT NULL,
   ACTOR_ID             VARCHAR(64) COMMENT '��ԱID',
   ACTOR_NAME           VARCHAR(100) COMMENT '��������[�˺�ID]',
   ACT_TYPE             VARCHAR(128),
   ACT_ACTION           VARCHAR(50) NOT NULL,
   ACT_OBJ_TYPE         VARCHAR(50),
   ACT_OBJ              VARCHAR(1000) NOT NULL COMMENT '����������',
   ACT_RESULT           VARCHAR(50) COMMENT '�������',
   ACT_TIME             TIMESTAMP NOT NULL,
   ACT_LEVEL            INT,
   MEMO                 VARCHAR(200),
   ARCHIVE_ID           VARCHAR(64)
);

ALTER TABLE PUB_AUDIT_ARCHIVE
   ADD PRIMARY KEY (ACT_ID);

CREATE TABLE PUB_AUDIT_ARCHIVE_SET
(
   ID                   VARCHAR(65) NOT NULL,
   DATA_PERIOD          INT COMMENT 'ǰn����',
   DATA_TYPE            VARCHAR(10) COMMENT '���ŷָ�������id���鵵��¼��',
   SETTING_TYPE         VARCHAR(1) COMMENT '���鵵��¼�� �鵵��ɾ��',
   STATUS               VARCHAR(1) COMMENT '1 �� 0 ��',
   LAST_EXEC_TIME       TIMESTAMP,
   MIN_PERIOD           INT COMMENT '����������n������ǰ������'
);

ALTER TABLE PUB_AUDIT_ARCHIVE_SET COMMENT '��������¼���Զ�ɾ�����á��Զ��鵵����';

ALTER TABLE PUB_AUDIT_ARCHIVE_SET
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_AUDIT_CLEAR_LOG
(
   ID                   VARCHAR(64) NOT NULL,
   OPERATION_TIME       TIMESTAMP NOT NULL,
   OPERATION_TYPE       VARCHAR(1) NOT NULL COMMENT '1 �ֹ�  2 �Զ�',
   OPERATION_RESULT     VARCHAR(1) NOT NULL COMMENT '1 �ɹ� 2 ʧ��',
   DATA_HANDLE_TYPE     VARCHAR(1) COMMENT '1 �鵵  2 ɾ��',
   DATA_TYPE            VARCHAR(128) NOT NULL COMMENT '1 ϵͳ������Ϊ 2 ϵͳ���ʿ��� 3  �û���¼��Ϊ 4 Ӧ�ò�����Ϊ',
   DATA_ROW_COUNT       INT NOT NULL,
   OPERATION_PERSON     VARCHAR(64),
   MEMO                 VARCHAR(500),
   DATA_PERIOD          INT COMMENT '�鵵/ɾ���ļ�����ǰ������'
);

ALTER TABLE PUB_AUDIT_CLEAR_LOG
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_AUDIT_SYSTEM
(
   ACT_ID               VARCHAR(64) NOT NULL,
   ACTOR_IP             VARCHAR(128) NOT NULL,
   ACTOR_ID             VARCHAR(64) COMMENT '��ԱID',
   ACTOR_NAME           VARCHAR(100) COMMENT '��������[�˺�ID]',
   ACT_TYPE             VARCHAR(128),
   ACT_ACTION           VARCHAR(50) NOT NULL,
   ACT_OBJ_TYPE         VARCHAR(50),
   ACT_OBJ              VARCHAR(1000) NOT NULL COMMENT '����������',
   ACT_RESULT           VARCHAR(50) COMMENT '�������',
   ACT_TIME             TIMESTAMP NOT NULL,
   ACT_LEVEL            INT,
   MEMO                 VARCHAR(200)
);

ALTER TABLE PUB_AUDIT_SYSTEM
   ADD PRIMARY KEY (ACT_ID);

CREATE TABLE PUB_AUDIT_SYSTEM_ARCHIVE
(
   ACT_ID               VARCHAR(64) NOT NULL,
   ACTOR_IP             VARCHAR(128) NOT NULL,
   ACTOR_ID             VARCHAR(64) COMMENT '��ԱID',
   ACTOR_NAME           VARCHAR(100) COMMENT '��������[�˺�ID]',
   ACT_TYPE             VARCHAR(128),
   ACT_ACTION           VARCHAR(50) NOT NULL,
   ACT_OBJ_TYPE         VARCHAR(50),
   ACT_OBJ              VARCHAR(1000) NOT NULL COMMENT '����������',
   ACT_RESULT           VARCHAR(50) COMMENT '�������',
   ACT_TIME             TIMESTAMP NOT NULL,
   ACT_LEVEL            INT,
   MEMO                 VARCHAR(200),
   ARCHIVE_ID           VARCHAR(64)
);

ALTER TABLE PUB_AUDIT_SYSTEM_ARCHIVE
   ADD PRIMARY KEY (ACT_ID);

CREATE TABLE PUB_CLICK_COUNT
(
   ID                   VARCHAR(64) NOT NULL,
   CATALOG_ID           VARCHAR(64),
   PAGE_ID              VARCHAR(64) NOT NULL,
   START_TIME           TIMESTAMP NOT NULL,
   LAST_CLICK_TIME      TIMESTAMP,
   TOTAL_COUNT          INT NOT NULL,
   CLICK_PERSON         VARCHAR(64) NOT NULL,
   CLICK_DEPT           VARCHAR(64) NOT NULL
);

ALTER TABLE PUB_CLICK_COUNT
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_CLICK_COUNT_DETAIL
(
   ID                   VARCHAR(64) NOT NULL,
   CATALOG_ID           VARCHAR(64),
   PAGE_ID              VARCHAR(64) NOT NULL,
   CLICK_DATE           INT NOT NULL,
   CLICK_YEAR           INT NOT NULL,
   CLICK_MONTH          INT NOT NULL,
   CLICK_DAY            INT NOT NULL,
   CLICK_COUNT          INT NOT NULL,
   CLICK_PERSON         VARCHAR(64) NOT NULL,
   CLICK_DEPT           VARCHAR(64) NOT NULL
);

ALTER TABLE PUB_CLICK_COUNT_DETAIL
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_COUNT_CATALOG
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(200) NOT NULL,
   PARENT_ID            VARCHAR(64) NOT NULL COMMENT '-1 ���ڵ�',
   TYPE                 VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ҳ��',
   CREATE_TIME          TIMESTAMP,
   MEMO                 VARCHAR(200),
   SEQ_NUM              INT
);

ALTER TABLE PUB_COUNT_CATALOG
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_EXT_INFO
(
   EXT_TYPE_ID          VARCHAR(50) NOT NULL COMMENT 'ORGAN:��֯��PERSON���ˣ�ACCOUNT���˺�',
   EXT_META_INFO        VARCHAR(3000)
);

ALTER TABLE PUB_EXT_INFO
   ADD PRIMARY KEY (EXT_TYPE_ID);

CREATE TABLE PUB_LOG
(
   LOG_ID               VARCHAR(64) NOT NULL,
   LOG_TIME             TIMESTAMP NOT NULL,
   LOG_WRITOR           VARCHAR(50) NOT NULL,
   LOG_TYPE             VARCHAR(30),
   LOG_LEVEL            VARCHAR(30) NOT NULL,
   LOG_SOURCE           VARCHAR(50) NOT NULL,
   LOG_MESSAGE          VARCHAR(200) NOT NULL
);

ALTER TABLE PUB_LOG
   ADD PRIMARY KEY (LOG_ID);

CREATE TABLE PUB_LOG_SYSTEM
(
   LOG_ID               VARCHAR(64) NOT NULL,
   ACTOR_IP             VARCHAR(18),
   ACTOR_ID             VARCHAR(64) NOT NULL,
   ACTOR_NAME           VARCHAR(64),
   MODULE_ID            VARCHAR(64),
   RESOURCE_ID          VARCHAR(64),
   RESOURCE_URL         VARCHAR(1024),
   ACCESS_TIME          TIMESTAMP NOT NULL,
   MEMO                 VARCHAR(200),
   LOG_LEVEL            INT
);

ALTER TABLE PUB_LOG_SYSTEM COMMENT '��¼��ϵͳ�����з���
��־����
  �Ƿ�����-1

��Դ����';

ALTER TABLE PUB_LOG_SYSTEM
   ADD PRIMARY KEY (LOG_ID);

CREATE TABLE PUB_MENU
(
   MENU_ID              VARCHAR(64) NOT NULL,
   NAV_ID               VARCHAR(64) NOT NULL,
   MENU_NAME            VARCHAR(100) NOT NULL,
   MENU_TYPE            VARCHAR(1) NOT NULL COMMENT '��Դ�˵����ⲿurl',
   MODULE_ID            VARCHAR(64),
   RES_ID               VARCHAR(64),
   PARENT_ID            VARCHAR(64),
   SEQ_NUM              INT NOT NULL,
   MENU_URL             VARCHAR(254),
   TARGET               VARCHAR(64),
   IS_LEFT              VARCHAR(1) COMMENT '1 �� 0 ��',
   IS_MODULE_ENTRY      VARCHAR(1) NOT NULL COMMENT '��????������ʾʱ���Ƿ����Ҳ�����򿪸ò˵���URL',
   CREATOR              VARCHAR(64),
   CREATE_TIME          TIMESTAMP,
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ����,0 ͣ��',
   PAGE_SCROLL          VARCHAR(1) COMMENT '���뼯 ',
   HELP_FILE_PATH       VARCHAR(200)
);

ALTER TABLE PUB_MENU COMMENT '�˵����ͣ�1 ��Դ�˵���2 �ⲿurl
�˵�������ʾ���򣺽���frame��id
״̬��1:��Ч��';

ALTER TABLE PUB_MENU
   ADD PRIMARY KEY (MENU_ID);

CREATE TABLE PUB_MODULE
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'ȫ��Ψһ',
   APP_ID               VARCHAR(64),
   CNAME                VARCHAR(254) NOT NULL,
   ENNAME               VARCHAR(254) NOT NULL,
   PMOUDLE              VARCHAR(64),
   NEED_RIGHT           CHAR(1) NOT NULL,
   ADMIN_FLAG           CHAR(1),
   STATUS               CHAR(1) NOT NULL COMMENT '1 ����,0 ͣ��',
   CREATE_TIME          TIMESTAMP,
   MEMO                 VARCHAR(254)
);

ALTER TABLE PUB_MODULE COMMENT 'ģ���Ƿ���ã��Ƿ���ҪȨ�޿��ƣ��Ƿ�ɹ���1/0';

ALTER TABLE PUB_MODULE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORGAN
(
   ID                   VARCHAR(64) NOT NULL,
   PUB_ID               INT,
   CNAME                VARCHAR(254) NOT NULL,
   SHORT_CNAME          VARCHAR(100),
   ORG_CODE             VARCHAR(254),
   ENNAME               VARCHAR(254),
   ORG_TYPE             INT NOT NULL,
   ORG_GRADE            VARCHAR(20),
   ORG_LEVEL            INT,
   PARENT_ID            VARCHAR(64) NOT NULL DEFAULT '0' COMMENT '������֯ʱ��ȡֵ 0',
   ORG_PHONE            VARCHAR(21),
   ORG_ADDR             VARCHAR(100),
   ORG_EMAIL            VARCHAR(50),
   ORG_DOOR_NUM         VARCHAR(100),
   ORG_LEVEL_CODE       VARCHAR(254) COMMENT 'ÿ��λ����һ��,�ܹ�֧��63��,63��֮����Ϊ��ͬһ��(63��).',
   SEQ_NUM              INT NOT NULL,
   STATUS               VARCHAR(1) NOT NULL COMMENT '1----���� 2----���� 3----ɾ��',
   MEMO                 VARCHAR(254),
   RESP_PERSON          VARCHAR(64),
   LINK_MAN             VARCHAR(200),
   EXT_INFO             VARCHAR(2000) COMMENT '�����Զ�����չ��Ϣ',
   AREA_CODE            VARCHAR(6),
   EXTEND_PROPS         VARCHAR(3000)
);

ALTER TABLE PUB_ORGAN COMMENT '״̬:1����';

ALTER TABLE PUB_ORGAN
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORGAN_TYPE
(
   ID                   INT NOT NULL,
   TYPE_CODE            VARCHAR(50) NOT NULL,
   CNAME                VARCHAR(200) NOT NULL,
   IS_RESERVED          VARCHAR(1) NOT NULL COMMENT '1 ���ã�0 ������',
   CREATE_TIME          TIMESTAMP,
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ��Ч 2 ���� 3 ɾ��',
   MEMO                 VARCHAR(500)
);

ALTER TABLE PUB_ORGAN_TYPE COMMENT '����ID:
1����֯
-1��Ŀ¼

״̬��1:��Ч��2 ���� 3 ɾ��';

ALTER TABLE PUB_ORGAN_TYPE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORG_APP_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ORG_ID               VARCHAR(64),
   APP_ID               VARCHAR(64)
);

ALTER TABLE PUB_ORG_APP_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORG_GRADE_ROLE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ORG_ID               VARCHAR(64),
   PG_ID                VARCHAR(64),
   ROLE_ID              VARCHAR(64)
);

ALTER TABLE PUB_ORG_GRADE_ROLE_RELA COMMENT '��֯ID��ְ��������֯���������Ȩ��ʱ������֯��������ֵΪ 0';

ALTER TABLE PUB_ORG_GRADE_ROLE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORG_PERSON_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ORG_ID               VARCHAR(64),
   PERSON_ID            VARCHAR(64),
   IS_BELONG            CHAR(1) COMMENT '1 �ǣ�0 ��',
   POST                 VARCHAR(64)
);

ALTER TABLE PUB_ORG_PERSON_RELA COMMENT 'ְ�񣺱��һ��������һ����һ��
ְ������ѡ��';

ALTER TABLE PUB_ORG_PERSON_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ORG_ROLE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ORG_ID               VARCHAR(64),
   ROLE_ID              VARCHAR(64)
);

ALTER TABLE PUB_ORG_ROLE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_PERSON
(
   PERSON_ID            VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(254) NOT NULL,
   ENNAME               VARCHAR(254),
   PERSON_CODE          VARCHAR(254),
   FIRST_NAME           VARCHAR(254),
   LAST_NAME            VARCHAR(254),
   CNAME_SHORT_SPELL    VARCHAR(10),
   CNAME_FULL_SPELL     VARCHAR(20),
   CARD_NUM             VARCHAR(50),
   CARD_CODE            VARCHAR(2),
   SEX                  VARCHAR(1) COMMENT '0,���� 1,�� 2,Ů 3,δ֪',
   BIRTHDAY             DATE COMMENT '2010-10-10',
   NATION               VARCHAR(64),
   MARRY_CODE           VARCHAR(1),
   POLITIC_CODE         VARCHAR(1),
   POST_LEVEL           VARCHAR(64) COMMENT '��ѡ',
   OFFICE_TEL           VARCHAR(64),
   OFFICE_FAX           VARCHAR(64),
   MOBILE               VARCHAR(128),
   EMAIL                VARCHAR(128),
   NATIVE_PLACE         VARCHAR(254),
   COUNTRY              VARCHAR(64),
   PROVINCE_ID          VARCHAR(64),
   CITY_ID              VARCHAR(10),
   CONNECT_ADDR         VARCHAR(254),
   ZIP                  VARCHAR(6),
   SEQ_NUM              INT NOT NULL,
   ROOM_NUM             VARCHAR(20),
   SECURITY_LEVEL       INT,
   RESP_DEPT            VARCHAR(1024) COMMENT '�������ŵ�id������ö��ŷָ�',
   PERSON_STATUS        VARCHAR(1) COMMENT '1,���� 3 ɾ�� ',
   EXTEND_PROPS         VARCHAR(3000),
   PERSON_TYPE          VARCHAR(1)
);

ALTER TABLE PUB_PERSON
   ADD PRIMARY KEY (PERSON_ID);

CREATE TABLE PUB_PERSON_APP_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   PERSON_ID            VARCHAR(64),
   APP_ID               VARCHAR(64) NOT NULL
);

ALTER TABLE PUB_PERSON_APP_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_PERSON_EXT
(
   PERSON_ID            VARCHAR(64) NOT NULL,
   DEGREE_CODE          VARCHAR(2),
   EDU_CODE             VARCHAR(2),
   OTHER_INFO           VARCHAR(254),
   HOME_FAX             VARCHAR(64),
   HOME_TEL             VARCHAR(64),
   MSN                  VARCHAR(128),
   QQ                   VARCHAR(128),
   HOME_PAGE            VARCHAR(128),
   IS_IMP_CONTACT       VARCHAR(1) COMMENT '1 �� 0 ��',
   EXT_INFO             VARCHAR(2000) COMMENT '�����Զ�����չ��Ϣ',
   SIGNATURE            LONGBLOB COMMENT '����',
   SIGNATURE_FILE_ID    VARCHAR(64) COMMENT '���� FRAMEWORK_COMMON ����������',
   PHOTO_FILE_ID        VARCHAR(64) COMMENT '���� FRAMEWORK_COMMON ����������'
);

ALTER TABLE PUB_PERSON_EXT
   ADD PRIMARY KEY (PERSON_ID);

CREATE TABLE PUB_PERSON_ROLE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   PERSON_ID            VARCHAR(64),
   ROLE_ID              VARCHAR(64) NOT NULL
);

ALTER TABLE PUB_PERSON_ROLE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POLICY_ACCOUNT_PWD
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(100),
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ͣ��',
   MEMO                 VARCHAR(200),
   MIN_LENGTH           INT NOT NULL COMMENT '0 ��Ч',
   MAX_LENGTH           INT COMMENT '0 ��Ч',
   CHANGE_PERIOD        INT NOT NULL COMMENT '0 ��Ч',
   LOGIN_RETRY_MAX_NUM  INT NOT NULL COMMENT '0 ��Ч',
   RULE_REGULAR_STR     VARCHAR(100),
   RULE_NAME            VARCHAR(100),
   DEFAULT_PWD          VARCHAR(100) COMMENT '���ڼ����û��Ƿ��Ѹ������룬����',
   IS_MUST_CHG_DEFAULT_PWD VARCHAR(1) NOT NULL COMMENT '1 �� 0 ��',
   ACCOUNT_TYPE         VARCHAR(300) NOT NULL COMMENT '����ö��ŷָ���=allʱ������ȫ���û�'
);

ALTER TABLE PUB_POLICY_ACCOUNT_PWD
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POLICY_ACCOUNT_PWD_RULE
(
   ID                   VARCHAR(64) NOT NULL,
   PWD_REGULAR_STR      VARCHAR(100) NOT NULL,
   CNAME                VARCHAR(30) NOT NULL
);

ALTER TABLE PUB_POLICY_ACCOUNT_PWD_RULE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POLICY_ACCOUNT_UNLOCK
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(100),
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ͣ��',
   MEMO                 VARCHAR(200),
   UNLOCK_LIMIT         INT COMMENT '����',
   ACCOUNT_TYPE         VARCHAR(300) NOT NULL COMMENT '����ö��ŷָ���=allʱ������ȫ���û�'
);

ALTER TABLE PUB_POLICY_ACCOUNT_UNLOCK
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POLICY_IP
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(100),
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ͣ��',
   MEMO                 VARCHAR(200),
   ADDRESS_TYPE         VARCHAR(1) NOT NULL COMMENT '1 ����IP 2 IP��',
   IP_ADDRESS           VARCHAR(30) NOT NULL COMMENT '����ipʱ���ŷָ�',
   ACCESS_TYPE          VARCHAR(1) NOT NULL COMMENT '0 ��ֹ  1����',
   ACCOUNT_TYPE         VARCHAR(300) NOT NULL COMMENT '����ö��ŷָ���=allʱ������ȫ���û�'
);

ALTER TABLE PUB_POLICY_IP
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POSITION
(
   ID                   VARCHAR(64) NOT NULL,
   POST_CODE            VARCHAR(50) NOT NULL,
   CNAME                VARCHAR(20) NOT NULL,
   MEMO                 VARCHAR(500),
   SEQ_NUM              INT NOT NULL
);

ALTER TABLE PUB_POSITION
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POSITION_GRADE
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(50) NOT NULL,
   PG_CODE              VARCHAR(10),
   GRADE                INT,
   MEMO                 VARCHAR(50),
   SEQ_NUM              INT NOT NULL
);

ALTER TABLE PUB_POSITION_GRADE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_POSITION_ROLE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ORG_ID               VARCHAR(64),
   POST_ID              VARCHAR(64),
   ROLE_ID              VARCHAR(64)
);

ALTER TABLE PUB_POSITION_ROLE_RELA COMMENT '
��֯ID��ְ��������֯���������Ȩ��ʱ������֯��������ֵΪ 0';

ALTER TABLE PUB_POSITION_ROLE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_PROP_EXTEND
(
   ID                   VARCHAR(64) NOT NULL,
   PROP_TYPE            VARCHAR(50),
   PROP_NAME            VARCHAR(50),
   PROP_CODE            VARCHAR(50),
   INPUT_TYPE           VARCHAR(50),
   CREATE_TIME          TIMESTAMP,
   SEQ_NUM              INT
);

ALTER TABLE PUB_PROP_EXTEND COMMENT '��չ���Ա�';

ALTER TABLE PUB_PROP_EXTEND
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_PROP_EXTEND_DATA
(
   ID					VARCHAR(64) NOT NULL,   
   DATA_NAME           VARCHAR(50) NOT NULL,
   DATA_VALUE           VARCHAR(50),
   PROP_ID              VARCHAR(64)
);

ALTER TABLE PUB_PROP_EXTEND_DATA COMMENT '��չ���������ݱ�';

ALTER TABLE PUB_PROP_EXTEND_DATA
   ADD PRIMARY KEY (DATA_NAME);

CREATE TABLE PUB_RESOURCE
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'ȫ��Ψһ',
   MODULE_ID            VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(254) NOT NULL,
   RES_URL              VARCHAR(254) NOT NULL,
   CTR_URL              VARCHAR(254),
   IS_NAVIGATE          VARCHAR(1),
   STATUS               VARCHAR(1) NOT NULL,
   CREATE_TIME          TIMESTAMP,
   MEMO                 VARCHAR(200),
   IS_VERIFY_AUTH       VARCHAR(1) COMMENT '1 �� 0 ��'
);

ALTER TABLE PUB_RESOURCE COMMENT '״̬��1 ���ã�0 ͣ��';

ALTER TABLE PUB_RESOURCE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ROLE
(
   ROLE_ID              VARCHAR(64) NOT NULL,
   ROLE_TYPE            VARCHAR(1) NOT NULL COMMENT '1 ����Ա��ɫ 2 ��ͨ��ɫ ��ֻ�й���Ա������Ȩ�����ɫ',
   CNAME                VARCHAR(254) NOT NULL,
   APP_ID               VARCHAR(64) NOT NULL COMMENT '0 ����app�����ã�app_id ָ��Ӧ���ڿ���',
   ORGAN_ID             VARCHAR(64) COMMENT '0 ������֯�����ã�organ_id ָ����֯�ڿ���',
   IS_ORGAN_INHERIT     VARCHAR(1) COMMENT '1 �� 0 ��',
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 2 ���� 3 ɾ��',
   SEQ_NUM              INT NOT NULL,
   MEMO                 VARCHAR(254),
   CREATE_TIME          TIMESTAMP
);

ALTER TABLE PUB_ROLE COMMENT '״̬��1:��Ч��2 ���� 3 ɾ��
���ü��ֹ���Ա��ɫ��
	0 ��������Ա��Ӧ�á�ģ�顢��Դ����';

ALTER TABLE PUB_ROLE
   ADD PRIMARY KEY (ROLE_ID);

CREATE TABLE PUB_ROLE_GROUP
(
   ID                   VARCHAR(64) NOT NULL,
   CNAME                VARCHAR(100) NOT NULL,
   PARENT_ID            VARCHAR(64) NOT NULL,
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ͣ��',
   CREATE_TIME          TIMESTAMP,
   MEMO                 VARCHAR(200)
);

ALTER TABLE PUB_ROLE_GROUP COMMENT '����ɫ��ID��0���޸���ɫ��
״̬��1:��Ч��2 ���� 3 ɾ��';

ALTER TABLE PUB_ROLE_GROUP
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ROLE_GROUP_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   GROUP_ID             VARCHAR(64),
   ROLE_ID              VARCHAR(64)
);

ALTER TABLE PUB_ROLE_GROUP_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ROLE_MODULE_RELA
(
   ID                   VARCHAR(64) NOT NULL,
   ROLE_ID              VARCHAR(64),
   MODULE_ID            VARCHAR(64)
);

ALTER TABLE PUB_ROLE_MODULE_RELA
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_ROLE_RESOURCE
(
   ID                   VARCHAR(64) NOT NULL,
   ROLE_ID              VARCHAR(64),
   RES_ID               VARCHAR(64)
);

ALTER TABLE PUB_ROLE_RESOURCE
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_SCHEDULE_TASK
(
   ID                   VARCHAR(64) NOT NULL,
   TASK_CODE            VARCHAR(50) NOT NULL COMMENT 'schedule�����ı�ʾ',
   TASK_CNAME           VARCHAR(100) NOT NULL,
   GROUP_CODE           VARCHAR(50),
   GROUP_CNAME          VARCHAR(100),
   TASK_CLASS           VARCHAR(100) COMMENT 'ʵ��quartz��Job�ӿ�',
   SCHEDULE_RULE        VARCHAR(30) NOT NULL COMMENT 'cron���ʽ',
   STATUS               VARCHAR(1) NOT NULL COMMENT '1 ���� 0 ͣ��',
   MEMO                 VARCHAR(200)
);

ALTER TABLE PUB_SCHEDULE_TASK
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_SECURITY_POLICY
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'PWD_POLICY,UNLOCK_POLICK',
   POLICY_CODE          VARCHAR(100) NOT NULL COMMENT 'Ψһ,PWD_POLICY,UNLOCK_POLICK',
   CNAME                VARCHAR(100),
   MEMO                 VARCHAR(200) COMMENT '������Ϣ',
   STATUS               VARCHAR(1000) NOT NULL COMMENT '0 ͣ�� 1 ����'
);

ALTER TABLE PUB_SECURITY_POLICY
   ADD PRIMARY KEY (ID);

CREATE TABLE PUB_SYNC_CONFIG
(
   CONFIG_ID            VARCHAR(64) NOT NULL COMMENT '����ID',
   TARGET_ID            VARCHAR(64) COMMENT 'Ŀ��ϵͳID',
   TARGET_NAME          VARCHAR(200) COMMENT 'Ŀ��ϵͳ����',
   EVENT_TYPE           VARCHAR(200) COMMENT '�¼�����:
            
            1������û�
            2�������û�
            3��ɾ���û�
            4�������֯����
            5��������֯����
            6��ɾ����֯����
            7���޸��û�����',
   CREATE_DATE          TIMESTAMP COMMENT '����ʱ��',
   CREATE_PERSON_ID     VARCHAR(200) COMMENT '������'
);

ALTER TABLE PUB_SYNC_CONFIG
   ADD PRIMARY KEY (CONFIG_ID);

CREATE TABLE PUB_SYNC_IMPL_PARAM
(
   PARAM_ID             VARCHAR(64) NOT NULL,
   TARGET_ID            VARCHAR(64),
   PARAM_TYPE           VARCHAR(50) COMMENT '�������
            1���û�ͬ��
            2����֯����ͬ��',
   PARAM_NAME           VARCHAR(500) COMMENT '������',
   PARAM_VALUE          VARCHAR(500) COMMENT '����ֵ'
);

ALTER TABLE PUB_SYNC_IMPL_PARAM
   ADD PRIMARY KEY (PARAM_ID);

CREATE TABLE PUB_SYNC_RECORD
(
   DATA_NAME            VARCHAR(500) COMMENT '��������',
   DATA_ID              VARCHAR(64) NOT NULL COMMENT '����Ψһ��ʶ',
   DATA_TYPE            VARCHAR(500) COMMENT '�������
            1���û�ͬ��
            2����֯����ͬ��',
   CREATE_DATE          TIMESTAMP COMMENT '����ʱ��'
);

ALTER TABLE PUB_SYNC_RECORD
   ADD PRIMARY KEY (DATA_ID);

CREATE TABLE PUB_SYNC_RECORD_HISTORY
(
   DATA_NAME            VARCHAR(500) COMMENT '��������',
   DATA_ID              VARCHAR(64) NOT NULL COMMENT '����Ψһ��ʶ',
   DATA_TYPE            VARCHAR(500) COMMENT '�������
            1���û�ͬ��
            2����֯����ͬ��',
   CREATE_DATE          TIMESTAMP COMMENT '����ʱ��'
);

ALTER TABLE PUB_SYNC_RECORD_HISTORY
   ADD PRIMARY KEY (DATA_ID);

CREATE TABLE PUB_SYNC_RECORD_STATUS
(
   STATE_ID             VARCHAR(64) NOT NULL,
   DATA_ID              VARCHAR(64),
   EVENT_TYPE           VARCHAR(500) COMMENT '�¼�����:
            1������û�
            2�������û�
            3��ɾ���û�
            4�������֯����
            5��������֯����
            6��ɾ����֯����
            7���޸��û�����',
   TARGET_ID            VARCHAR(64) COMMENT 'Ŀ��ϵͳID',
   LAST_SYNC_TIME       TIMESTAMP COMMENT '���ͬ��ʱ��',
   SYNC_TIMES           INT COMMENT 'ͬ������',
   STATUS               VARCHAR(10) COMMENT 'ͬ��״̬',
   SYNC_TYPE            VARCHAR(100) COMMENT 'ͬ����ʽ
            1���Զ�
            2���ֶ�'
);

ALTER TABLE PUB_SYNC_RECORD_STATUS
   ADD PRIMARY KEY (STATE_ID);

CREATE TABLE PUB_SYNC_RECORD_STATUS_HISTORY
(
   STATE_ID             VARCHAR(64) NOT NULL,
   DATA_ID              VARCHAR(64),
   EVENT_TYPE           VARCHAR(500) COMMENT '�¼�����:
            1������û�
            2�������û�
            3��ɾ���û�
            4�������֯����
            5��������֯����
            6��ɾ����֯����
            7���޸��û�����',
   TARGET_ID            VARCHAR(64) COMMENT 'Ŀ��ϵͳID',
   LAST_SYNC_TIME       TIMESTAMP COMMENT '���ͬ��ʱ��',
   SYNC_TIMES           INT COMMENT 'ͬ������',
   STATUS               VARCHAR(10) COMMENT 'ͬ��״̬',
   SYNC_TYPE            VARCHAR(100) COMMENT 'ͬ����ʽ'
);

ALTER TABLE PUB_SYNC_RECORD_STATUS_HISTORY
   ADD PRIMARY KEY (STATE_ID);

CREATE TABLE PUB_SYNC_TARGET
(
   TARGET_ID            VARCHAR(64) NOT NULL,
   TARGET_NAME          VARCHAR(200) COMMENT 'ϵͳ����',
   USER_IMPL            VARCHAR(500) COMMENT '�û�ͬ��ʵ���ࣺ
            1���û�ͬ��
            2���û���ͬ��',
   ORG_IMPL             VARCHAR(500) COMMENT '��֯����ͬ��ʵ����',
   CREATE_DATE          TIMESTAMP COMMENT '����ʱ��',
   CREATE_PERSON_ID     VARCHAR(100) COMMENT '������',
   MODIFY_DATE          TIMESTAMP COMMENT '����޸�ʱ��',
   MODIFY_PERSON_ID     VARCHAR(100) COMMENT '����޸���',
   STATUS               VARCHAR(10) COMMENT '״̬'
);

ALTER TABLE PUB_SYNC_TARGET
   ADD PRIMARY KEY (TARGET_ID);

CREATE TABLE BZ_DATA_ELE_SORT
(
   ELE_SORT_ID          VARCHAR(64) NOT NULL,
   ELE_SORT_NAME        VARCHAR(100) NOT NULL,
   ELE_SORT_DESC        VARCHAR(200),
   PARENT_ID            VARCHAR(64),
   SEQ_NUM              INT,
   CREATE_DATE          TIMESTAMP
);

ALTER TABLE BZ_DATA_ELE_SORT
   ADD PRIMARY KEY (ELE_SORT_ID);

CREATE TABLE BZ_DATA_ELE
(
   UUID                 VARCHAR(64) NOT NULL,
   ELE_SORT_ID          VARCHAR(64),
   DATA_ELE_ID          VARCHAR(64),
   ELE_NAME_ZH          VARCHAR(100),
   ELE_NAME_EN          VARCHAR(100),
   ELE_NAME_SYN         VARCHAR(100),
   DEFINITION           VARCHAR(500),
   SORT_MODE            VARCHAR(100),
   SHOW_FORM            VARCHAR(100),
   DATA_TYPE            VARCHAR(100),
   SHOW_FORMAT          VARCHAR(100),
   ALLOW_VALUE          VARCHAR(100),
   CREATE_DATE          TIMESTAMP
);

ALTER TABLE BZ_DATA_ELE
   ADD PRIMARY KEY (UUID);
   