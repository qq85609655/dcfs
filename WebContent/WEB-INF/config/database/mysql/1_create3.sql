create table WB_ROLE
(
   role_code            varchar(100) not null,
   role_name            varchar(100),
   role_type            varchar(1),
   parent_code          varchar(100),
   pno                  int,
   primary key (role_code)
);

create table WB_FUN
(
   fun_code             varchar(100) not null,
   fun_name             varchar(100) not null,
   parent_code          varchar(100) not null,
   fun_type             varchar(1) not null comment '1����Ȩ�ޣ�2����Ȩ��',
   pno                  int,
   primary key (fun_code)
);


create table WB_ROLE_FUN
(
   role_code            varchar(100) not null,
   fun_code             varchar(100) not null
);
create table WB_USER
(
   username             varchar(30) not null,
   pass1                varchar(100) not null,
   pass2                varchar(100) comment '֧������',
   fullname             varchar(50) not null,
   sex                  varchar(1) comment '1���У�2��Ů��3�����ܣ�4��δ֪�����뼯��',
   mobile               varchar(20),
   verify               varchar(1) not null comment '0��δ��֤��1����֤',
   email                varchar(100),
   weixin               varchar(100),
   idcard               varchar(18),
   seat                 varchar(6),
   card_number          varchar(100),
   medical_number       varchar(100),
   medical_verify       varchar(1) comment '0��δ��֤��1�������֤��2��������֤��3��Ԥ����Ϣ��֤�����뼯��',
   user_state           varchar(1) not null comment '0������1������2������3���Զ��������˺ŵ�½���������������������4���Զ��������˺���ص�¼����֤������֤����9����������',
   user_role            varchar(1000),
   last_login_time      timestamp,
   last_login_area      varchar(100),
   last_login_ip        varchar(128),
   primary key (username)
);
create table WB_SYSTEM
(
   username             varchar(30) not null,
   pass1                varchar(100) not null,
   fullname             varchar(50) not null,
   sex                  varchar(1) comment '1���У�2��Ů��3�����ܣ�4��δ֪�����뼯��',
   mobile               varchar(20),
   email                varchar(100),
   weixin               varchar(100),
   user_state           varchar(1) not null comment '0������1������2������3���Զ��������˺ŵ�½���������������������4���Զ��������˺���ص�¼����֤������֤����8����ʼ���룻9����������',
   user_role            varchar(1000),
   last_login_time      timestamp,
   last_login_area      varchar(100),
   last_login_ip        varchar(128),
   user_rem             varchar(1000),
   primary key (username)
);

create table WB_UHHU
(
   username             varchar(30) not null,
   pass1                varchar(100),
   pass2                varchar(100) comment '��ʼ���룬���ܴ洢',
   uhhu_name            varchar(400) not null,
   licence              varchar(100),
   isp                  varchar(100),
   seat                 varchar(10),
   contacts             varchar(100),
   contactstel          varchar(20),
   user_state           varchar(1) not null comment '0������1������2������3���Զ��������˺ŵ�½���������������������4���Զ��������˺���ص�¼����֤������֤����8���״ε�¼9����������',
   user_role            varchar(1000),
   last_login_time      timestamp,
   last_login_area      varchar(100),
   last_login_ip        varchar(128),
   primary key (username)
);

create table WB_UHHU_IP
(
   username             varchar(30) not null,
   privatekey           varchar(200) comment 'ǩ��˽Կ������',
   ipaddress            varchar(1000),
   ipdisable            varchar(4000),
   primary key (username)
);

create table WB_ORGAN_LOGIN
(
   id                   varchar(64) not null,
   username             varchar(30) not null,
   ipaddress            varchar(128),
   browserinfo          varchar(100),
   logintime            timestamp not null,
   logintype            varchar(1) not null comment '1:��¼2:�˹��˳�3:��ʱ�˳�0:δ֪',
   loginfrom            varchar(20) not null,
   primary key (id)
);

create table WB_SYS_ORGAN
(
   org_code             varchar(50) not null,
   org_type             varchar(1) not null comment '1����2����3����Ŀ¼',
   org_name             varchar(100) not null,
   org_short            varchar(20),
   parent_code          varchar(1) comment '1:��¼2:�˹��˳�3:��ʱ�˳�0:δ֪',
   rem                  varchar(1000),
   pno                  int not null,
   org_role             varchar(1000)
);