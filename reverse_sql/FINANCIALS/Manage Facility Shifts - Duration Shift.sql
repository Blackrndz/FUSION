/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Duration%20Shift.sql $:
* $Id: Manage Facility Shifts - Duration Shift.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT Distinct Head.SHIFT_NAME          		RES_NAME,
	Head.SHIFT_DESC          		RES_DESCRIPTION,
	Head.SHORT_TXT           		RES_CODE,
 (case  when Head.DURATION_UOM_CODE = 'DAYS' then
				(Head.DURATION_MS_NUM)/1000/60/60/24
			 when Head.DURATION_UOM_CODE = 'HOURS' then
				(Head.DURATION_MS_NUM)/1000/60/60
			when 	Head.DURATION_UOM_CODE = 'MINUTES' then
				(Head.DURATION_MS_NUM)/1000/60
			else	
				(Head.DURATION_MS_NUM)/1000/60/60/24/7
	end ) RES_DURATION_VALUE,
	DECODE(Head.DURATION_UOM_CODE,'DAYS','Days','HOURS','Hours','MINUTES','Minutes','WEEKS','Weeks') 		RES_DURATION_UNIT,
	DECODE(Head.CATEGORY_CODE,'WORK_FROM_OFFICE','Work from office','WORK_FROM_HOME','Work from home') 		RES_CATEGORY,
	DECODE(Head.AVAILABILITY_CODE,'OFF_PERIOD','Off period','WORK_PERIOD','Work period')   						RES_PERIOD_TYPE
	,Head.LAST_UPDATED_BY                						RSC_LAST_UPDATED_BY
	,Head.LAST_UPDATE_DATE              							RSC_LAST_UPDATE_DATE
	,Head.CREATED_BY                    							RSC_CREATED_BY
	,Head.CREATION_DATE                 							RSC_CREATION_DATE
	,null RSC_LEDGER_ID
	,null RSC_CHART_OF_ACCOUNTS_ID
	,null RSC_BUSINESS_UNIT_ID
	,null RSC_LEGAL_ENTITY_ID
	,null RSC_ORGANIZATION_ID
	,null RSC_BUSINESS_GROUP_ID
	,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SHIFTS_VL Head
,ZMM_SR_SHIFT_DTLS Detail
where 	Head.SHIFT_ID = Detail.SHIFT_ID(+) 
and SHIFT_TYPE_CODE = 'DURATION'
ORDER BY Head.SHIFT_NAME
