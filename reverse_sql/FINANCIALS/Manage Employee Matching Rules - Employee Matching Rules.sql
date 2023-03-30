/* ****************************************************************************
* $Revision: 62356 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2017-05-25 15:34:34 +0700 (Thu, 25 May 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Manage%20Expense%20Report%20Auditing%20Lookup%20Types%20-%20Financials%20Generic%20Lookup%20Type.sql $:
* $Id: Manage Expense Report Auditing Lookup Types - Financials Generic Lookup Type.sql 62356 2017-05-25 08:34:34Z pisan.jariyasettachok $:
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
	) AS RES_CUSTOMIZATION_LEVEL
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
WHERE LookupTypeEO.LOOKUP_TYPE = 'EXM_EMP_MATCH_RULE'
ORDER BY RES_LOOKUP_TYPE