/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT IbyPaymentMethodsTl.PAYMENT_METHOD_NAME    RES_NAME
,IbyPaymentMethodsTl.PAYMENT_METHOD_CODE       		RES_CODE
,decode(detail.support_bills_payable_flag,'Y','Yes','No')						RES_USE_PAYMENT_METHOD_TO_ISSU
,detail.maturity_date_offset_days				RES_MATURITY_DATE_OVERRIDE
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl  
, IBY_PAYMENT_METHODS_B Detail
WHERE IbyPaymentMethodsTl.PAYMENT_METHOD_CODE = Detail.PAYMENT_METHOD_CODE
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
ORDER BY IbyPaymentMethodsTl.PAYMENT_METHOD_NAME