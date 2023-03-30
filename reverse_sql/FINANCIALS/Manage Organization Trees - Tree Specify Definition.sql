/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Trees%20-%20Tree%20Specify%20Definition.sql $:
 * $Id: Manage Organization Trees - Tree Specify Definition.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
select FNDTREEEO.TREE_NAME RES_NAME
,FNDTREEEO.TREE_CODE RES_CODE
,(SELECT TREE_STRUCTURE_NAME
	FROM FND_TREE_STRUCTURE_VL
	WHERE TREE_STRUCTURE_CODE = FNDTREEEO.TREE_STRUCTURE_CODE  ) RES_TREE_STRUCTURE
,FndTreeEO.DESCRIPTION RES_DESCRIPTION
,SUBSTR(FndTreeEO.ICON_NAME,INSTR(FndTreeEO.ICON_NAME,'/',-1,1)+1,LENGTH(FndTreeEO.ICON_NAME)) RES_ICON_IMAGE
,FndTreeEO.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,FndTreeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FndTreeEO.CREATED_BY RSC_CREATED_BY
,FndTreeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_TREE_VL FndTreeEO
,FND_SETID_SETS_VL SetINamePEO
WHERE FndTreeEO.SET_ID  = SetINamePEO.SET_ID
and TREE_STRUCTURE_CODE = 'PER_ORG_TREE_STRUCTURE'
order by FNDTREEEO.TREE_NAME