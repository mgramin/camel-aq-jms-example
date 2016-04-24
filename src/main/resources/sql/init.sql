BEGIN
 DBMS_AQADM.CREATE_QUEUE_TABLE( queue_table => 'queue_message_table', queue_payload_type => 'SYS.AQ$_JMS_TEXT_MESSAGE');
END;
/

BEGIN
  DBMS_AQADM.CREATE_QUEUE( queue_name => 'ORACLE_QUEUE', queue_table => 'queue_message_table');
END;
/

BEGIN
  DBMS_AQADM.START_QUEUE(queue_name => 'ORACLE_QUEUE');
END;
/



declare
  msg SYS.AQ$_JMS_TEXT_MESSAGE;
  msg_hdr SYS.AQ$_JMS_HEADER;
  msg_agent SYS.AQ$_AGENT;
  msg_proparray SYS.AQ$_JMS_USERPROPARRAY;
  msg_property SYS.AQ$_JMS_USERPROPERTY;
  queue_options DBMS_AQ.ENQUEUE_OPTIONS_T;
  msg_props DBMS_AQ.MESSAGE_PROPERTIES_T;
  msg_id RAW(16);
  dummy VARCHAR2(4000);
begin
  msg_agent := SYS.AQ$_AGENT(' ', null, 0);
  msg_proparray := SYS.AQ$_JMS_USERPROPARRAY();
  msg_proparray.EXTEND(1);
  msg_property := SYS.AQ$_JMS_USERPROPERTY('JMS_OracleDeliveryMode', 100, '2', NULL, 27);
  msg_proparray(1) := msg_property;


  msg_proparray.EXTEND(1);
  msg_property := SYS.AQ$_JMS_USERPROPERTY('NEW_USER_PROP', 100, '2', NULL, 27);
  msg_proparray(2) := msg_property;

  msg_proparray.EXTEND(1);
  msg_property := SYS.AQ$_JMS_USERPROPERTY('NEW_USER_PROP_2', 100, '500', NULL, 27);
  msg_proparray(3) := msg_property;


  msg_hdr := SYS.AQ$_JMS_HEADER(msg_agent,null,'USERNAME_',null,null,null,msg_proparray);
  msg := SYS.AQ$_JMS_TEXT_MESSAGE(msg_hdr,null,null,null);
  msg.text_vc := 'Hello from PL/SQL on XE';
  msg.text_len := length(msg.text_vc);
  SYS.DBMS_AQ.ENQUEUE( queue_name => 'ORACLE_QUEUE'
                 , enqueue_options => queue_options
                 , message_properties => msg_props
                 , payload => msg
                 , msgid => msg_id);
                 commit;
end;
/

select * from QUEUE_MESSAGE_TABLE;