/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT APPLICATION_NAME
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
,DECODE(AcctAttrDetailE0.ASSIGNMENT_REQUIRED_CODE,'Y','Yes','No') RES_MANDATORY
,AcctAttrDetailE0.NAME RES_ACCOUNTING_ATTRIBUTE
,SourcesE0.NAME RES_SOURCE
,DECODE(AccountingAttrsE0.DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT
,AccountingAttrsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AccountingAttrsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AccountingAttrsE0.CREATED_BY RSC_CREATED_BY
,AccountingAttrsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_EVT_CLASS_ACCT_ATTRS AccountingAttrsE0
,XLA_ACCT_ATTRIBUTES_VL AcctAttrDetailE0
,XLA_SOURCES_VL SourcesE0
WHERE AccountingAttrsE0.ACCOUNTING_ATTRIBUTE_CODE = AcctAttrDetailE0.ACCOUNTING_ATTRIBUTE_CODE
AND AccountingAttrsE0.SOURCE_APPLICATION_ID = SourcesE0.APPLICATION_ID
AND AccountingAttrsE0.SOURCE_TYPE_CODE = SourcesE0.SOURCE_TYPE_CODE
AND AccountingAttrsE0.SOURCE_CODE = SourcesE0.SOURCE_CODE
ORDER BY 1,2,DECODE(AcctAttrDetailE0.ASSIGNMENT_REQUIRED_CODE,'Y',1,2),4