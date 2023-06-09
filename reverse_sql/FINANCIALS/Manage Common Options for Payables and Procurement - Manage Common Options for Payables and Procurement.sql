/* ****************************************************************************
 * $Revision: 79273 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-09-01 12:02:31 +0700 (Thu, 01 Sep 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Common%20Options%20for%20Payables%20and%20Procurement%20-%20Manage%20Common%20Options%20for%20Payables%20and%20Procuremen $:
 * $Id: Manage Common Options for Payables and Procurement - Manage Common Options for Payables and Procurement.sql 79273 2022-09-01 05:02:31Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=FINANCIALS_SYSTEM_PARAMS_ALL

-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_LIAB/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_PREP/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_BILL/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_CONV/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_CO_0/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_DISC/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_MISC/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_FREI/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_PR_1/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_CURRENCY_CONVERSION_REALIZ/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_CURRENCY_CONVERSION_REAL_2/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_ONE_TIME_PAYMENTS_LIABILIT/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_ONE_TIME_PAYMENTS_EXPENSE/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_DEFAULT_DISTRIBUTIONS_RETA/GET_CODE_COMBINATION


select FAB.BU_NAME RES_BUSINESS_UNIT,
F.ACCTS_PAY_CODE_COMBINATION_ID RES_DEFAULT_DISTRIBUTIONS_LIAB,
F.PREPAY_CODE_COMBINATION_ID RES_DEFAULT_DISTRIBUTIONS_PREP,
F.FUTURE_DATED_PAYMENT_CCID RES_DEFAULT_DISTRIBUTIONS_BILL,
F.RATE_VAR_GAIN_CCID RES_DEFAULT_DISTRIBUTIONS_CONV,
F.RATE_VAR_LOSS_CCID RES_DEFAULT_DISTRIBUTIONS_CO_0,
F.DISC_TAKEN_CODE_COMBINATION_ID RES_DEFAULT_DISTRIBUTIONS_DISC,
F.MISC_CHARGE_CCID RES_DEFAULT_DISTRIBUTIONS_MISC,
F.FREIGHT_CODE_COMBINATION_ID RES_DEFAULT_DISTRIBUTIONS_FREI,
F.PREPAY_TAX_DIFF_CCID RES_DEFAULT_DISTRIBUTIONS_PR_1,
F.RETAINAGE_CODE_COMBINATION_ID RES_DEFAULT_DISTRIBUTIONS_RETA,
DECODE(F.LIABILITY_POST_LOOKUP_CODE,'BALANCING_SEGMENT','Primary balancing segment','ACCOUNT_SEGMENT_VALUE','All segments, except natural account','None') RES_AUTOMATIC_OFFSETS_OFFSET_S,
F.ONE_TIME_PAY_LIAB_CCID RES_ONE_TIME_PAYMENTS_LIABILIT,
F.ONE_TIME_PAY_EXPENSE_CCID RES_ONE_TIME_PAYMENTS_EXPENSE,
DECODE(F.MAKE_RATE_MANDATORY_FLAG,'Y','Yes','No') RES_CURRENCY_CONVERSION_REQUIR,
GLDAILYCONVERSIONTYPES.USER_CONVERSION_TYPE RES_CURRENCY_CONVERSION_CONVER,
F.GAIN_CODE_COMBINATION_ID RES_CURRENCY_CONVERSION_REALIZ,
F.LOSS_CODE_COMBINATION_ID RES_CURRENCY_CONVERSION_REAL_2,
DECODE(F.EXPENSE_ACCRUAL_CODE,'RECEIPT','At receipt','PERIOD END','Period end') RES_EXPENSE_ACCRUALS_ACCRUE_EX,
DECODE(F.GAPLESS_INV_NUM_FLAG,'Y','Yes','No') RES_SELF_BILLED_INVOICES_GAPLE,
F.BUYING_COMPANY_IDENTIFIER RES_SELF_BILLED_INVOICES_BUYIN,
TERRITORYPEO.TERRITORY_SHORT_NAME RES_LEGAL_ENTITY_INFORMATION_V,
F.VAT_REGISTRATION_NUM RES_LEGAL_ENTITY_INFORMATION_3,
LOCATIONDPEO.LOCATION_NAME RES_LEGAL_ENTITY_INFORMATION_B,
LOCATIONDPEO.INTERNAL_LOCATION_CODE RES_LEGAL_ENTITY_INFORMATION_4
,f.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,f.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,f.CREATED_BY  RSC_CREATED_BY
,f.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,f.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from FUSION.FINANCIALS_SYSTEM_PARAMS_ALL F,
FUSION.FUN_ALL_BUSINESS_UNITS_V FAB ,
FUSION.GL_DAILY_CONVERSION_TYPES GLDAILYCONVERSIONTYPES ,
FUSION.FND_TERRITORIES_VL TERRITORYPEO ,
(SELECT LOCATION_ID
	,LOCATION_NAME
	,LOCATION_CODE
	,INTERNAL_LOCATION_CODE
	FROM FUSION.HR_LOCATIONS_ALL_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) LocationDPEO
where F.ORG_ID = FAB.BU_ID
and F.DEFAULT_EXCHANGE_RATE_TYPE = GLDAILYCONVERSIONTYPES.CONVERSION_TYPE(+)
and F.VAT_COUNTRY_CODE = TERRITORYPEO.TERRITORY_CODE(+)
and F.BILL_TO_LOCATION_ID = LOCATIONDPEO.LOCATION_ID(+)

AND F.ACCTS_PAY_CODE_COMBINATION_ID IS NOT NULL
AND F.PREPAY_CODE_COMBINATION_ID IS NOT NULL

order by RES_BUSINESS_UNIT