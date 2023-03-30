/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Expense%20Report%20Auditing%20Lookup%20Types%20-%20Expense%20Report%20Auditing%20Lookup%20Types.sql $:
* $Id: Manage Expense Report Auditing Lookup Types - Expense Report Auditing Lookup Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT LookupTypeEO.LOOKUP_TYPE AS RES_LOOKUP_TYPE
,(SELECT VISIBLE_GROUP_NAME
	FROM FND_SETID_REFERENCE_GROUPS_VL
	WHERE REFERENCE_GROUP_NAME = LookupTypeEO.REFERENCE_GROUP_NAME
	)           AS RES_REFERENCE_GROUP_NAME
,LookupTypeEO.MEANING           AS RES_MEANING
,LookupTypeEO.DESCRIPTION       AS RES_DESCRIPTION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = LookupTypeEO.MODULE_ID
	) AS RES_APPLICATION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE lookup_type = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND lookup_code   = LookupTypeEO.CUSTOMIZATION_LEVEL
	) AS RES_CONFIGURATION_LEVEL
,LookupTypeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupTypeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupTypeEO.CREATED_BY RSC_CREATED_BY
,LookupTypeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
WHERE LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'EXM'
	AND at.module_id     = rf.ancestor_module_id
	)
ORDER BY RES_LOOKUP_TYPE