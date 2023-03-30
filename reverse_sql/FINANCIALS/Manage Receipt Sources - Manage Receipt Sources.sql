/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Sources%20-%20Manage%20Receipt%20Sources.sql $:
 * $Id: Manage Receipt Sources - Manage Receipt Sources.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT QRSLT.BU_NAME RES_BUSINESS_UNIT
,QRSLT.NAME1 RES_NAME
,QRSLT.DESCRIPTION RES_DESCRIPTION
,QRSLT.type RES_RECEIPT_SOURCE_TYPE
,QRSLT.VIEW_ATTR RES_RECEIPT_CLASS
,QRSLT.VIEW_ATTR_1 RES_RECEIPT_METHOD
,QRSLT.VIEW_ATTR_2 RES_BANK_ACCOUNT
,QRSLT.AUTO_BATCH_NUMBERING RES_BATCH_NUMBERING
,QRSLT.LAST_BATCH_NUM RES_BATCH_NUMBER_STARTS_AFTER
,TO_CHAR(QRSLT.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(QRSLT.end_date_active,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,QRSLT.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT BusinessUnitPEO.BU_NAME
	,ArBatchSourcesAll.BATCH_SOURCE_ID
	,ArBatchSourcesAll.OBJECT_VERSION_NUMBER
	,ArBatchSourcesAll.BATCH_SOURCE_SEQ_ID
	,ArBatchSourcesAll.NAME AS NAME1
	,ARBATCHSOURCESALL.DESCRIPTION
	,DECODE(ArBatchSourcesAll.TYPE,'AUTOMATIC','Automatic','Manual') TYPE
	,ArBatchSourcesAll.DEFAULT_RECEIPT_CLASS_ID
	,ArBatchSourcesAll.ORG_ID
	,ArReceiptClasses.RECEIPT_CLASS_ID
	,ArReceiptClasses.OBJECT_VERSION_NUMBER AS OBJECT_VERSION_NUMBER1
	,ArReceiptClasses.NAME                  AS NAME2
	,ArBatchSourcesAll.DEFAULT_RECEIPT_METHOD_ID
	,ARBATCHSOURCESALL.REMIT_BANK_ACCT_USE_ID
	,DECODE(ArBatchSourcesAll.AUTO_BATCH_NUMBERING,'AUTOMATIC','Automatic','Manual') AUTO_BATCH_NUMBERING
	,ArBatchSourcesAll.LAST_BATCH_NUM
	,ArBatchSourcesAll.START_DATE_ACTIVE
	,ArBatchSourcesAll.END_DATE_ACTIVE
	,ArBatchSourcesAll.DEFAULT_REMIT_BANK_ACCOUNT_ID
	,BusinessUnitPEO.BU_ID
	,(ArReceiptClasses.NAME) AS VIEW_ATTR
	,(SELECT name
		FROM FUSION.ar_receipt_methods
		WHERE RECEIPT_METHOD_ID = ARBATCHSOURCESALL.DEFAULT_RECEIPT_METHOD_ID
		) AS VIEW_ATTR_1
	,(SELECT bank_account_name
		FROM FUSION.ce_bank_accounts
		WHERE bank_account_id =
			(SELECT bank_account_id
			FROM FUSION.ce_bank_acct_uses_all
			WHERE bank_acct_use_id = ArBatchSourcesAll.remit_bank_acct_use_id
			)
		) AS VIEW_ATTR_2
	,ARBATCHSOURCESALL.LAST_UPDATED_BY
	,ArBatchSourcesAll.last_update_date
	,ARBATCHSOURCESALL.CREATED_BY
	,ArBatchSourcesAll.CREATION_DATE
	FROM FUSION.AR_BATCH_SOURCES_ALL ArBatchSourcesAll
	,FUSION.AR_RECEIPT_CLASSES ArReceiptClasses
	,FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,FUSION.AR_SYSTEM_PARAMETERS_ALL ArSystemParametersAll
	WHERE ArBatchSourcesAll.DEFAULT_RECEIPT_CLASS_ID = ArReceiptClasses.RECEIPT_CLASS_ID(+)
	AND BusinessUnitPEO.BU_ID                        = ArBatchSourcesAll.ORG_ID
	AND BusinessUnitPEO.BU_ID                        = ArSystemParametersAll.ORG_ID
	AND ARSYSTEMPARAMETERSALL.SITE_REQUIRED_FLAG    IS NOT NULL
	) QRSLT
ORDER BY RES_BUSINESS_UNIT
,RES_NAME