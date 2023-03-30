/* ****************************************************************************
 * $Revision: 73970 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-04-15 21:09:13 +0700 (Wed, 15 Apr 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Positions%20-%20Position.sql $:
 * $Id: Manage Positions - Position.sql 73970 2020-04-15 14:09:13Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PER_POSITION_HIERARCHY_F 
 
SELECT (SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = positionsE0.BUSINESS_UNIT_ID 
	) RES_BUSINESS_UNIT
,positionsE0.NAME RES_NAME
,positionsE0.POSITION_CODE RES_CODE
,positionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,positionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,positionsE0.CREATED_BY RSC_CREATED_BY
,positionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT pos.*
	,posHiers.PARENT_POSITION_ID
	FROM (SELECT pos.*
		,ROW_NUMBER() OVER(PARTITION BY NAME ORDER BY CREATION_DATE) R1
		FROM HR_ALL_POSITIONS_F_VL pos
		) pos
	,(SELECT POSITION_ID
		,PARENT_POSITION_ID
		,EFFECTIVE_START_DATE
		,EFFECTIVE_END_DATE
		FROM PER_POSITION_HIERARCHY_F 
		WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		) posHiers
	WHERE pos.POSITION_ID = posHiers.POSITION_ID(+)
	AND pos.EFFECTIVE_END_DATE BETWEEN posHiers.EFFECTIVE_START_DATE(+) AND posHiers.EFFECTIVE_END_DATE(+)
	AND pos.R1 = 1
	--AND SYSDATE BETWEEN pos.EFFECTIVE_START_DATE AND pos.EFFECTIVE_END_DATE
	) positionsE0

ORDER BY DECODE(positionsE0.PARENT_POSITION_ID,NULL,1,2)
,positionsE0.NAME
,positionsE0.POSITION_CODE