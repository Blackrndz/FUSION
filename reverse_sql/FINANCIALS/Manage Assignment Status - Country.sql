/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=PER_ASSIGNMENT_STATUS_TYPES_VL

SELECT asgStatusesE0.USER_STATUS RES_STATUS
,asgStatusesE0.ASSIGNMENT_STATUS_CODE RES_CODE
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_VL 
	WHERE TERRITORY_CODE = (TRIM(REGEXP_SUBSTR(asgStatusesE0.COUNTRY, '[^,]+', 1, levels.column_value)))
	) RES_COUNTRY
,'Yes' RES_ENABLE
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
,TRIM(REGEXP_SUBSTR(asgStatusesE0.COUNTRY, '[^,]+', 1, levels.column_value)) RSC_COUNTRY_ID
FROM PER_ASSIGNMENT_STATUS_TYPES_VL asgStatusesE0
,TABLE(CAST(MULTISET(SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= LENGTH (regexp_replace(asgStatusesE0.COUNTRY, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
WHERE asgStatusesE0.COUNTRY IS NOT NULL
ORDER BY asgStatusesE0.USER_STATUS