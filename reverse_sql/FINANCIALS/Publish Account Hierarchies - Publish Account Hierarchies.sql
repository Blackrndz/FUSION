/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-11-16  $:
 * $HeadURL:  $:
 * $Id: Publish Account Hierarchies - Publish Account Hierarchies.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT  
BB.tree_name          						RES_HIERARCHY
, AA.TREE_VERSION_NAME  					RES_HIERARCHY_VERSION
, decode(X.AGGREGATION_FLAG,'Y','Yes','No')			RES_PUBLISH
, AA.LAST_UPDATED_BY 						RSC_LAST_UPDATED_BY
,AA.LAST_UPDATE_DATE 						RSC_LAST_UPDATE_DATE
,AA.CREATED_BY 								RSC_CREATED_BY
,AA.CREATION_DATE 							RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_TREE_VERSION_VL AA
     , fnd_tree_vl BB
     , GL_COA_TREE_VERSIONS_AGGR_DTLS X
WHERE AA.TREE_STRUCTURE_CODE = 'GL_ACCT_FLEX'
AND  AA.TREE_CODE  = BB.TREE_CODE
AND  AA.TREE_VERSION_ID = X.TREE_VERSION_ID
AND X.tree_structure_code='GL_ACCT_FLEX'
AND AA.STATUS <> 'DRAFT'
ORDER BY  RES_HIERARCHY