/* ****************************************************************************
 * $Revision: 60868 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-01-31 14:21:28 +0700 (Tue, 31 Jan 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Accounting Calendars - Additional Year.sql 60868 2017-01-31 07:21:28Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.USER_PERIOD_SET_NAME RES_NAME	
,CalendarYearE0.PERIOD_YEAR RES_BUDGET_YEAR_NUMBER
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (
	SELECT USER_PERIOD_SET_NAME
	,PERIOD_SET_NAME
	,CALENDAR_TYPE_CODE
	,ENTERPRISE_ID
	FROM Fusion.GL_CALENDARS GlCalendars
	) HEAD
,(SELECT PERIOD_YEAR
	,PERIOD_SET_NAME 
	,MAX(LAST_UPDATED_BY) RSC_LAST_UPDATED_BY
	,MAX(LAST_UPDATE_DATE) RSC_LAST_UPDATE_DATE
	,MAX(CREATED_BY) RSC_CREATED_BY
	,MAX(CREATION_DATE) RSC_CREATION_DATE
	FROM GL_PERIODS
	GROUP BY PERIOD_YEAR
	,PERIOD_SET_NAME
	) CalendarYearE0
WHERE HEAD.PERIOD_SET_NAME = CalendarYearE0.PERIOD_SET_NAME
AND HEAD.CALENDAR_TYPE_CODE = 'COMMITMENT'
ORDER BY 1,2