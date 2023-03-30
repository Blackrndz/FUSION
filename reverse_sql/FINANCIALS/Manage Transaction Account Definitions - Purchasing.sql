/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-11-06 $:
 * $HeadURL:  $:
 * $Id: Manage Transaction Account Definitions - Purchasing.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT AccountDefinitionEO.NAME RES_NAME
,AccountDefinitionEO.ACCOUNT_DEFINITION_CODE RES_SHORT_NAME
,AccountDefinitionEO.DESCRIPTION RES_DESCRIPTION
,(SELECT NAME 
	FROM FND_KF_STR_INSTANCES_VL 
	WHERE STRUCTURE_INSTANCE_NUMBER = AccountDefinitionEO.CHART_OF_ACCOUNTS_ID
	) RES_CHART_OF_ACCOUNTS
,DECODE(AccountDefinitionEO.STATUS_CODE,'ACTIVE','Active','INCOMPLETE','Incomplete','INERROR','Error') RES_STATUS
,AccountDefinitionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AccountDefinitionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AccountDefinitionEO.CREATED_BY  RSC_CREATED_BY
,AccountDefinitionEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,AccountDefinitionEO.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM XLA_TAB_ACCT_DEFS_VL AccountDefinitionEO
Where  AccountDefinitionEO.APPLICATION_ID  = 201 
ORDER BY AccountDefinitionEO.APPLICATION_ID
,AccountDefinitionEO.NAME