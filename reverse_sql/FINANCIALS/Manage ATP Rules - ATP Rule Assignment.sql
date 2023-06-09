/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_ITEMS

SELECT AtpRule.RULE_NAME RES_NAME
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'MSC_ATP_ASSIGNMENT_TYPE'
	AND LOOKUP_CODE = AtpAssignment.ASSIGNMENT_TYPE
	AND LANGUAGE = USERENV('LANG')
	) RES_ASSIGNMENT_BASIS
,(SELECT ORGANIZATION_CODE
	FROM MSC_PARAMETERS 
	WHERE ORGANIZATION_ID = AtpAssignment.ORGANIZATION_ID
	) RES_ASSIGNED_TO_ORGANIZATION
,(SELECT ITEM_NAME
	FROM MSC_ITEMS MscItems
	WHERE INVENTORY_ITEM_ID = AtpAssignment.INVENTORY_ITEM_ID
	) RES_ASSIGNED_TO_ITEM
,AtpAssignment.CATEGORY_NAME RES_ASSIGNED_TO_ITEM_CATEGORY
,AtpAssignment.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AtpAssignment.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AtpAssignment.CREATED_BY RSC_CREATED_BY
,AtpAssignment.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,(SELECT INV_ORG.ORGANIZATION_ID 
	FROM INV_ORG_PARAMETERS INV_ORG
	,MSC_PARAMETERS MSC_ORG
	WHERE INV_ORG.ORGANIZATION_CODE = MSC_ORG.ORGANIZATION_CODE
	AND MSC_ORG.ORGANIZATION_ID = AtpAssignment.ORGANIZATION_ID
	) RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_ATP_RULES AtpRule
,MSC_ATP_ASSIGNMENTS AtpAssignment
WHERE AtpRule.RULE_ID = AtpAssignment.ATP_RULE_ID
ORDER BY AtpRule.RULE_NAME