/* ****************************************************************************
 * $Revision: 78970 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-07-11 17:47:05 +0700 (Mon, 11 Jul 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Access%20Sets%20-%20Manage%20Data%20Access%20Sets.sql $:
 * $Id: Manage Data Access Sets - Manage Data Access Sets.sql 78970 2022-07-11 10:47:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT GlAccessSets.NAME  AS RES_NAME
,GlAccessSets.DESCRIPTION AS RES_DESCRIPTION
,(SELECT MEANING
	FROM GL_LOOKUPS
	WHERE LOOKUP_TYPE = 'GL_DAS_ACCESS_SET_TYPE'
	AND LOOKUP_CODE   = GlAccessSets.SECURITY_SEGMENT_CODE
	) AS RES_ACCESS_SET_TYPE
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE APPLICATION_ID          = 101
	AND KEY_FLEXFIELD_CODE        = 'GL#'
	AND STRUCTURE_INSTANCE_NUMBER = GlAccessSets.CHART_OF_ACCOUNTS_ID
	)                            AS RES_CHART_OF_ACCOUNTS
,GlCalendars.USER_PERIOD_SET_NAME AS RES_ACCOUNTING_CALENDAR
,(SELECT NAME
	FROM GL_LEDGERS
	WHERE LEDGER_ID = GlAccesssets.DEFAULT_LEDGER_ID
	) AS RES_DEFAULT_LEDGER
,GlAccessSets.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlAccessSets.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlAccessSets.CREATED_BY  RSC_CREATED_BY
,GlAccessSets.CREATION_DATE  RSC_CREATION_DATE
,GlAccessSets.DEFAULT_LEDGER_ID RSC_LEDGER_ID
,GlAccessSets.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM GL_ACCESS_SETS GlAccessSets
,GL_CALENDARS GlCalendars
WHERE GlAccessSets.ACCOUNTED_PERIOD_TYPE       = GlCalendars.PERIOD_TYPE
AND GlAccessSets.PERIOD_SET_NAME             = GlCalendars.PERIOD_SET_NAME
and GLACCESSSETS.AUTOMATICALLY_CREATED_FLAG = 'N'
ORDER BY GlAccessSets.Name