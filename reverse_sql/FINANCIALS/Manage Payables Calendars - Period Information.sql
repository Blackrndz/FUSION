/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payables%20Calendars%20-%20Period%20Information.sql $:
 * $Id: Manage Payables Calendars - Period Information.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT QRSLT.CALENDAR_NAME RES_NAME
, QRSLT.CALENDAR_TYPE1 RES_CALENDAR_TYPE
, QRSLT.ENTERED_PERIOD_NAME RES_PERIOD_NAME_PREFIX
, QRSLT.PERIOD_YEAR RES_YEAR
, QRSLT.PERIOD_NUM RES_SEQUENCE
, TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
, TO_CHAR(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
, TO_CHAR(QRSLT.DUE_DATE,'DD-Mon-YYYY') RES_DUE_DATE
, QRSLT.period_name RES_PERIOD_NAME
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ApOtherPeriods.APPLICATION_ID
	,(SELECT meaning
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_TYPE = 'MODULE'
		AND LOOKUP_CODE   = FLEXFIELDDATAEO.CALENDAR_TYPE
		and language = userenv('LANG')
		) CALENDAR_TYPE1
	,ApOtherPeriods.PERIOD_NAME
	,ApOtherPeriods.LAST_UPDATE_DATE
	,ApOtherPeriods.LAST_UPDATED_BY
	,ApOtherPeriods.START_DATE
	,ApOtherPeriods.END_DATE
	,ApOtherPeriods.PERIOD_YEAR
	,ApOtherPeriods.PERIOD_NUM
	,ApOtherPeriods.ENTERED_PERIOD_NAME
	,ApOtherPeriods.DESCRIPTION
	,ApOtherPeriods.LAST_UPDATE_LOGIN	
	,ApOtherPeriods.CREATED_BY
	,ApOtherPeriods.CREATION_DATE
	,ApOtherPeriods.DUE_DATE
	,ApOtherPeriods.OBJECT_VERSION_NUMBER
	,ApOtherPeriods.CALENDAR_TYPE
	,ApOtherPeriods.CALENDAR_NAME
	,APOTHERPERIODS.PERIOD_ID
	FROM AP_OTHER_PERIODS APOTHERPERIODS
	,AP_OTHER_PERIOD_TYPES FLEXFIELDDATAEO
	WHERE APOTHERPERIODS.CALENDAR_NAME = FLEXFIELDDATAEO.CALENDAR_NAME
	AND APOTHERPERIODS.CALENDAR_TYPE   = FLEXFIELDDATAEO.CALENDAR_TYPE	
	) QRSLT
  ORDER BY RES_NAME
	,RES_SEQUENCE