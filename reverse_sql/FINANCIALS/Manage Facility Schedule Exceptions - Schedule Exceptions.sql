/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT AvailabilityExceptionEO.AVL_EXCP_NAME RES_NAME
, AvailabilityExceptionEO.AVL_EXCP_DESC RES_DESCRIPTION
, AvailabilityExceptionEO.SHORT_TXT RES_CODE
, DECODE(AvailabilityExceptionEO.AVAILABILITY_CODE,'OFF_PERIOD','Off period','WORK_PERIOD','Work period')
	RES_PERIOD_TYPE
, DECODE(AvailabilityExceptionEO.WHOLE_DAY_FLAG,'Y',TO_CHAR(AvailabilityExceptionEO.START_DATE_TIME,'DD-Mon-YYYY'),
	TO_CHAR(AvailabilityExceptionEO.START_DATE_TIME,'DD-Mon-YYYY HH24:MI:SS')) RES_EXCEPTION_START
, DECODE(AvailabilityExceptionEO.WHOLE_DAY_FLAG,'Y',TO_CHAR(AvailabilityExceptionEO.END_DATE_TIME,'DD-Mon-YYYY'),
	TO_CHAR(AvailabilityExceptionEO.END_DATE_TIME,'DD-Mon-YYYY HH24:MI:SS')) RES_EXCEPTION_END
, DECODE(AvailabilityExceptionEO.CATEGORY_CODE,'HOLIDAY','Holiday','TRAINING','Training') RES_CATEGORY
, DECODE(AvailabilityExceptionEO.WHOLE_DAY_FLAG,'Y','Yes','No') RES_ALL_DAY
,AvailabilityExceptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AvailabilityExceptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AvailabilityExceptionEO.CREATED_BY RSC_CREATED_BY
,AvailabilityExceptionEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_AVL_EXCEPTIONS_VL AvailabilityExceptionEO
ORDER BY AvailabilityExceptionEO.AVL_EXCP_NAME
