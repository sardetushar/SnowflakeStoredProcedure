-- Snowflake_StoredProc_HelloWorld_Part1
-- https://www.youtube.com/channel/UCroaXERLmPcbmQqTTcpkLuA

CREATE DATABASE HELLODB;

CREATE TABLE DEMO(ID INT, COMMENTS TEXT);

INSERT INTO DEMO VALUES (1, 'HELLO WORLD');
INSERT INTO DEMO VALUES (2, 'HELLO FROM SARDE');

// Same name without parameter

CREATE OR REPLACE PROCEDURE HELLODB.PUBLIC.HELLO_PROC()
RETURNS VARCHAR
LANGUAGE javascript
AS 
$$  
    var sql_text = 'SELECT ID, COMMENTS FROM DEMO';
    
    var res = snowflake.execute({sqlText: sql_text});
    
    // one record
    res.next();
    
    return res.getColumnValue(1) + " , " + res.getColumnValue(2);
$$;

CALL HELLODB.PUBLIC.HELLO_PROC();



// Same name with different parameter

CREATE OR REPLACE PROCEDURE HELLODB.PUBLIC.HELLO_PROC(TABLENAME TEXT)
RETURNS VARCHAR
LANGUAGE javascript
AS 
$$  
    let sql_text = 'SELECT ID, COMMENTS FROM '+ TABLENAME;
    
    var res = snowflake.execute({sqlText: sql_text});
    
    res.next();
    
    return res.getColumnValue(1) + " , " + res.getColumnValue(2) + ", " + "WITH Param";
$$;


CALL HELLO_PROC();

CALL HELLO_PROC('DEMO');
