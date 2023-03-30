/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_VL
 
SELECT ExceptionE0.NAME RES_EXCEPTION
,(CASE
	WHEN ExceptionNotiE0.RECIPIENT_TYPE = 1 THEN
		(SELECT USERNAME
			FROM PER_USERS
			WHERE USER_ID = ExceptionNotiE0.RECIPIENT_ID
			AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,SYSDATE+1))			
	WHEN ExceptionNotiE0.RECIPIENT_TYPE = 2 THEN
		(SELECT ROLE_NAME
			FROM PER_ROLES_DN_VL
			WHERE ROLE_ID = ExceptionNotiE0.RECIPIENT_ID)		
	END) RES_RECIPIENT
,DECODE(ExceptionNotiDetailsE0.NOTIFICATION_ENTITY,'1','Item'
	,'40','Organization'
	,'43','Customer Site'
	,'44','Customer'
	,'50','Demand Class'
	,'Sales Rep'
	)RES_ENTITY
,DECODE(ExceptionNotiDetailsE0.NOTIFICATION_OPERATION,'equals','='
	,'notequals','!='
	,'among','In') RES_CONDITION
,ExceptionNotiDetailsE0.NOTIFICATION_CONDITION RES_VALUES
,ExceptionNotiDetailsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ExceptionNotiDetailsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ExceptionNotiDetailsE0.CREATED_BY  RSC_CREATED_BY
,ExceptionNotiDetailsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_EXCEPTION_VL ExceptionE0
,MSC_EXCEPTION_NOTIFY ExceptionNotiE0
,MSC_EXCEPTION_NOTIFY_DETAILS ExceptionNotiDetailsE0
WHERE ExceptionE0.EXCEPTION_ID = ExceptionNotiE0.EXCEPTION_ID
AND ExceptionNotiE0.EXCEPTION_ID = ExceptionNotiDetailsE0.EXCEPTION_ID
AND ExceptionNotiE0.NOTIFICATION_ID = ExceptionNotiDetailsE0.NOTIFICATION_ID
AND ExceptionNotiDetailsE0.NOTIFICATION_OPERATION != 'among'
ORDER BY ExceptionE0.NAME