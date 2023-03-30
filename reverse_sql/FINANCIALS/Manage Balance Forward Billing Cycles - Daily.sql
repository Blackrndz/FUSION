/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2018-06-19 $:
 * $HeadURL:  $:
 * $Id: Manage Balance Forward Billing Cycles - Daily.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select 
A.CYCLE_NAME                        							RES_NAME,
A.DESCRIPTION                       							RES_DESCRIPTION,
to_char(B.START_DATE,'DD-Mon-YYYY')                            	RES_START_DATE,
(select meaning 
 from fnd_lookups 
 where lookup_type = 'ZMM_ACTIVITY_RECUR_TYPE_CD' 
 and LOOKUP_CODE= B.CYCLE_FREQUENCY 
)                                             					RES_FREQUENCY,
(  case B.CYCLE_FREQUENCY
   when 'DAILY' then
      (select REPEAT_DAILY from AR_CONS_BILL_CYCLES_B 
	   where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   when  'WEEKLY' then
      (select REPEAT_WEEKLY from AR_CONS_BILL_CYCLES_B 
	   where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   else   
        (select REPEAT_MONTHLY from AR_CONS_BILL_CYCLES_B 
		 where  BILLING_CYCLE_ID = B.BILLING_CYCLE_ID)
   end
) as  															RES_REPEAT_EVERY,
decode(B.SKIP_WEEKENDS,'Y','Yes','No')  						RES_EXCLUDE_SATURDAYS_AND_SUND
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
and   B.CYCLE_FREQUENCY = 'DAILY'
and A.LANGUAGE= userenv('LANG')
ORDER BY   B.BILLING_CYCLE_ID