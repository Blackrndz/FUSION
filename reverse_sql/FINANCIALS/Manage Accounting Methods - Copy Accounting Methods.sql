/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT
Null 	RES_SUBLEDGER_APPLICATION
,NULL 	RES_SOURCE_METHODS_NAME
,XlaAcctgMethodsVl.NAME RES_NAME
,XlaAcctgMethodsVl.ACCOUNTING_METHOD_CODE RES_SHORT_NAME
,XlaAcctgMethodsVl.DESCRIPTION RES_DESCRIPTION
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = XlaAcctgMethodsVl.ACCOUNTING_COA_ID
	) RES_CHART_OF_ACCOUNTS
,DECODE(XlaAcctgMethodsVl.ENABLED_FLAG,'Y','Yes','N','No') RES_STATUS
,XlaAcctgMethodsVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,XlaAcctgMethodsVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,XlaAcctgMethodsVl.CREATED_BY RSC_CREATED_BY
,XlaAcctgMethodsVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,XlaAcctgMethodsVl.ACCOUNTING_COA_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_ACCTG_METHODS_VL XlaAcctgMethodsVl
ORDER BY XlaAcctgMethodsVl.NAME