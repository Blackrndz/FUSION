/* ****************************************************************************
* $Revision: 56739 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2016-07-20 09:09:10 +0700 (Wed, 20 Jul 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Segment%20Instance.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Segment Instance.sql 56739 2016-07-20 02:09:10Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT InvMaterialStatusesVl.STATUS_CODE RES_NAME
,DECODE(MtlStatusTransactionControl.IS_ALLOWED,1,MtlTransactionTypes.TRANSACTION_TYPE_NAME) RES_TRANSACTIONS_ALLOWED
,DECODE(MtlStatusTransactionControl.IS_ALLOWED,2,MtlTransactionTypes.TRANSACTION_TYPE_NAME) RES_TRANSACTIONS_DISALLOWED
,MtlStatusTransactionControl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlStatusTransactionControl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlStatusTransactionControl.CREATED_BY RSC_CREATED_BY
,MtlStatusTransactionControl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_MATERIAL_STATUSES_VL InvMaterialStatusesVl
,INV_STATUS_TRANSACTION_CONTROL MtlStatusTransactionControl
,INV_TRANSACTION_TYPES MtlTransactionTypes
WHERE InvMaterialStatusesVl.STATUS_ID = MtlStatusTransactionControl.STATUS_ID
AND MtlStatusTransactionControl.TRANSACTION_TYPE_ID = MtlTransactionTypes.TRANSACTION_TYPE_ID
ORDER BY InvMaterialStatusesVl.STATUS_CODE