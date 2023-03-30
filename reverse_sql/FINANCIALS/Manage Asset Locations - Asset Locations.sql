/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=140##RES##LOC#
-- KFF_PREFIX_ALIAS=RES_LOCATION
-- KFF_COLUMN_NAME=SEGMENT

SELECT LocationEO.SEGMENT1                           AS RES_LOCATION1
,LocationEO.SEGMENT2                                 AS RES_LOCATION2
,LocationEO.SEGMENT3                                 AS RES_LOCATION3
,LocationEO.SEGMENT4                                 AS RES_LOCATION4
,LocationEO.SEGMENT5                                 AS RES_LOCATION5
,LocationEO.SEGMENT6                                 AS RES_LOCATION6
,LocationEO.SEGMENT7                                 AS RES_LOCATION7
,TO_CHAR(LocationEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,TO_CHAR(LocationEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_EFFECTIVE_END_DATE
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = LocationEO.ENABLED_FLAG
	),'No') AS RES_ENABLED
,LocationEO.STRUCTURE_INSTANCE_NUMBER RSC_EXTRA_COLUMN1
,LocationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LocationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LocationEO.CREATED_BY RSC_CREATED_BY
,LocationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_LOCATIONS LocationEO
ORDER BY RES_LOCATION1