/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2018-06-19 $:
 * $HeadURL:  $:
 * $Id: Manage Balance Forward Billing Cycles - Monthly.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */



select 
A.CYCLE_NAME                                                  						RES_NAME,
A.DESCRIPTION                                                 						RES_DESCRIPTION,
to_char(B.START_DATE,'DD-Mon-YYYY')                           						RES_START_DATE,
(select meaning from fnd_lookups 
 where lookup_type = 'ORA_EGS_SCHEDULE_FREQUENCY' 
 and LOOKUP_CODE= B.CYCLE_FREQUENCY  )                        						RES_FREQUENCY,
(  case B.CYCLE_FREQUENCY
   when 'DAILY' then
      (select REPEAT_DAILY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   when  'WEEKLY' then
      (select REPEAT_WEEKLY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   else   
        (select REPEAT_MONTHLY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   end
) as                                                          						RES_REPEAT_EVERY,
decode(B.DAY_1,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_1,
decode(B.DAY_2 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_2,
decode(B.DAY_3 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_3,
decode(B.DAY_4 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_4,
decode(B.DAY_5 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_5,
decode(B.DAY_6 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_6,
decode(B.DAY_7 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_7,
decode(B.DAY_8 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_8,
decode(B.DAY_9 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_9,
decode(B.DAY_10 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_10,
decode(B.DAY_11 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_11,
decode(B.DAY_12 ,'Y','Yes','No')                                                      RES_DAY_OF_MONTH_DAY_12,
decode(B.DAY_13  ,'Y','Yes','No')                                                     RES_DAY_OF_MONTH_DAY_13,
decode(B.DAY_14,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_14,
decode(B.DAY_15,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_15,
decode(B.DAY_16,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_16,
decode(B.DAY_17,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_17,
decode(B.DAY_18,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_18,
decode(B.DAY_19,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_19,
decode(B.DAY_20,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_20,
decode(B.DAY_21,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_21,
decode(B.DAY_22,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_22,
decode(B.DAY_23,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_23,
decode(B.DAY_24,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_24,
decode(B.DAY_25,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_25,
decode(B.DAY_26,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_26,
decode(B.DAY_27,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_27,
decode(B.DAY_28,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_28,
decode(B.DAY_29,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_29,
decode(B.DAY_30,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_30,
decode(B.DAY_31,'Y','Yes','No')                                                       RES_DAY_OF_MONTH_DAY_31,

decode(B.LAST_DAY,'Y','Yes','No')                                               RES_LAST_DAY_OF_MONTH,
decode(B.SKIP_WEEKENDS,'Y','Yes','No')                                          RES_EXCLUDE_SATURDAYS_AND_SUND
,B.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,B.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,B.CREATED_BY  RSC_CREATED_BY
,B.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


from AR_CONS_BILL_CYCLES_TL  A
    , AR_CONS_BILL_CYCLES_B B
where A.BILLING_CYCLE_ID  = B.BILLING_CYCLE_ID
and   B.CYCLE_FREQUENCY = 'MONTHLY'
and A.LANGUAGE = userenv('LANG')
order by  B.BILLING_CYCLE_ID