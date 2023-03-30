/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT LegislativeGroupsE0.NAME RES_NAME
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_VL 
	WHERE TERRITORY_CODE = LegislativeGroupsE0.LEGISLATION_CODE
	) RES_COUNTRY
,(SELECT NAME 
	FROM FND_CURRENCIES_VL 
	WHERE CURRENCY_CODE = LegislativeGroupsE0.DEFAULT_CURRENCY_CODE
	) RES_CURRENCY
,(SELECT NAME 
	FROM FND_KF_STR_INSTANCES_Vl 
	WHERE STRUCTURE_INSTANCE_NUMBER = LegislativeGroupsE0.COST_ALLOCATION_ID_FLEX_NUM
	) RES_COST_ALLOCATION_STRUCTURE
,LegislativeGroupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LegislativeGroupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LegislativeGroupsE0.CREATED_BY  RSC_CREATED_BY
,LegislativeGroupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,LegislativeGroupsE0.LEGISLATION_CODE RSC_COUNTRY_ID
FROM PER_LEGISLATIVE_DATA_GROUPS_VL LegislativeGroupsE0
ORDER BY LegislativeGroupsE0.NAME