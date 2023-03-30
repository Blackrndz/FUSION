/* ****************************************************************************
 * $Revision: 53935 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-03-25 16:18:48 +0700 (Fri, 25 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Statement%20Transaction%20Creation%20Rules%20-%20Manage%20Bank%20Statement%20Transaction%20Creation%20Rules.sql $:
 * $Id: Manage Bank Statement Transaction Creation Rules - Manage Bank Statement Transaction Creation Rules.sql 53935 2016-03-25 09:18:48Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FUN_TRX_TYPES_VL

SELECT TransactionTypePEO.TRX_TYPE_CODE RES_CODE
,TransactionTypePEO.TRX_TYPE_NAME RES_TRANSACTION_TYPE_NAME
,TransactionTypePEO.DESCRIPTION RES_DESCRIPTION
,DECODE(TransactionTypePEO.ALLOW_INVOICING_FLAG,'Y','Yes','No') RES_INVOICING
,DECODE(TransactionTypePEO.MANUAL_APPROVE_FLAG,'Y','Yes','No') RES_MANUAL_APPROVAL
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = TransactionTypePEO.EXCHANGE_RATE_TYPE 
	) RES_CONVERSION_RATE_TYPE
,DECODE(TransactionTypePEO.DFF_TRANSFER_FLAG,'Y','Yes','No') RES_DESCRIPTIVE_FLEXFIELD_TRAN
,DECODE(TransactionTypePEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,TransactionTypePEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TransactionTypePEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TransactionTypePEO.CREATED_BY RSC_CREATED_BY
,TransactionTypePEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_TRX_TYPES_VL TransactionTypePEO
ORDER BY TransactionTypePEO.TRX_TYPE_CODE