/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2018-06-19 $:
 * $HeadURL:  $:
 * $Id: Manage Balance Forward Billing Cycles - Weekly.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select 
A.CYCLE_NAME                                                  RES_NAME,
A.DESCRIPTION                                                 RES_DESCRIPTION,
to_char(B.START_DATE,'DD-Mon-YYYY')                           RES_START_DATE,
(select meaning from fnd_lookups 
 where lookup_type = 'ORA_EGS_SCHEDULE_FREQUENCY' 
 and LOOKUP_CODE= B.CYCLE_FREQUENCY  )                        RES_FREQUENCY,
(  case B.CYCLE_FREQUENCY
   when 'DAILY' then
      (select REPEAT_DAILY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   when  'WEEKLY' then
      (select REPEAT_WEEKLY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   else   
        (select REPEAT_MONTHLY from AR_CONS_BILL_CYCLES_B where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   end
) as                                                          RES_REPEAT_EVERY,
decode(B.DAY_MONDAY,'Y','Yes','No')                      RES_DAY_OF_WEEK_MONDAY,
decode(B.DAY_TUESDAY,'Y','Yes','No')                     RES_DAY_OF_WEEK_TUESDAY,
decode(B.DAY_WEDNESDAY,'Y','Yes','No')                   RES_DAY_OF_WEEK_WEDNESDAY,
decode(B.DAY_THURSDAY ,'Y','Yes','No')                   RES_DAY_OF_WEEK_THURSDAY,
decode(B.DAY_FRIDAY,'Y','Yes','No')                      RES_DAY_OF_WEEK_FRIDAY,
decode(B.DAY_SATURDAY,'Y','Yes','No')                    RES_DAY_OF_WEEK_SATURDAY,
decode(B.DAY_SUNDAY ,'Y','Yes','No')                     RES_DAY_OF_WEEK_SUNDAY
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
and   B.CYCLE_FREQUENCY = 'WEEKLY'
and A.LANGUAGE = userenv('LANG')
order by B.CYCLE_FREQUENCY 