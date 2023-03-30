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
,asGeographiesE0.GEOGRAPHY_ELEMENT1 RES_COUNTRY
,(SELECT GEOGRAPHY_TYPE_NAME
	FROM HZ_GEOGRAPHY_TYPES_VL
	WHERE GEOGRAPHY_TYPE = asGeographiesE0.GEOGRAPHY_TYPE 
	) RES_GEOGRAPHY_TYPE
,asGeographiesE0.GEOGRAPHY_NAME RES_GEOGRAPHY_NAME
,rangesE0.GEOGRAPHY_FROM RES_FROM_POSTAL_CODE
,rangesE0.GEOGRAPHY_TO RES_TO_POSTAL_CODE
,TO_CHAR(rangesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(rangesE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,rangesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rangesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rangesE0.CREATED_BY RSC_CREATED_BY
,rangesE0.CREATION_DATE RSC_CREATION_DATE
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
,HZ_RELATIONSHIPS relationsE0
,HZ_GEOGRAPHIES asGeographiesE0
,HZ_GEOGRAPHY_RANGES rangesE0
WHERE GeographyTypeEO.GEOGRAPHY_USE = 'TAX'
AND GeographyTypeEO.GEOGRAPHY_TYPE = GeographiesE0.GEOGRAPHY_TYPE
AND GeographyTypeEO.GEOGRAPHY_USE = GeographiesE0.GEOGRAPHY_USE
AND GeographiesE0.GEOGRAPHY_ID = relationsE0.SUBJECT_ID
AND relationsE0.RELATIONSHIP_CODE = 'PARENT_OF'
AND relationsE0.OBJECT_ID = asGeographiesE0.GEOGRAPHY_ID
AND GeographiesE0.GEOGRAPHY_ID = rangesE0.GEOGRAPHY_ID
AND asGeographiesE0.GEOGRAPHY_ID = rangesE0.MASTER_REF_GEOGRAPHY_ID
ORDER BY GeographyTypeEO.GEOGRAPHY_TYPE_NAME
,GeographiesE0.GEOGRAPHY_NAME