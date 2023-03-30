/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT jobsE0.NAME RES_POSITION
,TO_CHAR(costsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,jobsE0.POSITION_CODE RES_CODE
,(SELECT NAME
    FROM PER_LEGISLATIVE_DATA_GROUPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LEGISLATIVE_DATA_GROUP_ID = costsE0.LEGISLATIVE_DATA_GROUP_ID
    ) RES_LEGISLATIVE_DATA_GROUP
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = jobsE0.ACTIVE_STATUS 
	AND LOOKUP_TYPE = 'CODE_STATUS' AND SYSDATE BETWEEN START_DATE_ACTIVE AND END_DATE_ACTIVE) RES_STATUS
,TO_CHAR(costsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE

,costsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,costsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,costsE0.CREATED_BY RSC_CREATED_BY
,costsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM HR_ALL_POSITIONS_F_VL jobsE0
,(SELECT *
    FROM PAY_COST_ALLOCATIONS_F
    WHERE SOURCE_TYPE = 'POS'
    ) costsE0


WHERE jobsE0.POSITION_ID = costsE0.SOURCE_ID
AND SYSDATE BETWEEN jobsE0.EFFECTIVE_START_DATE AND jobsE0.EFFECTIVE_END_DATE
ORDER BY jobsE0.NAME
,jobsE0.POSITION_CODE
