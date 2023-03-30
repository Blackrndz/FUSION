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
,trxSourcesE0.DESCRIPTION RES_DESCRIPTION
,trxSourcesE0.BATCH_SIZE RES_PROCESSING_SET_SIZE
,trxSourcesE0.PRE_PROCESSING_EXTENSION RES_PREPROCESSING_EXTENSION
,trxSourcesE0.POST_PROCESSING_EXTENSION RES_POSTPROCESSING_EXTENSION
,trxSourcesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,trxSourcesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,trxSourcesE0.CREATED_BY RSC_CREATED_BY
,trxSourcesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_TXN_SOURCES_VL trxSourcesE0
ORDER BY trxSourcesE0.USER_TRANSACTION_SOURCE