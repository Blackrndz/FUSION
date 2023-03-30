/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Mileage.sql $:
* $Id: Manage Expense Fields by Category - Mileage.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT trxSourcesE0.USER_TRANSACTION_SOURCE RES_TRANSACTION_SOURCE
,trxDocumentsE0.DOCUMENT_NAME RES_DOCUMENT
,trxDocEntryE0.DOC_ENTRY_NAME RES_NAME
,trxDocEntryE0.DESCRIPTION RES_DESCRIPTION
,DECODE(trxDocEntryE0.ALLOW_ADJUSTMENTS_FLAG,'Y','Yes','No') RES_ALLOW_ADJUSTMENTS
,DECODE(trxDocEntryE0.ALLOW_REVERSAL_FLAG,'Y','Yes','No') RES_ALLOW_REVERSALS
,DECODE(trxDocEntryE0.MODIFY_INTERFACE_FLAG,'Y','Yes','No') RES_ALLOW_MODIFICATIONS_TO_UNP
,(SELECT MEANING
    FROM PJF_SYSTEM_LINKAGES_TL
    WHERE LANGUAGE = USERENV('LANG')
	AND FUNCTION = trxDocEntryE0.SYSTEM_LINKAGE_FUNCTION
    ) RES_EXPENDITURE_TYPE_CLASS
,DECODE(trxDocEntryE0.RELATED_ITEMS_FLAG,'Y','Yes','No') RES_CREATE_RELATED_ITEMS
,DECODE(trxDocEntryE0.CC_PROCESS_FLAG,'Y','Yes','No') RES_PROCESS_CROSS_CHARGE_TRANS
,trxDocEntryE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,trxDocEntryE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,trxDocEntryE0.CREATED_BY RSC_CREATED_BY
,trxDocEntryE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_TXN_SOURCES_VL trxSourcesE0
,PJF_TXN_DOCUMENT_VL trxDocumentsE0
,PJF_TXN_DOC_ENTRY_VL trxDocEntryE0
WHERE trxSourcesE0.TRANSACTION_SOURCE_ID = trxDocumentsE0.TRANSACTION_SOURCE_ID
AND trxDocumentsE0.DOCUMENT_ID = trxDocEntryE0.DOCUMENT_ID
ORDER BY trxSourcesE0.USER_TRANSACTION_SOURCE
,trxDocumentsE0.DOCUMENT_NAME
,trxDocEntryE0.DOC_ENTRY_NAME