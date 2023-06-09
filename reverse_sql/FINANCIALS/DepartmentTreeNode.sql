/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Trees%20-%20Tree%20Version%20Specify%20Nodes%20(Specific%20value).sql $:
 * $Id: Manage Organization Trees - Tree Version Specify Nodes (Specific value).sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT 'MERGE' RES_METADATA
,'DepartmentTreeNode' RES_DEPARTMENTTREENODE_0
,'PER_DEPT_TREE_STRUCTURE' RES_TREESTRUCTURECODE
,NODE.TREE_CODE RES_TREECODE
,FndTreeVersionEO.TREE_VERSION_NAME RES_TREEVERSIONNAME
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS_F_VL a 
	WHERE ORGANIZATION_ID = NODE.PK1_START_VALUE 
	--AND FndTreeVersionEO.EFFECTIVE_START_DATE BETWEEN a.EFFECTIVE_START_DATE AND a.EFFECTIVE_END_DATE
	AND SYSDATE BETWEEN a.EFFECTIVE_START_DATE AND a.EFFECTIVE_END_DATE
	) RES_DEPARTMENTNAME
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS_F_VL a 
	WHERE ORGANIZATION_ID = NODE.PARENT_PK1_VALUE 
	--AND FndTreeVersionEO.EFFECTIVE_START_DATE BETWEEN a.EFFECTIVE_START_DATE AND a.EFFECTIVE_END_DATE
	AND SYSDATE BETWEEN a.EFFECTIVE_START_DATE AND a.EFFECTIVE_END_DATE
	) RES_PARENTDEPARTMENTNAME
,NODE.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,NODE.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,NODE.CREATED_BY 		RSC_CREATED_BY
,NODE.CREATION_DATE 	RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM PER_DEPT_TREE_NODE NODE
,FND_TREE_VERSION_VL FndTreeVersionEO
,FND_TREE_VL FndTreeVLEO
WHERE NODE.TREE_STRUCTURE_CODE = 'PER_DEPT_TREE_STRUCTURE'
AND NODE.TREE_CODE = FndTreeVLEO.TREE_CODE
AND NODE.TREE_STRUCTURE_CODE = FndTreeVLEO.TREE_STRUCTURE_CODE
AND NODE.TREE_CODE = FndTreeVersionEO.TREE_CODE
AND NODE.TREE_STRUCTURE_CODE = FndTreeVersionEO.TREE_STRUCTURE_CODE
AND NODE.TREE_VERSION_ID = FndTreeVersionEO.TREE_VERSION_ID
AND DEPTH <= 10
AND (CHILD_COUNT = 0  OR (CHILD_COUNT > 0 and DEPTH <= 10 )) 
START WITH NVL(NODE.PARENT_TREE_NODE_ID,'1') = '1'
CONNECT BY PRIOR NODE.TREE_NODE_ID = NODE.PARENT_TREE_NODE_ID
AND NODE.DATA_SOURCE_ID = NODE.PARENT_DATA_SOURCE_ID