/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-19 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Facility Shifts - Time Shift Details (Punch).sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT HEAD.SHIFT_NAME                                                                                              	RES_NAME,
(select LookupPEO.MEANING from  FND_LOOKUPS LOOKUPPEO 
 where LookupPEO.LOOKUP_TYPE = 'ZMM_SR_PUNCH_TYPE' 
 and LookupPEO.LOOKUP_CODE = DETAIL.SHIFT_DETAIL_CODE )                                                              	RES_SHIFT_DETAILS_NAME,
to_number(TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +(DETAIL.START_TIME_MS_NUM)/1000/60/60/24 , 'DD'))     	RES_DAY,
TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +(DETAIL.START_TIME_MS_NUM)/1000/60/60/24 , 'HH24:MI:SS')        	RES_START_TIME,
(case  when DETAIL.DURATION_UOM_CODE = 'DAYS' then
			(DETAIL.DURATION_MS_NUM)/1000/60/60/24
		 when DETAIL.DURATION_UOM_CODE = 'HOURS' then
			(DETAIL.DURATION_MS_NUM)/1000/60/60
		when 	DETAIL.DURATION_UOM_CODE = 'MINUTES' then
			(DETAIL.DURATION_MS_NUM)/1000/60
		else	
			(DETAIL.DURATION_MS_NUM)/1000/60/60/24/7
end )  																													RES_DURATION,
(select LOOKUPPEO.MEANING from FUSION.FND_LOOKUPS LOOKUPPEO 
 where LOOKUPPEO.LOOKUP_TYPE  = 'ZMM_SR_DURATION_UOM' 
 and LOOKUPPEO.lookup_code= DETAIL.DURATION_UOM_CODE)  																	RES_DURATION_UNIT,
(MIN_BREAK_MS_NUM)/1000/60              																				RES_MINIMUM_BREAK_MINUTES,
(MAX_BREAK_MS_NUM)/1000/60              																				RES_MAXIMUM_BREAK_MINUTES
,DETAIL.LAST_UPDATED_BY  		RSC_LAST_UPDATED_BY
,DETAIL.LAST_UPDATE_DATE  		RSC_LAST_UPDATE_DATE
,DETAIL.CREATED_BY  			RSC_CREATED_BY
,DETAIL.CREATION_DATE  			RSC_CREATION_DATE
,null 							RSC_LEDGER_ID
,null 							RSC_CHART_OF_ACCOUNTS_ID
,null 							RSC_BUSINESS_UNIT_ID
,null 							RSC_LEGAL_ENTITY_ID
,null 							RSC_ORGANIZATION_ID
,null 							RSC_BUSINESS_GROUP_ID
,null 							RSC_ENTERPRISE_ID
,null 							RSC_COUNTRY_ID
FROM  ZMM_SR_SHIFTS_VL  HEAD
      ,ZMM_SR_SHIFT_DTLS  DETAIL
where 	HEAD.SHIFT_ID = DETAIL.SHIFT_ID
AND     HEAD.SHIFT_DTL_TYPE_CODE = 'PUNCH'
order by RES_NAME ,RES_DAY,RES_START_TIME 
