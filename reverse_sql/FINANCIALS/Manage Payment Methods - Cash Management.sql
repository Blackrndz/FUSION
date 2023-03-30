/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT IbyPaymentMethodsTl.PAYMENT_METHOD_NAME RES_NAME
,IbyPaymentMethodsTl.PAYMENT_METHOD_CODE RES_CODE
,DECODE(IbyApplicablePmtMthds.PAYMENT_METHOD_CODE,NULL,'No','Yes') RES_ENABLE_FOR_USE_IN_CASH_MAN
,IbyPaymentMethodsTl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbyPaymentMethodsTl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbyPaymentMethodsTl.CREATED_BY RSC_CREATED_BY
,IbyPaymentMethodsTl.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl
,(SELECT PAYMENT_METHOD_CODE 
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	FROM IBY_APPLICABLE_PMT_MTHDS
	WHERE APPLICATION_ID = 260
	AND APPLICABLE_TYPE_CODE = 'PAY_PROC_TRXN_TYPE'
	) IbyApplicablePmtMthds
WHERE IbyPaymentMethodsTl.PAYMENT_METHOD_CODE = IbyApplicablePmtMthds.PAYMENT_METHOD_CODE(+)
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
ORDER BY IbyPaymentMethodsTl.PAYMENT_METHOD_NAME
,IbyPaymentMethodsTl.PAYMENT_METHOD_CODE