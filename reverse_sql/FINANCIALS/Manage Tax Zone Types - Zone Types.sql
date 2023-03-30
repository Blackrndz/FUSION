/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Zone%20Types%20-%20Zone%20Types.sql $:
 * $Id: Manage Tax Zone Types - Zone Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT GEOGRAPHY_TYPE_NAME AS RES_ZONE_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'HZ_GEO_POSTAL_CODE_RANGE_FLAG'
	AND LOOKUP_CODE   = POSTAL_CODE_RANGE_FLAG
	)  RES_LIMIT_BY_POSTAL_CODE_RANGE
,(CASE
	WHEN LIMITED_BY_GEOGRAPHY_ID IS NULL THEN 
		'World'
	ELSE
		'Bounded by country'
	END) RES_SELECT_BOUNDARY
,GeographyTypeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GeographyTypeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GeographyTypeEO.CREATED_BY RSC_CREATED_BY
,GeographyTypeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHY_TYPES_VL GeographyTypeEO
WHERE GeographyTypeEO.GEOGRAPHY_USE = 'TAX'
ORDER BY RES_ZONE_TYPE