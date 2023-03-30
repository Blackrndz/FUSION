/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT asgStatusesE0.USER_STATUS RES_STATUS
,asgStatusesE0.ASSIGNMENT_STATUS_CODE RES_CODE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PAY_ASS_SYS_STATUS'
	AND LOOKUP_CODE = asgStatusesE0.PAY_SYSTEM_STATUS 
	) RES_PAY_STATUS
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PER_ASS_SYS_STATUS'
	AND LOOKUP_CODE = asgStatusesE0.PER_SYSTEM_STATUS
	) RES_HR_STATUS
,TO_CHAR(asgStatusesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,DECODE(TO_CHAR(asgStatusesE0.END_DATE,'DD-MM-YYYY')
	,'31-12-4712',NULL
	,TO_CHAR(asgStatusesE0.END_DATE,'DD-Mon-YYYY')
	) RES_END_DATE
,DECODE(asgStatusesE0.DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT
,(SELECT USER_STATUS
	FROM PER_ASSIGNMENT_STATUS_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ASSIGNMENT_STATUS_TYPE_ID = asgStatusesE0.ORIG_ASSIGN_STATUS_TYPE_ID 
	) RES_ORIGINAL_STATUS
,asgStatusesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,asgStatusesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,asgStatusesE0.CREATED_BY  RSC_CREATED_BY
,asgStatusesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM PER_ASSIGNMENT_STATUS_TYPES_VL asgStatusesE0
ORDER BY asgStatusesE0.USER_STATUS