/* ****************************************************************************
 * $Revision: 53905 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-25 10:42:36 +0700 (Fri, 25 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Reference%20Accounts.sql $:
 * $Id: Manage Transaction Types - Reference Accounts.sql 53905 2016-03-25 03:42:36Z pisan.jariyasettachok $:
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
Where  AccountDefinitionEO.APPLICATION_ID  = 435  
ORDER BY AccountDefinitionEO.APPLICATION_ID
,AccountDefinitionEO.NAME