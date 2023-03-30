/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT DISTINCT (SELECT APPLICATION_NAME
	FROM XLA_SUBLEDGERS_TL
	WHERE APPLICATION_ID = AccountingAttrsE0.APPLICATION_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_SUBLEDGER_APPLICATION
,(SELECT NAME 
	FROM XLA_EVENT_CLASSES_TL
	WHERE EVENT_CLASS_CODE = AccountingAttrsE0.EVENT_CLASS_CODE
	AND APPLICATION_ID = AccountingAttrsE0.APPLICATION_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_EVENT_CLASS
,NULL RSC_LAST_UPDATED_BY
,NULL RSC_LAST_UPDATE_DATE
,NULL RSC_CREATED_BY
,NULL RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_EVT_CLASS_ACCT_ATTRS AccountingAttrsE0
ORDER BY 1,2