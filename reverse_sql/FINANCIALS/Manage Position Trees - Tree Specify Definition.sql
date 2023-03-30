/* ****************************************************************************
 * $Revision: 56131 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-06-22 15:09:09 +0700 (Wed, 22 Jun 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Chart%20of%20Accounts.sql $:
 * $Id: Manage Mapping Sets - Chart of Accounts.sql 56131 2016-06-22 08:09:09Z pisan.jariyasettachok $:
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
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_TREE_VL FndTreeEO
,FND_SETID_SETS_VL SetINamePEO
WHERE FndTreeEO.SET_ID  = SetINamePEO.SET_ID
and TREE_STRUCTURE_CODE = 'PER_POS_TREE_STRUCTURE'
order by FNDTREEEO.TREE_NAME