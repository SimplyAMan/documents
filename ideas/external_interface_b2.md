

Flink	PKI_ISCARD_API_ALPHA.CARDACCOUNTSETUP	Відкриття карткових угод ПТС
	PKI_ISCARD_API_ALPHA.CARDACCOUNTCLOSE	Закриття карткових угод ПТС
	PKI_ISCARD_API_ALPHA.CARDROLLOVER	
	PKI_ISCARD_API_ALPHA.CHANGEDEALLIMIT  	
	PKI_ISCARD_API_ALPHA.CHANGEDEALRATE	
	"  SELECT *
    FROM creator.valpha_fis_deal_account
   WHERE lastmodified >=   TO_DATE (
                             '${STR_VALUE}',
                             'yyyy-mm-dd hh24:mi:ss')
                         + INTERVAL '1' SECOND
     AND lastmodified < (SYSDATE - INTERVAL '10' SECOND)
ORDER BY lastmodified"	
	"SELECT dealdate, closedate, valuedate, expectedclosedate,
       dealterm, currentrate, dealno, dealtypeid, b2id,
       t24id, typename, b2typeid, t24typeid, currencyid,
       principalaccountno, restamountminsum, toboname,
       dealstate, lastprolongdate, autoprolong,
       prolongationcount, enablepartrepayment, canreplenish,
       amount, b2contragentid, t24contragentid, identifycode,
       passportissuedate, passportsr, passportno, dateofbirth,
       synctimestamp,toboid, miss003
  FROM creator.valpha_fis_deal 
 WHERE synctimestamp>=TO_DATE(  '${STR_VALUE}', 'yyyy-mm-dd hh24:mi:ss')+ INTERVAL '1' SECOND
   AND synctimestamp < ( SYSDATE  - INTERVAL '10' SECOND )
 ORDER BY synctimestamp;"	
	"SELECT * 
  FROM creator.vAlfa_Contragent_Interface
 WHERE ROWNUM <=150 AND creator.alfa_tools.eprlogin()=1;"	
	"SELECT TO_CHAR(B2ID) AS b2id, T24ID, NAME, DESCRIPTION, CURRENCYID, SYNCTIMESTAMP, INTTYPE 
  FROM creator.valpha_inddep_type 
 WHERE synctimestamp>=TO_DATE( '${STR_VALUE}', 'yyyy-mm-dd hh24:mi:ss')+ INTERVAL '1' SECOND
   AND synctimestamp < ( SYSDATE  - INTERVAL '10' SECOND )
 ORDER BY synctimestamp"	

