/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Billing%20Extensions%20-%20Billing%20Extension.sql $:
 * $Id: Manage Billing Extensions - Billing Extension.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjbBillextenEO.BILLING_EXTENSION_NAME RES_NAME
 ,pjbBillextenEO.PROCEDURE_NAME RES_PROCEDURE
 ,pjbBillextenEO.EXTENSION_DESC RES_DESCRIPTION
 ,DECODE(pjbBillextenEO.PREDEFINED_FLAG,'Y','Yes','No') RES_CREATED_BY_APPLICATION
 ,pjbBillextenEO.PROCESSING_ORDER RES_ORDER
 ,TO_CHAR(pjbBillextenEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(pjbBillextenEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
 ,DECODE(pjbBillextenEO.TRX_INDEPENDENT_FLAG,'Y','Yes','No') RES_TRANSACTION_INDEPENDENT
 ,(SELECT MEANING FROM FND_LOOKUPS
	WHERE LOOKUP_CODE = pjbBillextenEO.CALLING_PROCESS 
		AND LOOKUP_TYPE = 'PJB_BILL_EXT_CALL_PROCESS'
		) RES_CALL_PROCESS
 ,DECODE(pjbBillextenEO.BEFORE_PRE_PROCESS_FLAG,'Y','Yes','No') RES_BEFORE_BILLING_TRANSACTION
 ,DECODE(pjbBillextenEO.AFTER_DRAFT_CREATION_FLAG,'Y','Yes','No') RES_AFTER_INVOICE_AND_REVENUE_
 ,DECODE(pjbBillextenEO.BEFORE_DELETION_FLAG,'Y','Yes','No') RES_BEFORE_INVOICE_DELETION
 ,DECODE(pjbBillextenEO.AMT_REQD_FLAG,'Y','Yes','No') RES_AMOUNT
 ,DECODE(pjbBillextenEO.PERCENTAGE_REQD_FLAG,'Y','Yes','No') RES_PERCENTAGE
 ,(SELECT EVENT_TYPE_NAME FROM PJF_EVENT_TYPES_VL
	WHERE EVENT_TYPE_ID = pjbBillextenEO.DEFAULT_EVENT_TYPE_ID
		)RES_EVENT_TYPE
 ,(SELECT NAME FROM PJO_PLAN_TYPES_VL
	WHERE PLAN_TYPE_ID = pjbBillextenEO.DEFAULT_COST_PLAN_TYPE_ID
		)RES_COST_PLAN_TYPE
 ,pjbBillextenEO.DEFAULT_EVENT_DESCRIPTION RES_EVENT_DESCRIPTION
 ,pjbBillextenEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjbBillextenEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjbBillextenEO.CREATED_BY RSC_CREATED_BY
 ,pjbBillextenEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJB_BILLING_EXTENSIONS pjbBillextenEO
ORDER BY 1


