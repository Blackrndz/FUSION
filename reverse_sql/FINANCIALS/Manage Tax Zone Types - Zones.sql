/* ****************************************************************************
 * $Revision: 74941 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-11-02 13:32:51 +0700 (Mon, 02 Nov 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Zone%20Types%20-%20Zone%20Types.sql $:
 * $Id: Manage Tax Zone Types - Zone Types.sql 74941 2020-11-02 06:32:51Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT GeographyTypeEO.GEOGRAPHY_TYPE_NAME RES_ZONE_TYPE
,GeographiesE0.GEOGRAPHY_NAME RES_ZONE
,GeographiesE0.GEOGRAPHY_CODE RES_CODE
,GeographiesE0.TIMEZONE_CODE RES_TIME_ZONE
,TO_CHAR(GeographiesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(GeographiesE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,GeographiesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GeographiesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GeographiesE0.CREATED_BY RSC_CREATED_BY
,GeographiesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHY_TYPES_VL GeographyTypeEO
,HZ_GEOGRAPHIES GeographiesE0
WHERE GeographyTypeEO.GEOGRAPHY_USE = 'TAX'
AND GeographyTypeEO.GEOGRAPHY_TYPE = GeographiesE0.GEOGRAPHY_TYPE
AND GeographyTypeEO.GEOGRAPHY_USE = GeographiesE0.GEOGRAPHY_USE
ORDER BY GeographyTypeEO.GEOGRAPHY_TYPE_NAME
,GeographiesE0.GEOGRAPHY_NAME