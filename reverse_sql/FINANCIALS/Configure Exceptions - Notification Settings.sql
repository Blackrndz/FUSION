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
,DECODE(ExceptionE0.SEND_NOTIFICATION,'1','Yes','No') RES_SEND_NOTIFICATION
,DECODE(ExceptionNotiE0.RECIPIENT_TYPE,'1','User','Role') RES_TYPE
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
,ExceptionNotiE0.NOTIFICATION_NAME RES_NOTIFICATION_SETTING
,ExceptionNotiE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ExceptionNotiE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ExceptionNotiE0.CREATED_BY  RSC_CREATED_BY
,ExceptionNotiE0.CREATION_DATE  RSC_CREATION_DATE
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
WHERE ExceptionE0.EXCEPTION_ID = ExceptionNotiE0.EXCEPTION_ID
ORDER BY ExceptionE0.NAME