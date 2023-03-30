/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Terms%20-%20Installments.sql $:
 * $Id: Manage Payment Terms - Installments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT   PaymentTermHeaderEO.name              RES_NAME
        , (Detail.SEQUENCE_NUM-1)                  RES_SEQUENCE
        , due_percent                          RES_DUE
        , due_amount                           RES_AMOUNT_DUE
        , calendar                             RES_CALENDAR
        , TO_CHAR(fixed_date,'DD-Mon-YYYY')    RES_FIXED_DATE
        , due_days                             RES_DAYS
        , due_day_of_month                     RES_DAY_OF_MONTH
        , due_months_forward                   RES_MONTHS_AHEAD
        --, DISCOUNT_PERCENT                     RES_FIRST_DISCOUNT_DISCOUNT
	    , (case  when (DISCOUNT_PERCENT >= 1 )   then
                      to_Char(DISCOUNT_PERCENT)
                 when (DISCOUNT_PERCENT is not null)  then
                      '0'||to_Char(DISCOUNT_PERCENT)
           end
          )RES_FIRST_DISCOUNT_DISCOUNT
        , DISCOUNT_DAYS                        RES_FIRST_DISCOUNT_DAYS
        , DISCOUNT_DAY_OF_MONTH                RES_FIRST_DISCOUNT_DAY_OF_MONT
        , DISCOUNT_MONTHS_FORWARD              RES_FIRST_DISCOUNT_MONTHS_AHEA
        , (case  when (discount_percent_2 >= 1 )   then
               to_Char(discount_percent_2)
           when (discount_percent_2 is not null)  then
               '0.'||to_Char(discount_percent_2)
           end
           )                  				   RES_SECOND_DISCOUNT_DISCOUNT
        , discount_days_2                      RES_SECOND_DISCOUNT_DAYS
        , discount_day_of_month_2              RES_SECOND_DISCOUNT_DAY_OF_MON
        , discount_months_forward_2            RES_SECOND_DISCOUNT_MONTHS_AHE
        , (case  when (discount_percent_3 >= 1 )   then
               to_Char(discount_percent_3)
           when (discount_percent_3 is not null)  then
               '0.'||to_Char(discount_percent_3)
           end
           )                 				   RES_THIRD_DISCOUNT_DISCOUNT
        , discount_days_3                      RES_THIRD_DISCOUNT_DAYS
        , discount_day_of_month_3              RES_THIRD_DISCOUNT_DAY_OF_MONT
        , discount_months_forward_3            RES_THIRD_DISCOUNT_MONTHS_AHEA
		, Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
		, Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
		, Detail.CREATED_BY  RSC_CREATED_BY
		, Detail.CREATION_DATE  RSC_CREATION_DATE
		, null RSC_LEDGER_ID
		, null RSC_CHART_OF_ACCOUNTS_ID
		, null RSC_BUSINESS_UNIT_ID
		, null RSC_LEGAL_ENTITY_ID
		, null RSC_ORGANIZATION_ID
		, null RSC_BUSINESS_GROUP_ID
		, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM      AP_TERMS_LINES Detail
        , AP_TERMS_VL PaymentTermHeaderEO
WHERE     PaymentTermHeaderEO.term_id = Detail.term_id
ORDER BY  PaymentTermHeaderEO.NAME
,Detail.SEQUENCE_NUM