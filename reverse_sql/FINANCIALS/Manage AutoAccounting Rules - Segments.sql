/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoAccounting%20Rules%20-%20Segments.sql $:
 * $Id: Manage AutoAccounting Rules - Segments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT DISTINCT Head.BU_NAME 										RES_BUSINESS_UNIT
,Head.MEANING 														RES_ACCOUNT_TYPE
,flex_SEGMENTS.SEGMENT_NAME 										RES_SEGMENT
,(SELECT entity.MEANING
	FROM FUSION.AR_LOOKUPS entity
	WHERE lookup_type = 'AUTOGL_TABLES'
	AND lookup_code   = RaAccountDefaultSegments.TABLE_NAME
	) RES_VALUE_SOURCE
,RaAccountDefaultSegments.CONSTANT 									RES_CONSTANT_VALUE
,RaAccountDefaultSegments.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RaAccountDefaultSegments.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,RaAccountDefaultSegments.CREATED_BY  RSC_CREATED_BY
,RaAccountDefaultSegments.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,HEAD.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT BusinessUnitPEO.BU_ID
	,ArSystemParametersAll.ORG_ID
	,RaAccountDefaultsAll.GL_DEFAULT_ID
	,BusinessUnitPEO.BU_NAME
	,(SELECT entity.MEANING
		FROM FUSION.AR_LOOKUPS entity
		WHERE lookup_type = 'AUTOGL_TYPE'
		AND lookup_code   = RaAccountDefaultsAll.TYPE
		) MEANING
	FROM FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,FUSION.AR_SYSTEM_PARAMETERS_ALL ArSystemParametersAll
	,FUSION.RA_ACCOUNT_DEFAULTS_ALL RaAccountDefaultsAll
	WHERE BusinessUnitPEO.BU_ID = ArSystemParametersAll.ORG_ID
	AND BusinessUnitPEO.BU_ID   = RaAccountDefaultsAll.ORG_ID(+)
	) Head
,FUSION.FND_ID_FLEX_SEGMENTS flex_SEGMENTS
,FUSION.RA_ACCOUNT_DEFAULT_SEGMENTS RaAccountDefaultSegments
WHERE Head.GL_DEFAULT_ID                  = RaAccountDefaultSegments.GL_DEFAULT_ID
AND flex_SEGMENTS.APPLICATION_COLUMN_NAME = RaAccountDefaultSegments.SEGMENT
AND flex_SEGMENTS.ID_FLEX_CODE            = 'GL#'
AND flex_SEGMENTS.ENABLED_FLAG            = 'Y'
AND flex_SEGMENTS.ID_FLEX_NUM             =	( SELECT CHART_OF_ACCOUNTS_ID
															   FROM FUSION.GL_SETS_OF_BOOKS
																WHERE SET_OF_BOOKS_ID IN
																	(SELECT SET_OF_BOOKS_ID
																	FROM FUSION.AR_SYSTEM_PARAMETERS_ALL
																	WHERE ORG_ID = HEAD.ORG_ID
																	)
											)
ORDER BY Head.BU_NAME
,RES_VALUE_SOURCE