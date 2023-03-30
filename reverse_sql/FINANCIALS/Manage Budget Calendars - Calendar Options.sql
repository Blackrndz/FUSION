/* ****************************************************************************
 * $Revision: 77390 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2021-11-30 21:04:30 +0700 (Tue, 30 Nov 2021) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Calendar%20Options.sql $:
 * $Id: Manage Accounting Calendars - Calendar Options.sql 77390 2021-11-30 14:04:30Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 



SELECT  GlCalendars.USER_PERIOD_SET_NAME RES_NAME
,GlCalendars.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(GlCalendars.CALENDAR_START_DATE,'DD-Mon-YYYY') RES_START_DATE
,(SELECT GlLookups.MEANING
	FROM Fusion.GL_LOOKUPS GlLookups
	WHERE GlLookups.LOOKUP_TYPE = 'CAL_NON_ADJ_FREQ'
	AND GlLookups.LOOKUP_CODE   = GlCalendars.NON_ADJ_PERIOD_FREQ_CODE
	) RES_PERIOD_FREQUENCY
,DECODE(GlCalendars.CALENDAR_TYPE_CODE,'COMMITMENT','Yes','ACCOUNTING','No') RES_BUDGETARY_CONTROL_ONLY
,decode(GlCalendars.NON_ADJ_PERIOD_FREQ_CODE,'OTHER',GlCalendars.NON_ADJ_PERIODS_NUM ,'')   RES_NUMBER_OF_STANDARD_PERIODS
,(SELECT GlLookups.MEANING
	FROM Fusion.GL_LOOKUPS GlLookups
	WHERE GlLookups.LOOKUP_TYPE = 'CAL_ADJ_FREQ'
	AND GlLookups.LOOKUP_CODE   = GlCalendars.ADJ_PERIOD_FREQ_CODE
	) RES_ADJUSTING_PERIOD_FREQUENCY
,decode(GlCalendars.ADJ_PERIOD_FREQ_CODE,'OTHER',GlCalendars.ADJ_PERIODS_NUM,'')		RES_NUMBER_OF_ADJUSTING_PERIOD
,decode(GlCalendars.NON_ADJ_PERIOD_FREQ_CODE,'OTHER','',GlCalendars.USER_PERIOD_NAME_PREFIX) 			RES_USER_DEFINED_PREFIX
,decode(GlCalendars.NON_ADJ_PERIOD_FREQ_CODE,'OTHER','',(SELECT GlLookups.MEANING
	FROM Fusion.GL_LOOKUPS GlLookups
	WHERE GlLookups.LOOKUP_TYPE = 'CAL_PRD_SEPARATOR'
	AND GlLookups.LOOKUP_CODE   = GlCalendars.PERIOD_NAME_SEPARATOR_CODE
	)  ) RES_SEPARATOR
,decode(GlCalendars.NON_ADJ_PERIOD_FREQ_CODE,'OTHER','',(SELECT GlLookups.MEANING
	FROM Fusion.GL_LOOKUPS GlLookups
	WHERE GlLookups.LOOKUP_TYPE = 'CAL_PRD_FMT'
	AND GlLookups.LOOKUP_CODE   = GlCalendars.PERIOD_NAME_FORMAT_CODE
	) )  RES_FORMAT
,decode(GlCalendars.NON_ADJ_PERIOD_FREQ_CODE,'OTHER','',(SELECT PERIOD_NAME
	FROM Fusion.GL_PERIODS 
	WHERE PERIOD_SET_NAME = GlCalendars.USER_PERIOD_SET_NAME
	AND period_num        = 1
	AND period_year       = 1
	) ) RES_FIRST_PERIOD
,GlCalendars.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlCalendars.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlCalendars.CREATED_BY  RSC_CREATED_BY
,GlCalendars.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,null RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.GL_CALENDARS GlCalendars
WHERE GlCalendars.CALENDAR_TYPE_CODE = 'COMMITMENT'
ORDER BY GlCalendars.USER_PERIOD_SET_NAME