/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Trees%20-%20Tree%20Version%20Specify%20Definition.sql $:
 * $Id: Manage Organization Trees - Tree Version Specify Definition.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT FNDTREEEO.TREE_NAME 											RES_TREE_NAME
,FNDTREEEO.TREE_CODE 												RES_TREE_CODE
,FNDTREEEO.TREE_STRUCTURE_CODE 										RES_TREE_STRUCTURE_CODE
,FNDTREEVERSIONEO.TREE_VERSION_NAME 								RES_NAME
,FNDTREEVERSIONEO.DESCRIPTION 										RES_DESCRIPTION
,FndTreeVersionEO.VERSION_COMMENT 									RES_NOTE
,TO_CHAR(FNDTREEVERSIONEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') 		RES_EFFECTIVE_START_DATE
,TO_CHAR(FNDTREEVERSIONEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') 		RES_EFFECTIVE_END_DATE
,StatusLookupPEO.MEANING 											RES_STATUS
,FndTreeVersionEO.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,FndTreeVersionEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FndTreeVersionEO.CREATED_BY 		RSC_CREATED_BY
,FndTreeVersionEO.CREATION_DATE 	RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_TREE_VL FndTreeEO
,FND_TREE_VERSION_VL FndTreeVersionEO
,FND_LOOKUPS STATUSLOOKUPPEO
WHERE FndTreeEO.Tree_code = FndTreeVersionEO.tree_code
AND FndTreeVersionEO.STATUS = StatusLookupPEO.LOOKUP_CODE
AND STATUSLOOKUPPEO.LOOKUP_TYPE = 'FND_TREE_STATUS_TYPE'
AND FNDTREEVERSIONEO.TREE_STRUCTURE_CODE = 'PER_ORG_TREE_STRUCTURE'
ORDER BY FNDTREEEO.TREE_NAME
,FndTreeVersionEO.TREE_VERSION_NAME