/* ****************************************************************************
 * $Revision: 68523 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-30 14:33:44 +0700 (Thu, 30 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Priority%20Values%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Project Priority Values - Lookup Codes.sql 68523 2018-08-30 07:33:44Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT NVL((SELECT TREE_STRUCTURE_NAME
	FROM FND_TREE_STRUCTURE_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TREE_STRUCTURE_CODE = hierarchyTypeE0.ORG_HIERARCHY_TYPE_CODE
	),'None') RES_TYPE
,(SELECT CLASSIFICATION_NAME
	FROM HR_ORG_CLASSIFICATIONS_VL
	WHERE CLASSIFICATION_CODE = orgClassificationsE0.CLASSIFICATION_CODE
	) RES_SELECTED
,orgClassificationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,orgClassificationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,orgClassificationsE0.CREATED_BY RSC_CREATED_BY
,orgClassificationsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_ORG_HIERARCHY_TYPE hierarchyTypeE0
,PJF_ORG_CLASSIFICATIONS orgClassificationsE0
ORDER BY 1,2